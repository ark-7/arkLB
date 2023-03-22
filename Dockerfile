FROM amd64/ubuntu:latest
WORKDIR /app
COPY . .
RUN apt update -q 
RUN apt install -y clang llvm libelf-dev libpcap-dev gcc-multilib build-essential make linux-tools-common wget tar
RUN wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.1.15.tar.xz
RUN tar -xvf linux-6.1.15.tar.xz
ENTRYPOINT ["tail", "-f", "/dev/null"]
