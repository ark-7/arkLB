FROM ubuntu:latest
WORKDIR /app
COPY . .
RUN apt update -q 
RUN apt install -y clang llvm libelf-dev libpcap-dev gcc-multilib build-essential make linux-tools-common
ENTRYPOINT ["tail", "-f", "/dev/null"]
