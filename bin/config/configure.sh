#/bin/bash
#

WORKING_DIR=$(dirname $PWD)
BIN_DIR=$WORKING_DIR/bin

SRC_DIR=$WORKING_DIR/src
BUILD_DIR=$WORKING_DIR/build
KERNEL_SOURCE=$BUILD_DIR/linux-toradex

DTB_FILE=imx8mm-verdin-wifi-v1.1-dev.dtb

export CROSS_COMPILE=aarch64-none-linux-gnu-
export PATH=$BUILD_DIR/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin/:$PATH
export DTC_FLAGS="-@"
export ARCH=arm64

TARGET_IP=verdin-imx8mm
TARGET_NAME=verdin-imx8mm
TARGET_USER=root
TARGET_SHELL="ssh $TARGET_USER@$TARGET_IP"