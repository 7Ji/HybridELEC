# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present 7Ji (pugokushin@gmail.com)

PKG_NAME="device-tree-mibox3"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/7Ji/device-trees-amlogic"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_UNPACK="linux"
PKG_LONGDESC="Device tree for Xiaomi mibox3"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

make_target() {
  # Enter kernel directory
  pushd $BUILD/linux-$(kernel_version) > /dev/null

  DTB_NAME="gxbb_p200_1G_mibox3"
  cp -f $PKG_DIR/$DTB_NAME.dtsi $PKG_DIR/$DTB_NAME.dts arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/

  # Compile device trees
  kernel_make ${DTB_NAME}.dtb
  cp arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/${DTB_NAME}.dtb $PKG_BUILD

  popd > /dev/null
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
  cp -a $PKG_BUILD/gxbb_p200_1G_mibox3.dtb $INSTALL/usr/share/bootloader/dtb.img
}
