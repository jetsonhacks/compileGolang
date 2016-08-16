# compileGolang
Compile Go (Golang) for NVIDIA Jetson TK1

<b>Building Go Toolchain</b>

For versions later that Go 1.5, a version of Go 1.4 is needed to bootstrap the Go toolchain.

<b>Jetson TK1</b>
On the Jetson TK1, Go 1.4 can be built natively. Executing the shell file:

./compileGolang.sh

Will download and build Go 1.4 in the $HOME/go1.4 directory. Next the script will download
Go (switches to version 1.6, the latest stable version as of this writing) and then builds to Go toolchain.
In addition, the script sets the $GOROOT to point to the 1.6 toolchain, as well as adds the binary to $PATH.


<b>Jetson TX1 32 bit</b>
The Jetson TX1 uses an ARM 64 bit processor which is not supported natively by the Go 1.4 compiler. Another issue
is that while the Linux kernel is 64 bit on the TX1, the user space is 32 bit. 

Fortunately the Go environment has a built in cross compiler which allows people to build bootstrap environments.
In the case of 'aarch64' (or 'arm64' as it is referred to by Go), you can build a bootstrap environment from a Go 
system with a working 1.4 compiler. 

In the src directory of the Go toolchain, there is a script called bootstrap.bash which builds a bootstrap for different architectures.

When run as (for example)
 #
 #	GOOS=linux GOARCH=arm bootstrap.bash
 #
 # this script cross-compiles a toolchain for that GOOS/GOARCH
 # combination, leaving the resulting tree in ../../go-${GOOS}-${GOARCH}-bootstrap.
 # That tree can be copied to a machine of the given target type
 # and used as $GOROOT_BOOTSTRAP to bootstrap a local build.
 
On the 32 bit TX1 in particular, the Go toolchain is built as 'arm', and the host architecture is set as 'arm'.
This makes the program available to run in 32 bit space.
 
The file go-linux-arm-bootstrap.tbz is the bootstrap used, generated on an Ubuntu x86 PC.
The compileGolangArm32 script first untars the bootstrap and sets it as the $GOROOT_BOOTSTRAP
The script sets up some compiler environment variables:

export GOARCH=arm
export GOARM=7
# Make Go for 32 bit
export GOHOSTARCH=arm

Next the script will download Go (switches to version 1.6, the latest stable version as of this writing) and then
builds the Go toolchain.
In addition, the script sets the $GOROOT to point to the 1.6 toolchain, as well as adds the binary to $PATH.


<b>Jetson TX1 64 bit</b>
