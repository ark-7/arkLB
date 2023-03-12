#!/usr/bin/python

from bcc import BPF

# This may not work for 4.17 on x64, you need replace kprobe__sys_clone with kprobe____x64_sys_clone

# Below here is the line for BPF tracer
BPF(text='int kprobe__sys_clone(void *ctx) { return 0; }').trace_print()
