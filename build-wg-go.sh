#!/bin/sh

# Print everytime when a line is executed; exit if fails
set -x
set -e

# Initialise build environment
apk add --no-cache git
go get -v -d golang.zx2c4.com/wireguard

# Build
GOOS=linux GOARCH=amd64 go build -o wireguard-go
