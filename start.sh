#!/bin/bash
echo "Starting arkLB... standby..."
echo "Please update configure.ac and Makefile.in before hand... This script will resume within 10 seconds"
sleep 10
sudo sh ./bootstrap
sleep 1
sudo ./configure
sleep 0.5
sudo make
sleep 0.5
sudo make install
