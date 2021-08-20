#
# This policy configuration will be used by all products that
# inherit from PixelExperience
#

ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
ifeq ($(TARGET_HAS_FUSEBLK_SEPOLICY_ON_VENDOR),true)
BOARD_SEPOLICY_M4DEFS += board_excludes_fuseblk_sepolicy=true
endif
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    device/furry/sepolicy/common/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    device/furry/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    device/furry/sepolicy/common/dynamic \
    device/furry/sepolicy/common/system

ifneq ($(TARGET_HAL_POWER_RW_INPUT_DEVICE), true)
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    device/furry/sepolicy/common/dynamic_extra
endif
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/furry/sepolicy/common/dynamic \
    device/furry/sepolicy/common/dynamic_extra \
    device/furry/sepolicy/common/vendor
endif

# Selectively include legacy rules defined by the products
-include device/furry/sepolicy/legacy-common/sepolicy.mk
