// clang-format off
#include "vmlinux.h"
// clang-format on
#include "../libbpf/src/bpf_helpers.h"
#include "../libbpf/src/bpf_endian.h"

// https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/if_ether.h#L52
#define ETH_P_IP	0x0800

#define IP_ADDRESS(x) (unsigned int)(172 + (17 << 8) + (0 << 16) + (x << 24))

#define BACKEND_A 2
#define BACKEND_B 3
#define CLIENT 4
#define LB 5

#ifndef MAX_BALANCER_COUNT
#define MAX_BALANCER_COUNT 128
#endif

// bpf_printk argument limits
#define _STRINGIFY(x) #x
#define STRINGIFY(x) _STRINGIFY(x)
#define LOC __FILE__ ":" STRINGIFY(__LINE__) ": "

const u32 zero = 0;  // array access index
const u32 balancer_max = MAX_BALANCER_COUNT;

// MAPS

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, u32);
  __type(value, u32);
  __uint(max_entries, 1);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} nonce SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __type(key, u32);
  __type(value, u32);
  __uint(max_entries, 1);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} size SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
  __type(key, u32);
  __type(value, u64);
  __uint(max_entries, MAX_BALANCER_COUNT);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} tcp_balancing_targets SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
  __type(key, u32);
  __type(value, u64);
  __uint(max_entries, MAX_BALANCER_COUNT);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} udp_balancing_targets SEC(".maps");

struct {
  __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
  __uint(key_size, sizeof(u32));
  __uint(value_size, sizeof(u32));
  __uint(max_entries, MAX_BALANCER_COUNT);
  __uint(pinning, LIBBPF_PIN_BY_NAME);
} perf_map SEC(".maps");

static __always_inline __u16
csum_fold_helper(__u64 csum)
{
    int i;
#pragma unroll
    for (i = 0; i < 4; i++)
    {
        if (csum >> 16)
            csum = (csum & 0xffff) + (csum >> 16);
    }
    return ~csum;
}


static __always_inline __u16
iph_csum(struct iphdr *iph)
{
    iph->check = 0;
    unsigned long long csum = bpf_csum_diff(0, 0, (unsigned int *)iph, sizeof(struct iphdr), 0);
    return csum_fold_helper(csum);
}

struct S
{
    unsigned long long time;
};

// HASHING

#define __jhash_final(a, b, c)		\
{						            \
	c ^= b; c -= rol32(b, 14);		\
	a ^= c; a -= rol32(c, 11);		\
	b ^= a; b -= rol32(a, 25);		\
	c ^= b; c -= rol32(b, 16);		\
	a ^= c; a -= rol32(c, 4);		\
	b ^= a; b -= rol32(a, 14);		\
	c ^= b; c -= rol32(b, 24);		\
}
  
#define JHASH_INITVAL 0xdeadbeef

static inline __u32 rol32(__u32 word, unsigned int shift) { return (word << (shift & 31)) | (word >> ((-shift) & 31)); }

static inline u32 hash(u32 ip_p1, u32 ip_p2, u32 ip_p3, u32 ip_p4) {
  u32 a, b, c, initval, *n;

  // Initialize nonce if not done already
  n = bpf_map_lookup_elem(&nonce, &zero);
  if (n == 0) {
    // Cannot happen as BPF_MAP_TYPE_ARRAY always resolves
    return SK_DROP;
  }

  if (*n == 0) {
    // TODO: Handle bpf_get_prandom_u32() == 0
    *n = bpf_get_prandom_u32();

#ifdef _LOG_DEBUG
    bpf_printk(LOC "Updating nonce to %x\n", *n);
#endif
  }

  initval = *n;

  initval += JHASH_INITVAL + (3 << 2);
  a = ip_p1 + ip_p2 + ip_p3 + ip_p4 + initval;
  b = initval;
  c = initval;

  __jhash_final(a, b, c);
  return c;
}

