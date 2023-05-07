# arkLB

An eBPF/XDP load balancer for cloud and microservices

![License](https://img.shields.io/github/license/ark-7/arkLB?style=flat-square)
![Repo Size](https://img.shields.io/github/repo-size/ark-7/arkLB?style=flat-square)
![Last Commit](https://img.shields.io/github/last-commit/ark-7/arkLB?style=flat-square)
![Docker build](https://img.shields.io/docker/automated/aerox86/arklb?style=flat-square)

## Quick Start

[![Docker](https://img.shields.io/badge/Docker%20image-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/aerox86/arklb)

## Terms

Here are some of the links explaining the eBPF and XDP

- [eBPF](https://ebpf.io/)
- [XDP](https://www.iovisor.org/technology/xdp)

## Install guide

This project needs to be run in a linux environment as supported bpf tools are present in the linux kernel

Run the following commands to install the dependencies in your system

```bash
bash install.sh
```

Then run the following commands to compile the project. Make sure to change values in `Makefile.in` and `configure.ac` to your needs

```bash
bash start.sh
```

To stop the program, run the following command

```bash
# To stop running the XDP program
make clean
```

After compiling, run the `python hello.py` with `sudo` privileges to see the trace logs

**NOTE: Change your network interface in `Makefile` else the program may not work properly**

## Docker

If you have Docker installed in your system, you can workaround the project using the command

```bash
docker compose up
```

## Tools used

- bcc
- libbpf
- clang
- Terraform
- Python (for trace logs)
- Docker

## License

GPL 3.0
