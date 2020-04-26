# main project for rtd1295
ARCH := arm64
ARM_CPU := cortex-a53
TARGET := rtd1295

CHIP_ID ?= rtd1295
CUSTOMER_ID ?= demo
CHIP_TYPE ?= 0002
PRJ ?= 1296_force_emmc_nS_nE

NAS_ENABLE ?= 1
NAS_DUAL ?= 0
LK_FW_LOAD ?= 1
HW_MCP ?= 1
JTAG_DEBUG ?= 0
FW_TABLE_SIGN ?= 0

# FLASH TYPE : EMMC_FLASH / SPI_FLASH / NAND_FLASH
FLASH_TYPE ?= EMMC_FLASH
ANDROID_REBOOT_CMD := 1

# Market ID for LK, Kpublic_FW, Kpublic_TEE
MARKET_ID ?= 0

# VMX: build Verimatrix dvrbot and bootloader.tar
# in case, this option doesn't support vmx 3rd party build
VMX ?= 0

# if VMX BL build supporting 3RD party, you can select to build the 3rd party bl or vmx bl
# To select the 3rd party boot loader : 0 to enable, 1 to disable
VMX_3RD_PARTY ?= 0

# To select the vmx bl boot loader : 0 to enable, 1 to disable
VMX_BL ?= 0

# Disable Uart Rx: 0 to enable, 1 to disable
DISABLE_UART_RX ?= 0

#PWM setting
PWM_0_PIN_0 := 0
PWM_0_PIN_1 := 0
PWM_1_PIN_0 := 0
PWM_1_PIN_1 := 0
PWM_2_PIN_0 := 0
PWM_2_PIN_1 := 0
PWM_3_PIN_0 := 0
PWM_3_PIN_1 := 0

#IR setting
IR_PROTOCOL ?= 1
IR_SCANCODE_MASK ?= 0x00FF0000
IR_WAKEUP_SCANCODE ?= 0x18
IR_CUS_MASK ?= 0x0000FFFF
IR_CUS_CODE ?= 0x7F80

# 1295/1296 USB GPIO Setting
USB_GPIO_SETTING := 1
# define 1295 USB GPIO control
# Port 0, DRD, TYPE_C
USB_PORT0_GPIO_TYPE := ISOGPIO
USB_PORT0_GPIO_NUM := 1
USB_PORT0_TYPE_C_RD_GPIO_TYPE := ISOGPIO
USB_PORT0_TYPE_C_RD_GPIO_NUM := 34
# Port 1, xhci u2 host
USB_PORT1_GPIO_TYPE := GPIO
USB_PORT1_GPIO_NUM := 19
# Port 2, ehci u2 host
USB_PORT2_GPIO_TYPE := GPIO
USB_PORT2_GPIO_NUM := 19
# Port 3, xhci u3 host only for 1296
USB_PORT3_GPIO_TYPE := No_DEFINE
USB_PORT3_GPIO_NUM := 0

# pmic command
USE_PMIC_G2227 := 1

# define 1296 USB GPIO control
# Port 0, DRD, TYPE_C
RTD1296_USB_PORT0_GPIO_TYPE := ISOGPIO
RTD1296_USB_PORT0_GPIO_NUM := 1
RTD1296_USB_PORT0_TYPE_C_RD_GPIO_TYPE := ISOGPIO
RTD1296_USB_PORT0_TYPE_C_RD_GPIO_NUM := 34
# Port 1, xhci u2 host
RTD1296_USB_PORT1_GPIO_TYPE := ISOGPIO
RTD1296_USB_PORT1_GPIO_NUM := 31
# Port 2, ehci u2 host
RTD1296_USB_PORT2_GPIO_TYPE := ISOGPIO
RTD1296_USB_PORT2_GPIO_NUM := 31
# Port 3, xhci u3 host only for 1296
RTD1296_USB_PORT3_GPIO_TYPE := ISOGPIO
RTD1296_USB_PORT3_GPIO_NUM := 32

# For Fastboot
USB_FASTBOOT_SETTING := 1
FASTBOOT_BUFFER_ADDR := 0x28000000
FASTBOOT_BUFFER_MAX_SIZE := 0x6400000 # 100MB
FASTBOOT_FW_IMG_UPDATE_ADDR := 0x30000000
FASTBOOT_FW_IMG_UPDATE_MAX_SIZE := 0x6400000 # 100MB

ifeq ($(NAS_ENABLE),1)
KERNEL_LOADADDR := 0x03000000
FDT_LOADADDR := 0x02100000
ROOTFS_LOADADDR := 0x02200000
AUDIO_LOADADDR := 0x01b00000
  ifeq ($(FLASH_TYPE), NAND_FLASH)
  FACTORY_BLOCKS := 4
  endif # FLASH_TYPE
else #!NAS_ENABLE
KERNEL_LOADADDR := 0x03000000
FDT_LOADADDR := 0x02100000
ROOTFS_LOADADDR := 0x02200000
AUDIO_LOADADDR := 0x0F900000
endif

HEAP_START := 0x12000000
HEAP_SIZE := 0x08000000
FACTORY_START := 0x220000
FACTORY_SIZE := 0x400000

WITH_KERNEL_VM=0
WITH_CPP_SUPPORT=true
WITH_LINKER_GC := 0

MODULES += \
	app/rtkboot \
	app/fatload \
	external/lib/ve_test \
	external/lib/factory \
	external/lib/mincrypt \
	external/lib/rtkfdt \
	external/lib/tar \
	external/lib/xyzmodem \
	external/lib/mp_tool \
	external/lib/i2c \
	external/lib/pmic \
	external/lib/cpufreq \
	external/lib/eeprom \
	external/lib/ping \
	external/lib/tftp_client \
	external/lib/fastboot \
	lib/aes \
	lib/aes/test \
	lib/cksum \
	lib/debugcommands \
	lib/libm \
	lib/sysparam \
	lib/version

GLOBAL_DEFINES += \
	COUNTER_FREQUENCY=27000000 \
	SYSPARAM_ALLOW_WRITE=1 \
	BSP_REALTEK=1 \
	SLAVE_CPU_SPIN_TABLE \
	RTK_BCB_IN_FACTORY \
	HDMITX_HPD_IGPIO_NUM=6 \
	HDMITX_MODE=1 \
	CONFIG_DPTX_HPD_IGPIO_NUM=7 \
	DPTX_MODE=0 \
	DEFAULT_TV_SYSTEM=25 \
	ENABLE_PANIC_SHELL=1 \
	CUSTOM_DEFAULT_STACK_SIZE=8192 \
	JTAG_DEBUG=$(JTAG_DEBUG)


ifeq ($(JTAG_DEBUG),0)
GLOBAL_DEFINES += INSTALL_BUTTON_GPIO_NUM=8
endif
