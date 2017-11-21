#!/bin/bash

show_help(){
echo "Usage: $0 domain iface [iface...]

example: $0 WAG1 p1p1 p1p2"
}

if [[ $# -lt 2 ]]; then
	show_help
	exit
fi

DOMAIN=$1
shift
IFACE=$*
echo domain: $DOMAIN
echo IFACE: $IFACE

PATH="/etc/libvirt/qemu"
FILE=$PATH/$DOMAIN.xml
FILE_BAK=$FILE.iface_bak

echo backup $FILE to $FILE_BAK
/bin/cp $FILE $FILE_BAK

/usr/bin/virsh destroy $DOMAIN 2>/dev/null
/usr/bin/virsh undefine $DOMAIN 2>/dev/null

/bin/cp $FILE_BAK $FILE

for iface in $IFACE
do
	PCI=$(/sbin/ethtool -i $iface | /bin/grep bus-info | /bin/sed "s/^bus-info: //")
	BUS=$(/bin/sed "s/.*:\(.*\):.*/\1/" <<< $PCI)
	SLOT=$(/bin/sed "s/.*:\(.*\)\..*/\1/" <<< $PCI)
	FUNC=$(/bin/sed "s/.*\.\(.*\)/\1/" <<< $PCI)
	/bin/sed -i "/<devices>/ a \ \ \ \ <hostdev mode='subsystem' type='pci' managed='yes'>\n\ \ \ \ \ \ <source>\n\ \ \ \ \ \ \ \ <address domain='0x0000' bus='0x$BUS' slot='0x$SLOT' function='0x$FUNC'/>\n\ \ \ \ \ \ </source>\n\ \ \ \ <\/hostdev>" $FILE
	BUS=""
	SLOT=""
	FUNC=""
done

/usr/bin/virsh define $FILE

echo add iface finish
