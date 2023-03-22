# arkLB

An L4 network load balancer based on eBPF and XDP

 __WARNING: Project not complete yet__

![License](https://img.shields.io/github/license/alphaX86/buzzLB?style=flat-square)
![Repo Size](https://img.shields.io/github/repo-size/alphaX86/buzzLB?style=flat-square)
![Last Commit](https://img.shields.io/github/last-commit/alphaX86/buzzLB?style=flat-square)
![Docker build](https://img.shields.io/docker/automated/aerox86/buzzlb?style=flat-square)
[![Docker](https://img.shields.io/badge/Docker%20image-%230db7ed.svg?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/r/aerox86/buzzlb)


## Terms

Here are some of the links explaining the eBPF and XDP

- [eBPF](https://ebpf.io/)
- [XDP](https://www.iovisor.org/technology/xdp)

## Install guide

This project needs to be run in a linux environment as supported bpf tools are present in the linux kernel

Install required packages

```bash
sudo apt update

sudo apt install clang llvm libelf-dev libbpf-dev libpcap-dev gcc-multilib build-essential make linux-tools-common

sudo apt install linux-tools-generic linux-cloud-tools-generic

# You may need to further install tools for your kernel version
sudo apt install linux-tools-$(uname -r) linux-cloud-tools-$(uname -r)
```
```

Then run the commands in `sudo` by entering in `su` mode 

```bash
sudo su
```

```bash
sh ./bootstrap # or ./bootstrap.sh
./configure
make
make install 

# To stop running the XDP program
make clean
```

After compiling, run the `python hello.py` with `sudo` privileges to see the trace logs

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
- Terraform
- Python
- Docker

## License

GPL 3.0
