// clang-format off
#include "vmlinux.h"
// clang-format on
#include "../libbpf/src/bpf_helpers.h"
#include "../libbpf/src/bpf_endian.h"

#define ETH_P_IP	0x0800
int k = 2;
#define MAX_COUNT 3
#define CLIENT 4
#define LB 5
unsigned char bytes[4] = {0,0,0,0};

unsigned int IP_ADDRESS(w,x,y,z) {
    uint res = ((256*256*256*w) + (256*256*x) + (256*y) + z);
    return res;
}

void print_ip(unsigned int ip)
{
    bytes[0] = ip & 0xFF;
    bytes[1] = (ip >> 8) & 0xFF;
    bytes[2] = (ip >> 16) & 0xFF;
    bytes[3] = (ip >> 24) & 0xFF;   
    //printf("%d.%d.%d.%d\n", bytes[3], bytes[2], bytes[1], bytes[0]);        
}

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

SEC("xdp_lb")
int ark_lb_xdp(struct xdp_md *ctx) {
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    bpf_printk("Heya! arkLB here!", sizeof("Heya! arkLB here!"));
    
    struct ethhdr *eth = data;
    if (data + sizeof(struct ethhdr) > data_end)
        return XDP_ABORTED;

    if (bpf_ntohs(eth->h_proto) != ETH_P_IP)
        return XDP_PASS;

    struct iphdr *iph = data + sizeof(struct ethhdr);
    if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) > data_end)
        return XDP_ABORTED;

    if (iph->protocol != IPPROTO_TCP) {
        bpf_printk("Got non-TCP packet", sizeof("Got non-TCP packet"));
        return XDP_PASS;
    }
        
    bpf_printk("Got TCP packet", sizeof("Got TCP packet"));
    bpf_printk("Source IP: %u", sizeof("Source IP: %u"), iph->saddr);
    // Change IP address here
    uint32_t ip = IP_ADDRESS(164,113,193,34);
    bpf_printk("Client IP: %u", sizeof("Client IP: %u"), ip);
    if (iph->saddr == IP_ADDRESS(164,113,193,34))
    {
        if(k == MAX_COUNT)
            k = 2;
        char be = k;

        if(bpf_ktime_get_ns() % 2) {
            be = k++;
        }
        bpf_printk("Got packet from client, sending to BE %d", sizeof("Got packet from client, sending to BE %d"), be);
        iph->daddr = IP_ADDRESS(127,0,0,be);
        eth->h_dest[5] = be;
    }
    else
    {
        iph->daddr = IP_ADDRESS(127,0,0,1);
        bpf_printk("Source IP is not equal. Passing...", sizeof("Source IP is not equal. Redirecting..."));
        eth->h_dest[5] = CLIENT;
    }
    iph->saddr = IP_ADDRESS(127,0,0,LB);
    eth->h_source[5] = LB;

    iph->check = iph_csum(iph);
    bpf_printk("Passing packet...", sizeof("Passing packet..."));
    return XDP_TX;
}

char _license[] SEC("license") = "GPL";
