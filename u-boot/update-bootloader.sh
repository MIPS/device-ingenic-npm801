#!/bin/bash
#
# Copyright (c) 2017 MIPS Technologies
# Author: Dragan Cecavac <dragan.cecavac@mips.com>
#

set -e
tmpDir=`mktemp -d`

cleanup()
{
	rm -rf ${tmpDir}
	trap - EXIT INT TERM
}
trap cleanup EXIT INT TERM

die()
{
	echo "$@" >&2
	exit 1
}

readonly ubootPrebuiltDir="$ANDROID_BUILD_TOP/device/ingenic/npm801/u-boot"
#check for U-Boot prebuilt dir
[ ! -z "${ANDROID_BUILD_TOP}" ] || die "ANDROID_BUILD_TOP has not been initialized"
[ -e "${ubootPrebuiltDir}" ] || die "U-Boot prebuilt directory '${ubootPrebuiltDir}' does not exist"

readonly ubootSPL=${ubootPrebuiltDir}/u-boot-spl.bin
[ -e "${ubootSPL}" ] || die "U-Boot SPL image '${ubootSPL}' not found"


# Ingenic Bootloader Updater requires padding after SPL
dd bs=1024 count=16 if=/dev/zero of=${tmpDir}/zeroes
cat ${ubootSPL} ${tmpDir}/zeroes > ${tmpDir}/bootloader

echo "Updating bootloader"
sudo ${ubootPrebuiltDir}/ingenic-bootloader-updater --boot=${tmpDir}/bootloader
