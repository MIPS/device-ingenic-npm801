# Copyright 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0

TARGET_ARCH := mips
TARGET_ARCH_VARIANT := mips32r2-fp-xburst
ARCH_MIPS_PAGE_SHIFT := 12
TARGET_CPU_ABI := mips
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_CPU_ABI_LIST_32_BIT := mips,armeabi,armeabi-v7a
TARGET_CPU_ABI_LIST := mips,armeabi,armeabi-v7a
TARGET_CPU_SMP := true
TARGET_FOR_CTS := false
TARGET_BOARD_PLATFORM := xb4780
TARGET_BOARD_PLATFORM_GPU := SGX540
TARGET_BOOTLOADER_BOARD_NAME := npm801
TARGET_AAPT_CHARACTERISTICS := tablet
PRODUCT_VENDOR_KERNEL_HEADERS := hardware/ingenic/xb4780/kernel-headers
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
ifeq ($(WITH_GMS),true)
  # If you change this number you also need to change the size of
  # partition 2 in sdcardinstaller/mksdcard-ext4.
  # 1835008000 == 1750 * 1024 * 1024
  BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1835008000
else
  # system size is 1280M
  BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1342177280
endif
# data size is 2G
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
# cache size is 256M
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 67108864
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_COPY_OUT_VENDOR := vendor

ENABLE_CPUSETS := true

USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
SF_START_GRAPHICS_ALLOCATOR_SERVICE := true

BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/ingenic/npm801/bluetooth

BOARD_KERNEL_BASE := 0x81F00000
BOARD_KERNEL_CMDLINE := mem=256M@0x0 mem=768M@0x30000000 console=ttyS3,57600n8 ip=off rw rdinit=/init

#modem configure
BOARD_MODEM1_MODULE := rda8851cl

#camera configure
BOARD_HAS_CAMERA := true
CAMERA_SUPPORT_VIDEOSNAPSHORT := false
CAMERA_VERSION := 1

# Wi-Fi hardware selection
PRODUCT_DEFAULT_WIFI_CHANNELS := 13

BOARD_WLAN_DEVICE := bcmdhd
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_FLASH_BLOCK_SIZE := 512
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
BOARD_HAVE_BLUETOOTH_BCM    := true
BOARD_HAVE_BLUETOOTH        := true
BOARD_BT_MODULE             := BCM4330
BT_BCM4330                  := true

TARGET_RECOVERY_UI_LIB := librecovery_ui_npm801
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

ifeq ($(HOST_OS),linux)
  ifeq ($(WITH_DEXPREOPT),)
    WITH_DEXPREOPT := true
  endif
endif

BOARD_SEPOLICY_DIRS +=  device/ingenic/npm801/sepolicy/vendor
BOARD_PLAT_PRIVATE_SEPOLICY_DIR := device/ingenic/npm801/sepolicy/private

DEVICE_MANIFEST_FILE := device/ingenic/npm801/config/manifest.xml
DEVICE_MATRIX_FILE   := device/ingenic/npm801/config/compatibility_matrix.xml
