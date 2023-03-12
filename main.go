package main

import (
	"log"
	"net"
	"os"
	"os/signal"
	"syscall"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"
)

func main() {
	sig := make(chan os.Signal, 1)
	signal.Notify(sig, os.Interrupt, syscall.SIGTERM)

	coll, err := ebpf.LoadCollection("src/xdp_kern.o")
	if err != nil {
		log.Fatal(err)
	}

	// Change interface here...
	ifce, err := net.InterfaceByName("veth1")
	if err != nil {
		log.Fatal(err)
	}

	l, err := link.AttachXDP(link.XDPOptions{
		Program:   coll.Programs["buzz_lb_xdp"],
		Interface: ifce.Index,
	})

	if err != nil {
		log.Fatal(err)
	}
	defer l.Close()

	<-sig
}