/**
 * Example of client using a eBPF loadbalancer.
 * This allows multiple client instances listening on the same IP/port and receiving consistent data
 * (all packets from one src IP will always go on the same collector)
 *
 * Usage: ./main <ip> <port> <index> <balancer_max>
 *
 * Example: launching 3 instances on the same ip port. The index is the index on the map to put the socket
 * and the balancer_max is how many max instances are in use.
 *
 *    ./main 192.168.1.17 10001 0 3
 *    ./main 192.168.1.17 10001 1 3
 *    ./main 192.168.1.17 10001 2 3
 */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>
#include <time.h>
#include <signal.h>
#include <sys/socket.h>
#include <linux/bpf.h>
#include "buzz_lb_user.h"

// if installed in machine
// #include <unyte-reuseport-loadbalancer/unyte_reuseport_user.h>

#define SK_BUFFER 20971520 // 20MB of socket buffer size
#define UDP_MAX_SIZE 65535

static __u64 time_get_ns(void)
{
    struct timespec ts;

    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1000000000ull + ts.tv_nsec;
}

static __u64 start_time;
static __u64 cnt;

#define MAX_CNT 100000ll

static void print_bpf_output(void *ctx, int cpu, void *data, __u32 size)
{
    struct S *trace = data;

    printf("%lld\n", trace->time);
}

int main(int argc, char *argv[])
{
  if(argc == 2) {
    printf("Using XDP mode...\n");
    struct perf_buffer_opts pb_opts = {};
    struct bpf_link *link = NULL;
    struct perf_buffer *pb;
    struct bpf_object *obj;
    int map_fd, ret = 0;
    FILE *f;

    obj = bpf_object__open_file("buzz_lb_kern.o", NULL);
    if (libbpf_get_error(obj)) {
      printf("Failed to open object file\n");
      exit(1);
    }

    int err = bpf_object__load(obj);
    if (err) {
      printf("Failed to load object file\n");
      exit(1);
    }

    struct bpf_program *prog = bpf_object__find_program_by_name(obj, "buzz_lb_xdp");
    if(!prog) {
      printf("Failed to pin program\n");
      exit(1);
    }

    int prog_fd = bpf_program__fd(prog);
    assert(prog_fd);
    // Run BPF program
    link = bpf_program__attach_xdp(prog, 1);
    if (libbpf_get_error(link)) {
      printf("Failed to attach program\n");
      exit(1);
    }
    f = popen("taskset 1 dd if=/dev/zero of=/dev/null", "r");
    (void)f;

    start_time = time_get_ns();


    cleanup:
    bpf_link__destroy(link);
    bpf_object__close(obj);
    return ret;
  }
  else if(argc == 5) {
    printf("Listening on %s:%s\n", argv[1], argv[2]);

  // Create a udp socket with default socket buffer
  int socketfd = buzz_create_udp_bound_socket(argv[1], argv[2], SK_BUFFER);

  // Attaching eBPF load balancer to socket
  int ret_attach = buzz_attach_ebpf_to_socket(socketfd, atoi(argv[3]), atoi(argv[4]), "", "buzz_lb_kern.o");

  if (ret_attach != 0)
    exit(1);

  struct sockaddr_storage peer_addr;
  socklen_t peer_addr_len = sizeof(struct sockaddr_storage);
  ssize_t nread;
  char buf[UDP_MAX_SIZE];

  while (1)
  {
    nread = recvfrom(socketfd, buf, UDP_MAX_SIZE, 0,
                     (struct sockaddr *)&peer_addr, &peer_addr_len);

    if (nread == -1)
      continue; // Ignore failed request

    char ip_src_canonical[100];
    printf("****** Message ******\n");
    if (peer_addr.ss_family == AF_INET)
    {
      printf("Received %ld bytes from %s:%u\n", (long)nread,
             inet_ntop(peer_addr.ss_family, &((struct sockaddr_in *)&peer_addr)->sin_addr.s_addr, ip_src_canonical, sizeof ip_src_canonical),
             ntohs(((struct sockaddr_in *)&peer_addr)->sin_port));
    }
    else
    {
      printf("Received %ld bytes from %s:%u\n", (long)nread,
             inet_ntop(peer_addr.ss_family, &((struct sockaddr_in *)&peer_addr)->sin_addr.s_addr, ip_src_canonical, sizeof ip_src_canonical),
             ntohs(((struct sockaddr_in6 *)&peer_addr)->sin6_port));
    }
    printf("Buffer: %.*s\n", (int)nread, buf);
    printf("**** End Message ****\n\n");
  }
  return 0;
  }
  else {
    printf("Error: arguments not valid\n");
    printf("Usage: ./main <ip> <port> <index> <loadbalance_max>\n");
    printf("Example: ./main 10.0.2.15 10001 0 5\n");
    printf("%d\n", argc);
    exit(1);
  }
  return 0;
}
