#!/bin/sh

# Print everytime when a line is executed; exit if fails
set -x
set -e

# Initialise build environment
GOPATH=`pwd` go get -v -d golang.zx2c4.com/wireguard

# Define build configurations
OSARCHCFG="linux:amd64:wireguard-go windows:amd64:wireguard-go.exe darwin:amd64:wireguard-go-darwin linux:arm64:wireguard-go-linux-arm64"

# Build
OLD_PATH=`pwd`
NEW_PATH=`dirname $(find . -type f -name "go.mod" | grep "wireguard")`
cd ${NEW_PATH}
for CFG in ${OSARCHCFG}
do
	GOOS=`echo ${CFG} | cut -d ':' -f 1`
	GOARCH=`echo ${CFG} | cut -d ':' -f 2`
	GOPATH=${OLD_PATH}
	go build -v -o "${OLD_PATH}/`echo ${CFG} | cut -d ':' -f 3`"
done
