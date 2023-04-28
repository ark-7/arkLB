# TARGET = xdp_lb
# TARGET = packetdrop
# TARGET = udp_lb
# TARGET = xdp_buzz

# For xdp_liz, make and also make user. The others don't have userspace programs

USER_TARGET = ${TARGET:=_user}
BPF_TARGET = ${TARGET:=_kern}
BPF_C = ${BPF_TARGET:=.c}
BPF_OBJ = ${BPF_C:.c=.o}

AM_LDFLAGS = $(EXTRA_LDFLAGS)

SUBDIRS = src

ACLOCAL_AMFLAGS = -I m4

# PKGCONFIG_USER comes from configure.ac
pkgconfigdir = $(PKGCONFIG_USER)
pkgconfig_DATA = \
	arklb.pc \
	$(NULL)
	
# Change network interface here
xdp-test: $(BPF_OBJ)
	bpftool net detach xdpgeneric dev wlo1
	rm -f /sys/fs/bpf/$(TARGET)
	bpftool prog load $(BPF_OBJ) /sys/fs/bpf/$(TARGET) --legacy
	bpftool net attach xdpgeneric pinned /sys/fs/bpf/$(TARGET) dev wlo1

user-local: $(USER_TARGET)

$(USER_TARGET): %: %.c  
	gcc -Wall $(CFLAGS) -Ilibbpf/src -Ilibbpf/src/include/uapi -Llibbpf/src -o $@  \
	 $< -l:libbpf.a -lelf -lz

$(BPF_OBJ): %.o: %.c
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
	    -O2 -emit-llvm -c -o ${@:.o=.ll} $<
	llc -march=bpf -filetype=obj -o $@ ${@:.o=.ll}
