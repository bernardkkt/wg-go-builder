#!/bin/sh

# Print everytime when a line is executed; exit if fails
set -x
set -e

# Initialise build environment
GOPATH=`pwd` go get -v -d golang.zx2c4.com/wireguard

# Build
OLD_PATH=`pwd`
NEW_PATH=`dirname $(find . -type f -name "go.mod" | grep "wireguard")`
cd ${NEW_PATH}
GOPATH=${OLD_PATH} GOOS=linux GOARCH=amd64 go build -v -o "${OLD_PATH}/wireguard-go"
