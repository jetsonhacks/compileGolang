#!/bin/bash
# Compile Go (Golang) from source on the Jetson Dev Kit
# To build a version > go 1.5, a go 1.4 version is used to 
# bootstrap the compiler. The bootstrap is cross compiled from
# another machine, as aarch64 is not supported by 1.4
cd $HOME
tar xvjf compileGolang/go-linux-arm64-bootstrap.tbz
export GOROOT_BOOTSTRAP=$HOME/go-linux-arm64-bootstrap
cd $HOME
# After the bootstrap is copied, then the desired version can be built
git clone https://github.com/golang/go.git
cd go
# Latest stable is go 1.6
git checkout release-branch.go1.6
cd src
./all.bash
# Setup environment variables
echo "export GOROOT=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$HOME/go/bin" >> ~/.bashrc
# Issues with source bashrc
source ~/.bashrc
GOROOT=$HOME/go
PATH=$PATH:$GOROOT/bin



