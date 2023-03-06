#!usr/bin/sh
echo "Installing prerequisites"
apt update
apt install clang llvm libelf-dev libpcap-dev gcc-multilib build-essential make linux-tools-common
