# buzzLB

An L4 network load balancer based on eBPF and XDP

 __WARNING: Project not complete yet__

[![Docker](https://img.shields.io/badge/docker%20image-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/aerox86/buzzlb)


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

## Docker

If you have Docker installed in your system, you can workaround the project using the command

```bash
docker compose up
```

## Tools used

_NOTE: This may update from time to time_

- bcc
- libbpf
- clang
- llvm

## License

GPL 3.0
