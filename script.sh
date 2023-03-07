#!usr/bin/sh
echo "Installing prerequisites"
apt update
apt install -y clang llvm libelf-dev libpcap-dev gcc-multilib build-essential make linux-tools-common --fix-missing
