#!/bin/sh

# Print everytime when a line is executed; exit if fails
set -x
set -e

# Initialise build environment
GOPATH=`pwd` go get -v -d golang.zx2c4.com/wireguard

# Build
IFS=' ' read -r -a OSARCH <<< "linux:amd64:wireguard-go windows:amd64:wireguard-go.exe darwin:amd64:wireguard-go-darwin"
OLD_PATH=`pwd`
NEW_PATH=`dirname $(find . -type f -name "go.mod" | grep "wireguard")`
cd ${NEW_PATH}
for config in "${OSARCH[@]}"
do
	IFS=':' read -r -a item <<< "$config"
	GOPATH=${OLD_PATH} GOOS=${item[0]} GOARCH=${item[1]} go build -v -o "${OLD_PATH}/${item[2]}"
done