SEC("xdp_buzz_lb")
int buzz_lb_xdp(struct xdp_md *ctx) {
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    bpf_printk("Heya! XDP buzzLB here!");

    struct S trace;
    int ret;
    trace.time = bpf_ktime_get_ns();
    ret = bpf_perf_event_output(ctx, &perf_map, 0, &trace, sizeof(trace));
    if (ret)
        bpf_printk("perf_event_output failed: %d\n", ret);
    
    struct ethhdr *eth = data;
    if (data + sizeof(struct ethhdr) > data_end)
        return XDP_ABORTED;

    if (bpf_ntohs(eth->h_proto) != ETH_P_IP)
        return XDP_PASS;

    struct iphdr *iph = data + sizeof(struct ethhdr);
    if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) > data_end)
        return XDP_ABORTED;

    if (iph->protocol != IPPROTO_TCP)
        bpf_printk("Got non-TCP packet from %x", iph->saddr);

    bpf_printk("Got TCP packet from %x", iph->saddr);

    if (iph->saddr == IP_ADDRESS(CLIENT))
    {
        char be = BACKEND_A;
        if (bpf_ktime_get_ns() % 2)
            be = BACKEND_B;

        iph->daddr = IP_ADDRESS(be);
        eth->h_dest[5] = be;
    }
    else
    {
        iph->daddr = IP_ADDRESS(CLIENT);
        eth->h_dest[5] = CLIENT;
    }
    iph->saddr = IP_ADDRESS(LB);
    eth->h_source[5] = LB;

    iph->check = iph_csum(iph);

    return XDP_TX;
}

SEC("sk_reuseport/selector")
enum sk_action _selector(struct sk_reuseport_md *reuse) {
  enum sk_action action;
  struct iphdr ip;
  struct ipv6hdr ipv6;

  u32 key;
  // https://en.wikipedia.org/wiki/EtherType
  int is_ipv4 = reuse->eth_protocol == bpf_htons(ETH_P_IP);
  void *targets;

  // initialization -- resolve invalid indirect read from the stack (https://stackoverflow.com/questions/71529801/ebpf-bpf-map-update-returns-the-invalid-indirect-read-from-stack-error)
  __builtin_memset(&ipv6, 0, sizeof(struct ipv6hdr));
  __builtin_memset(&ip, 0, sizeof(struct iphdr));

  switch (reuse->ip_protocol) {
    case IPPROTO_TCP:
      targets = &tcp_balancing_targets;
      break;
    case IPPROTO_UDP:
      targets = &udp_balancing_targets;
      break;
    default:
#ifdef _LOG_DEBUG
      bpf_printk(LOC "Unsupported IPPROTO=%d\n", reuse->ip_protocol);
#endif
      return SK_DROP;
  }

  if(is_ipv4){
    bpf_skb_load_bytes_relative(reuse, 0, &ip, sizeof(struct iphdr), (u32)BPF_HDR_START_NET);
  } else {
    bpf_skb_load_bytes_relative(reuse, 0, &ipv6, sizeof(struct ipv6hdr), (u32)BPF_HDR_START_NET);
  }

  const u32 *balancer_count = bpf_map_lookup_elem(&size, &zero);
  if (!balancer_count || *balancer_count == 0) {  // uninitialized by userspace
    balancer_count = &balancer_max;
    bpf_map_update_elem(&size, &zero, balancer_count, BPF_ANY);
  }

#ifdef _LOG_DEBUG
  bpf_printk(LOC "Balancing across %d hash buckets\n", *balancer_count);
#endif

  // hash on the IP only
  if(is_ipv4){
    key = hash(__builtin_bswap32(ip.saddr),0,0,0) % *balancer_count;
  } else {
    key = hash(
      __builtin_bswap32(ipv6.saddr.in6_u.u6_addr32[0]),
      __builtin_bswap32(ipv6.saddr.in6_u.u6_addr32[1]),
      __builtin_bswap32(ipv6.saddr.in6_u.u6_addr32[2]),
      __builtin_bswap32(ipv6.saddr.in6_u.u6_addr32[3])
    ) % *balancer_count;
  }

#ifdef _LOG_DEBUG
  if(is_ipv4){
    bpf_printk(LOC "src4: %x, dest4: %x, key: %d\n", __builtin_bswap32(ip.saddr), __builtin_bswap32(ip.daddr), key);
  }else{
    bpf_printk(LOC "[Last 32b] src6: %x, dest6: %x, key: %d\n", __builtin_bswap32(ipv6.saddr.in6_u.u6_addr32[3]), __builtin_bswap32(ipv6.daddr.in6_u.u6_addr32[3]), key);
  }
#endif

  // side-effect sets dst socket if found
  if (bpf_sk_select_reuseport(reuse, targets, &key, 0) == 0) {
    action = SK_PASS;
#ifdef _LOG_DEBUG
    bpf_printk(LOC "=> action: pass\n\n");
#endif
  } else {
    action = SK_DROP;
#ifdef _LOG_DEBUG
    bpf_printk(LOC "=> action: drop\n\n");
#endif
  }

  return action;
}

char _license[] SEC("license") = "GPL";
