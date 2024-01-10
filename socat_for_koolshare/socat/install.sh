#! /bin/sh
source /koolshare/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
# MODEL=$(nvram get productid)
DIR=$(cd $(dirname $0); pwd)

# 安装插件
cd $DIR
find /koolshare/init.d/ -name "*socat*"|xargs rm -rf
cp -rf $DIR/scripts/* /koolshare/scripts/
cp -rf $DIR/webs/* /koolshare/webs/
cp -rf $DIR/res/* /koolshare/res/
cp -f $DIR/uninstall.sh /koolshare/scripts/uninstall_socat.sh

chmod 755 /koolshare/scripts/socat_config.sh
chmod 755 /koolshare/scripts/socat_start.sh
chmod 755 /koolshare/scripts/socat_status.sh
chmod 755 /koolshare/scripts/uninstall_socat.sh

# 离线安装用
dbus set socat_version="$(cat $DIR/version)"
dbus set softcenter_module_socat_version="$(cat $DIR/version)"
dbus set softcenter_module_socat_description="Socat 端口转发"
dbus set softcenter_module_socat_install="1"
dbus set softcenter_module_socat_name="socat"
dbus set softcenter_module_socat_title="Socat端口转发"

# 完成
echo_date "Socat端口转发插件安装完毕！"
rm -rf $DIR/* >/dev/null 2>&1
exit 0
