#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("xdp_drop_custom")
int xdp_drop(struct xdp_md *ctx)
{
  return XDP_DROP;
}
char _license[] SEC("license") = "GPL";
