#!/bin/sh

# Print everytime when a line is executed; exit if fails
set -x
set -e

# Initialise build environment
GOPATH=`pwd` go get -v -d golang.zx2c4.com/wireguard

# Build
GOPATH=`pwd` GOOS=linux GOARCH=amd64 go build -v -o wireguard-go `find . -type d -name "wireguard"`
