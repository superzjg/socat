#! /bin/sh
source /jffs/softcenter/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
MODEL=$(nvram get productid)
DIR=$(cd $(dirname $0); pwd)
touch /tmp/kp_log.txt
if [ "$MODEL" == "GT-AC5300" ] || [ "$MODEL" == "GT-AX11000" ] || [ "$MODEL" == "GT-AC2900" ] || [ "$(nvram get merlinr_rog)" == "1" ];then
	ROG=1
elif [ "$MODEL" == "TUF-AX3000" ] || [ "$(nvram get merlinr_tuf)" == "1" ] ;then
	TUF=1
fi

# 安装插件
cd /tmp
find /jffs/softcenter/init.d/ -name "*socat*"|xargs rm -rf
cp -rf /tmp/socat/scripts/* /jffs/softcenter/scripts/
cp -rf /tmp/socat/webs/* /jffs/softcenter/webs/
cp -f /tmp/socat/uninstall.sh /jffs/softcenter/scripts/uninstall_socat.sh

chmod 755 /jffs/softcenter/scripts/socat_config.sh
chmod 755 /jffs/softcenter/scripts/socat_start.sh
chmod 755 /jffs/softcenter/scripts/socat_status.sh
chmod 755 /jffs/softcenter/scripts/uninstall_socat.sh

# 离线安装用
dbus set socat_version="$(cat $DIR/version)"
dbus set softcenter_module_socat_version="$(cat $DIR/version)"
dbus set softcenter_module_socat_description="Socat端口转发"
dbus set softcenter_module_socat_install="1"
dbus set softcenter_module_socat_name="socat"
dbus set softcenter_module_socat_title="Socat端口转发"

# 完成
echo_date "Socat端口转发插件安装完毕！"
rm -rf /tmp/socat* >/dev/null 2>&1
exit 0
