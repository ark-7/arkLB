AM_LDFLAGS = $(EXTRA_LDFLAGS)

DEBUG_FLAGS = -D_LOG_DEBUG
ACLOCAL_AMFLAGS = -I m4

LINUX_SRC=$(LINUX_HEADERS)
LINUX_H=-I$(LINUX_SRC)/arch/x86/include -I$(LINUX_SRC)/arch/x86/include/generated -I$(LINUX_SRC)/include -I$(LINUX_SRC)/arch/x86/include/uapi -I$(LINUX_SRC)/arch/x86/include/generated/uapi -I$(LINUX_SRC)/include/uapi -I$(LINUX_SRC)/include/generated/uapi
EBPF_CLDFLAGS=-fcolor-diagnostics -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -g -fPIC -g -O2 -D__KERNEL__ -D__TARGET_ARCH_x86 --target=bpf -Wall -Wno-macro-redefined -D__BPF_TRACING__

vmlinux.h:
	bpftool btf dump file /sys/kernel/btf/vmlinux format c > $@

buzz_lb_kern.o: buzz_lb_kern.c vmlinux.h
	clang $(LINUX_H) $(EBPF_CLDFLAGS) $(DEBUG_FLAGS) -o $@ -c $<

all: buzz_lb_kern.o

buzz_lb_kern_odir = $(libdir)
buzz_lb_kern_o_DATA = \
	buzz_lb_kern.o \
	$(NULL)

buzzincludedir = $(includedir)/buzz-loadbalancer
buzzinclude_HEADERS = 		\
    buzz_lb_user.h  \
    $(NULL)

bin_PROGRAMS = main udp_lb_user

main_SOURCES = main.c buzz_lb_user.c
main_CFLAGS = -I$(srcdir)/../../src -Wextra -Wall -ansi -g -std=c11 -D_GNU_SOURCE -fPIC -pthread $(DEBUG_FLAGS)

udp_lb_SOURCES = udp_lb_user.c
udp_lb_CFLAGS = -I$(srcdir)/../../src -Wextra -Wall -ansi -g -std=c11 -D_GNU_SOURCE -fPIC -pthread $(DEBUG_FLAGS)

lib_LTLIBRARIES = libbuzz-loadbalancer.la

libbuzz_loadbalancer_la_SOURCES = \
    buzz_lb_user.c           \
    buzz_lb_user.h           \
    $(NULL)

libbuzz_loadbalancer_la_CFLAGS = -Wextra -Wall -ansi -g -std=c11 -D_GNU_SOURCE -fPIC $(DEBUG_FLAGS)

install:
	clang -S \
		-g \
	    -target bpf \
	    -D __BPF_TRACING__ \
	    -Ilibbpf/src\
	    -Wall \
	    -Wno-unused-value \
	    -Wno-pointer-sign \
	    -Wno-compare-distinct-pointer-types \
	    -Werror \
	    -O2 -emit-llvm -c -o xdp_kern.ll xdp_kern.c
	llc -march=bpf -filetype=obj -o xdp_kern.o xdp_kern.ll	
	
	rm -f /sys/fs/bpf/xdp_lb	
	echo "Setting up veth interface...Change interface in Makefile if you need"
	ip link add type veth
	bpftool net detach xdpgeneric dev wlo1
	bpftool prog load xdp_kern.o /sys/fs/bpf/xdp_lb --legacy
	bpftool net attach xdpgeneric pinned /sys/fs/bpf/xdp_lb dev wlo1		
	gcc -Wall -Ilibbpf/src -Ilibbpf/src/include/uapi -Llibbpf/src -o main buzz_lb_main.c -l:libbpf.a -lelf -lz	
	gcc -Wall -Ilibbpf/src -Ilibbpf/src/include/uapi -Llibbpf/src -o udp_main udp_lb_user.c -l:libbpf.a -lelf -lz	

clean:
	rm -f /sys/fs/bpf/xdp_buzz_lb
	rm -f /sys/fs/bpf/xdp_lb
	bpftool net detach xdpgeneric dev wlo1 
	ip link set veth1 xdpgeneric off

