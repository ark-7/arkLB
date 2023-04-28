#!usr/bin/sh
echo "Installing prerequisites"
sudo apt-get update
sudo apt install -y clang llvm autoconf libbpf-dev libelf-dev libpcap-dev gcc-multilib build-essential make linux-tools-common --fix-missing
sudo apt install -y linux-tools-generic linux-cloud-tools-generic
