#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate


# Custom
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
cp -f feeds/smpackage/.github/diy/default-settings package/emortal/default-settings/files/99-default-settings
rm -rf feeds/packages/net/{alist,adguardhome,brook,gost,mosdns,redsocks*,smartdns,trojan*,v2ray*,xray*}
rm -rf feeds/packages/luci/{luci-app-homeproxy,luci-app-openclash,luci-app-passwall}
rm -rf feeds/smpackage/luci-theme-design && git clone -b js --single-branch https://github.com/kenzok78/luci-theme-design feeds/smpackage/luci-theme-design
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
patch -p1 < "feeds/smpackage/.github/diy/patches/0004-luci-mod-status-firewall-disable-legacy-firewall-rul.patch"
cp -f feeds/smpackage/.github/diy/banner package/base-files/files/etc/banner
sed -i "s/%D %V, %C/immortalwrt $(date +'%m.%d') by qqsq/g" package/base-files/files/etc/banner
./scripts/feeds update -a && ./scripts/feeds install -a
