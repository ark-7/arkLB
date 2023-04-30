#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/in.h>
#include <linux/ip.h>
#include <linux/tcp.h>

#define NUM_SERVERS 3

struct bpf_map_def SEC("maps") server_index = {
    .type = BPF_MAP_TYPE_HASH,
    .key_size = sizeof(__u32),
    .value_size = sizeof(__u32),
    .max_entries = NUM_SERVERS,
};

SEC("xdp_lb")
int xdp_lb(struct xdp_md *ctx) {
    void* data_end = (void*)(long)ctx->data_end;
    void* data = (void*)(long)ctx->data;
    struct ethhdr *eth = data;
    struct iphdr *ip = data + sizeof(*eth);
    struct tcphdr *tcp = data + sizeof(*eth) + sizeof(*ip);

    if (tcp->syn) {
        // Get the destination IP address to use as a key
        __u32 index = ip->daddr % NUM_SERVERS;

        // Set the output interface based on the server index
        __u32 *out_index = bpf_map_lookup_elem(&server_index, &index);
        if (out_index) {
            return bpf_redirect(*out_index, 0);
        }
    }

    return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
