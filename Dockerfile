FROM ubuntu:latest
WORKDIR /app
COPY . /app
RUN apt-get update && \
    apt-get install -y build-essential git cmake \
                       zlib1g-dev libevent-dev \
                       libelf-dev llvm \
                       clang libc6-dev-i386 wget tar \
                       nano libbpf-dev autoconf linux-tools-common \
                       libtool libssl-dev gcc apache2 apache2-utils 
RUN ln -s /usr/include/x86_64-linux-gnu/asm/ /usr/include/asm
RUN git submodule update --init --recursive
RUN git clone --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git && \
    cp -r linux/* /usr/include/linux/
RUN apt clean
EXPOSE 80 8084 8085
CMD ["apache2ctl", "-D", "FOREGROUND"]
