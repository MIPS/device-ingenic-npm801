#
# Copyright 2012 The Android Open Source Project
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

DEVICE_PACKAGE_OVERLAYS += device/ingenic/$(TARGET_BOARD_NAME)/overlay

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/ingenic/$(TARGET_BOARD_NAME)/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES := \
    mke2fs          \
    mke2fs_host     \
    e2fsck          \
    e2fsck_host     \
    mkfs.f2fs       \
    fsck.f2fs       \
    nand_flash_image

PRODUCT_PACKAGES += \
    hwcomposer.xb4780    \
    audio.primary.xb4780 \
    audio_policy.default \
    sensors.xb4780       \
    lights.xb4780        \
    libdmmu              \
    audio.a2dp.default   \
    libjzipu             \
    libdrm

#
# Now Building libxbomx packages/modules from source.
#
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libstagefright_hard_alume \
    libstagefright_hard_vlume \
    libstagefright_hard_x264hwenc \
    libOMX_Core

#
# WiFi support
#
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    wpa_supplicant \
    wpa_supplicant.conf \
    wificond

# Audio HAL
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl

# Bluetooth HAL
PRODUCT_PACKAGES += \
    libbt-vendor \
    android.hardware.bluetooth@1.0-impl

# Camera HAL
PRODUCT_PACKAGES += \
    camera.xb4780        \
    android.hardware.camera.provider@2.4-impl

# Gralloc HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.mapper@2.0-impl

# Keymaster HAL
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl

# Light HAL
PRODUCT_PACKAGES += \
    lights.npm801 \
    android.hardware.sensors@1.0-impl \
    android.hardware.light@2.0-impl

 # Memtrack HAL
 PRODUCT_PACKAGES += \
 android.hardware.memtrack@1.0-impl

# Power HAL
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-impl \
    power.xb4780

$(call inherit-product, hardware/ingenic/xb4780/libGPU/gpu.mk)

# Copy H263/MPEG4 Firmware (mpeg4_p1.bin) to /system/etc
#
$(call inherit-product, hardware/ingenic/xb4780/libxbomx/xbomx.mk)

# inherit from the non-open-source side, if present
$(call inherit-product-if-exists, vendor/ingenic/$(TARGET_BOARD_NAME)/$(TARGET_BOARD_NAME)-vendor.mk)

# configure gms
ifeq ($(WITH_GMS),true)
$(call inherit-product-if-exists, vendor/google/products/gms.mk)
PRODUCT_COPY_FILES += \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libAppDataSearch.so:/system/priv-app/GmsCore/lib/arm/libAppDataSearch.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libconscrypt_gmscore_jni.so:/system/priv-app/GmsCore/lib/arm/libconscrypt_gmscore_jni.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libgcastv2_base.so:/system/priv-app/GmsCore/lib/arm/libgcastv2_base.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libgcastv2_support.so:/system/priv-app/GmsCore/lib/arm/libgcastv2_support.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libgmscore.so:/system/priv-app/GmsCore/lib/arm/libgmscore.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libgoogle-ocrclient-v3.so:/system/priv-app/GmsCore/lib/arm/libgoogle-ocrclient-v3.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libjgcastservice.so:/system/priv-app/GmsCore/lib/arm/libjgcastservice.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libleveldbjni.so:/system/priv-app/GmsCore/lib/arm/libleveldbjni.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libNearbyApp.so:/system/priv-app/GmsCore/lib/arm/libNearbyApp.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libsslwrapper_jni.so:/system/priv-app/GmsCore/lib/arm/libsslwrapper_jni.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libwearable-selector.so:/system/priv-app/GmsCore/lib/arm/libwearable-selector.so \
    vendor/google/apps/GmsCore/lib/armeabi-v7a/libWhisper.so:/system/priv-app/GmsCore/lib/arm/libWhisper.so
endif

# ALSA mixer controls
PRODUCT_COPY_FILES += \
       $(LOCAL_PATH)/config/mixer_paths.xml:system/etc/mixer_paths.xml

TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/config/recovery.fstab

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    $(LOCAL_PATH)/config/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf                            \
    $(LOCAL_PATH)/config/init.board.rc:root/init.$(TARGET_BOARD_NAME).rc  \
    $(LOCAL_PATH)/config/init.board.usb.rc:root/init.$(TARGET_BOARD_NAME).usb.rc              \
    $(LOCAL_PATH)/config/init.recovery.board.rc:root/init.recovery.$(TARGET_BOARD_NAME).rc    \
    $(LOCAL_PATH)/config/fstab.board:root/fstab.$(TARGET_BOARD_NAME)      \
    $(LOCAL_PATH)/config/ueventd.board.rc:root/ueventd.$(TARGET_BOARD_NAME).rc                \
    $(LOCAL_PATH)/config/bt_addr:system/etc/firmware/bcm4330/bt_addr                          \
    $(LOCAL_PATH)/config/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Media Codecs List
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/media_profiles.xml:system/etc/media_profiles.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/config/media_codecs.xml:system/etc/media_codecs.xml

# modem configration
 PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/config/modems-conf.xml:system/etc/modems-conf.xml
# apn configration
 PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/config/apns-conf.xml:system/etc/apns-conf.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/IW/bcm4330/fw_bcm4330b2.bin:system/etc/firmware/brcm/brcmfmac4330-sdio.bin \
    $(LOCAL_PATH)/wifi/IW/bcm4330/nv_4330b2.txt:system/etc/firmware/brcm/brcmfmac4330-sdio.txt \
    $(LOCAL_PATH)/wifi/IW/bcm4330/TestRelease_BCM4330_0243.0000_Alltek_AW70_37p4M.hcd:system/etc/firmware/bcm4330/BCM4330.hcd

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/excluded-input-devices.xml:system/etc/excluded-input-devices.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

USE_CUSTOM_AUDIO_POLICY := 1
USE_XML_AUDIO_POLICY_CONF := 1

#Audio policy
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:system/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:system/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/config/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/config/audio_policy_volumes_drc.xml:system/etc/audio_policy_volumes_drc.xml \
    $(LOCAL_PATH)/config/manifest.xml:/vendor/manifest.xml \

# Key layout file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/gpio-keys.kl:/system/usr/keylayout/gpio-keys.kl

# Magiccode libakim
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/akim/libakim.so:/vendor/lib/libakim.so \
    $(LOCAL_PATH)/akim/magiccode_prefs.xml:/vendor/etc/magiccode_prefs.xml

PRODUCT_AAPT_CONFIG := normal large ldpi mdpi
PRODUCT_AAPT_PREF_CONFIG := ldpi
PRODUCT_LOCALES := en_US zh_CN zh_TW en_GB fr_FR it_IT de_DE es_ES cs_CZ ru_RU ko_KR ar_EG ja_JP

PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.sf.lcd_density=160                           \
    persist.sys.timezone=Asia/Shanghai              \
    testing.mediascanner.skiplist=/storage/host-udisk/,/storage/udisk/

ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.debuggable=1              \
    service.adb.root=1
endif

PRODUCT_PROPERTY_OVERRIDES +=    \
    wifi.interface=wlan0         \
    wifi.supplicant_scan_interval=15

PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.telephony.call_ring.multiple=0               \
    mobiled.libpath=/system/lib/libmobiled.so

# PRODUCT_PROPERTY_OVERRIDES +=    \
#     ro.board.hdmi.support=true                      \
#     ro.board.hdmi.device=HDMI,LCD,SYNC              \
#     ro.board.hdmi.hotplug.support=true              \

# PRODUCT_PROPERTY_OVERRIDES +=    \
#     ro.board.tvout.support=false                    \
#     ro.board.hasethernet=ethernet                   \
#     ro.board.haspppoe=pppoe

# H/W composition disabled
#PRODUCT_PROPERTY_OVERRIDES +=    \
    debug.sf.hw=1

PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.opengles.version=131072

#PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

#PRODUCT_PROPERTY_OVERRIDES += \
        net.dns1=8.8.8.8 \
        net.dns2=8.8.4.4

PRODUCT_PACKAGES += \
    Launcher3 \
    ChromePublic
