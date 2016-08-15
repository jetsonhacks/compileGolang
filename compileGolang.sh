#!/bin/bash
# Compile Go (Golang) from source on the Jetson Dev Kit
# To build a version > go 1.5, a go 1.4 version is used to 
# bootstrap the compiler. Build 1.4 first:
# Testing grabbing 1.4
cd $HOME
git clone -b release-branch.go1.4 --single-branch https://github.com/golang/go.git $HOME/go1.4
cd go1.4/src
./make.bash
cd $HOME
# After go 1.4 is built, then the desired version can be built
git clone https://github.com/golang/go.git
cd go
# Latest stable is go 1.6
git checkout release-branch.go1.6
cd src
./all.bash
# Setup environment variables
echo "export GOROOT=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOROOT/bin" >> ~/.bashrc
# Issues with source bashrc
source ~/.bashrc
GOROOT=$HOME/go
PATH=$PATH:$GOROOT/bin



