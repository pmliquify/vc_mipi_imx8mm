#!/bin/bash

usage() {
	echo "Usage: $0 [options]"
	echo ""
	echo "Flash kernel image, modules, device tree, and test tools to the target."
	echo ""
	echo "Supported options:"
        echo "-a, --all                 Flash kernel image, modules and device tree"
        echo "-d, --dt                  Flash device tree"
        echo "-h, --help                Show this help text"
        echo "-k, --kernel              Flash kernel image"
        echo "-r, --reboot              Reboot after flash."
        echo "-m, --modules             Flash kernel modules"
}

configure() {
        . config/configure.sh
}

flash_kernel() {
        echo "Flash kernel ..."
        scp $KERNEL_SOURCE/arch/arm64/boot/Image.gz $TARGET_USER@$TARGET_IP:/boot
}

flash_device_tree() {
        echo "Flash device tree ..."
        scp $KERNEL_SOURCE/arch/arm64/boot/dts/freescale/$DTB_FILE $TARGET_USER@$TARGET_IP:/boot/$DTB_FILE
}

reboot_target() {
        if [[ -n ${reboot} ]]; then
                $TARGET_SHELL /sbin/reboot
        fi
}

reboot=

while [ $# != 0 ] ; do
	option="$1"
	shift

	case "${option}" in
	-a|--all)
		configure
                flash_kernel
                flash_device_tree
                reboot_target
                exit 0
		;;
        -d|--dt)
                configure
                flash_device_tree
                reboot_target
                exit 0
		;;
	-h|--help)
		usage
		exit 0
		;;
	-k|--kernel)
		configure
		flash_kernel
                reboot_target
                exit 0
		;;
        -r|--reboot)
                reboot=1
                ;;
	*)
		echo "Unknown option ${option}"
		exit 1
		;;
	esac
done

usage
exit 1