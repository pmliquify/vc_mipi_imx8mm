#!/bin/bash

usage() {
	echo "Usage: $0 [options]"
	echo ""
	echo "Build kernel image, modules, device tree, u-boot script and test tools."
	echo ""
	echo "Supported options:"
        echo "-a, --all                 Build kernel image, modules and device tree"
        echo "-d, --dt                  Build device tree"
        echo "-h, --help                Show this help text"
        echo "-k, --kernel              Build kernel image"
}

configure() {
        . config/configure.sh
}

patch_kernel() {
        echo "Patching driver sources into kernel sources ..."
        cp -Ruv $SRC_DIR/* $KERNEL_SOURCE
}

configure_kernel() {
        cd $KERNEL_SOURCE
        make -j$(nproc) defconfig
}

build_kernel() {
        echo "Build kernel ..."
        cd $KERNEL_SOURCE
        make -j$(nproc) Image.gz
}

build_device_tree() {
        echo "Build device tree ..."
        cd $KERNEL_SOURCE
        make -j$(nproc) freescale/$DTB_FILE
}

while [ $# != 0 ] ; do
	option="$1"
	shift

	case "${option}" in
	-a|--all)
		configure
                patch_kernel
                configure_kernel
                build_kernel
                build_device_tree
                exit 0
		;;
        -d|--dt)
		configure
                patch_kernel
                configure_kernel
                build_device_tree
                exit 0
		;;
	-h|--help)
		usage
		exit 0
		;;
	-k|--kernel)
		configure
                patch_kernel
                configure_kernel
		build_kernel
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