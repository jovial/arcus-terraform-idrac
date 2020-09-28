#!/bin/bash
set -x

# Need ibstat to work
sleep 60

export NEED_REBOOT=0

LINK_TYPE_P1=1
LINK_TYPE_P2=2

mst start && mlxfwmanager -u -i /root/fw-ConnectX6-rel-20_28_2006-MCX653106A-ECA_Ax-UEFI-14.21.17-FlexBoot-3.6.102.bin -y | grep -i reboot && export NEED_REBOOT=1

ip a | grep -E '(p4p2|p4p1|ens.f0|ens.f1)' || {
  mst start
  mlxconfig -y -d /dev/mst/mt4123_pciconf0 set LINK_TYPE_P1=$LINK_TYPE_P1 LINK_TYPE_P2=$LINK_TYPE_P2
  export NEED_REBOOT=1
}

if [ $NEED_REBOOT -eq 1 ]; then
  reboot
else
  systemctl start ironic-python-agent
fi
