#include "xdp_kern.h"
#include "xdp_buzz.h"

#define IP_ADDRESS(x) (unsigned int)(172 + (17 << 8) + (0 << 16) + (x << 24))

struct {
    __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
    __uint(max_entries, 16);
    __type(key, int);
    __type(value, int);
} my_map SEC(".maps");

SEC("xdp_buzz")
int xdp_buzz_hello(struct xdp_md *ctx)
{
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    bpf_printk("Hey there, I'm XDP!");

    struct S trace;
    int ret;
    trace.time = bpf_ktime_get_ns();
    ret = bpf_perf_event_output(ctx, &my_map, 0, &trace, sizeof(trace));
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
        return XDP_PASS;

    bpf_printk("Got TCP packet from %x", iph->saddr);

    return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
