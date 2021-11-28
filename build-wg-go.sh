#!/bin/sh

# Print everytime when a line is executed; exit if fails
set -x
set -e

# Initialise build environment
GOPATH=`pwd` go get -v -d golang.zx2c4.com/wireguard

# Build
OSARCHCFG="linux:amd64:wireguard-go windows:amd64:wireguard-go.exe darwin:amd64:wireguard-go-darwin"
OLD_PATH=`pwd`
NEW_PATH=`dirname $(find . -type f -name "go.mod" | grep "wireguard")`
cd ${NEW_PATH}
for CFG in ${OSARCHCFG}
do
	GOPATH=${OLD_PATH} GOOS=`echo ${CFG} | cut -d ':' -f 1` GOARCH=`echo ${CFG} | cut -d ':' -f 2` go build -v -o "${OLD_PATH}/`echo ${CFG} | cut -d ':' -f 1`"
done
