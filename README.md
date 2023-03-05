# buzzLB

A linux network load balancer made using eBPF and XDP

## Terms

Here are some of the links explaining the eBPF and XDP

[eBPF](https://ebpf.io/)

[XDP](https://www.iovisor.org/technology/xdp)

## Install guide

This project needs to be run in a linux environment as supported bpf tools are present in the linux kernel

Install required packages

```bash
sudo apt update

sudo apt install clang llvm libelf-dev libpcap-dev gcc-multilib build-essential make linux-tools-common

sudo apt install linux-tools-generic linux-cloud-tools-generic
```

Then run the commands in `sudo` mode

```bash
make 
make user
```

After compiling, run the `xdp_buzz_user` with `sudo` privileges

**NOTE: Change your network interface in `Makefile` else the program may not work properly**

_WARNING: Project not fully tested yet_


## Tools used

_NOTE: This may update from time to time_

- bcc
- libbpf
- clang
- llvm

## License

GPL 3.0
