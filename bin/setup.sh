#!/bin/bash

usage() {
	echo "Usage: $0 [options]"
	echo ""
	echo "Setup host and target for development and testing."
	echo ""
	echo "Supported options:"
	echo "-h, --help                Show this help text"
        echo "-k, --kernel              Setup/Reset kernel sources"
        echo "-o, --host                Installs some system tools, the toolchain and kernel sources"
}

configure() {
        . config/configure.sh
}

install_system_tools() {
        echo "Setup system tools."
        sudo apt update
        sudo apt install -y bc build-essential git libncurses5-dev lzop perl libssl-dev
        sudo apt install -y flex bison
        sudo apt install -y gcc-aarch64-linux-gnu
        sudo apt install -y device-tree-compiler
        sudo apt install -y bmap-tools
        sudo apt install -y u-boot-tools
}

setup_toolchain() {
        echo "Setup tool chain."
        mkdir -p $BUILD_DIR
        cd $BUILD_DIR
        rm -Rf gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu
        wget -O gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&la=en&hash=0A37024B42028A9616F56A51C2D20755C5EBBCD7"
        tar xvf gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
        rm gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
}

setup_kernel() {
        echo "Setup kernel sources."
        mkdir -p $BUILD_DIR
        cd $BUILD_DIR
        rm -Rf $KERNEL_SOURCE
        git clone -b toradex_5.4-2.1.x-imx git://git.toradex.com/linux-toradex.git $KERNEL_SOURCE
        cp -Rv $SRC_DIR/* $KERNEL_SOURCE
}

while [ $# != 0 ] ; do
	option="$1"
	shift

	case "${option}" in
	-h|--help)
		usage
		exit 0
		;;
	-k|--kernel)
		configure
		setup_kernel
                exit 0
		;;
	-o|--host)
		configure
                install_system_tools
                setup_toolchain
		setup_kernel
                exit 0
		;;
	*)
		echo "Unknown option ${option}"
		exit 1
		;;
	esac
done

usage
exit 1