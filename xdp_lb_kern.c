#include "xdp_lb_kern.h"

#define IP_ADDRESS(x) (unsigned int)(172 + (17 << 8) + (0 << 16) + (x << 24))

#define BACKEND_A 2
#define BACKEND_B 3
#define BACKEND_C 4
#define CLIENT 5
#define LB 6

SEC("xdp_lb")
int xdp_load_balancer(struct xdp_md *ctx)
{
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    bpf_printk("got a packet! Standby...");

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

    if (iph->saddr == IP_ADDRESS(CLIENT))
    {
        char be = BACKEND_A;
        if (bpf_ktime_get_ns() % 2)
            be = BACKEND_B;
        else if (bpf_ktime_get_ns() % 4)
            be = BACKEND_C;

        iph->daddr = IP_ADDRESS(be);
        eth->h_dest[6] = be;
    }
    else
    {
        iph->daddr = IP_ADDRESS(CLIENT);
        eth->h_dest[6] = CLIENT;
    }
    
    iph->saddr = IP_ADDRESS(LB);
    eth->h_source[6] = LB;

    iph->check = iph_csum(iph);

    return XDP_TX;
}

char _license[] SEC("license") = "GPL";
