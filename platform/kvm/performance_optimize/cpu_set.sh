#!/bin/bash

show_help(){
echo "Usage: $0 domain

example: $0 WAG1"
}
if [ $# -lt 1 ]; then
	show_help
	exit 1
fi


DOMAIN=$1
PATH="/etc/libvirt/qemu"
FILE=$PATH/$DOMAIN.xml
FILE_BAK=$FILE.cpu_bak


if [[ -n $(/bin/cat $FILE | /bin/grep "</cputune>") ]]; then
	echo cputune already set, do nothing
	exit
fi


echo setting cputune
echo backup $FILE to $FILE_BAK
/bin/cp $FILE $FILE_BAK

/usr/bin/virsh destroy $DOMAIN 2>/dev/null
/usr/bin/virsh undefine $DOMAIN 2>/dev/null

/bin/cp $FILE_BAK $FILE

/bin/sed -i "/<\/vcpu>/ a \ \ <cputune>" $FILE
/bin/sed -i "/<cputune>/ a \ \ <\/cputune>" $FILE
for ((i=55; i >= 0; i-=1))
do
	echo pin vcpu $i to cpu $i
	/bin/sed -i "/<cputune>/ a \ \ \ \ <vcpupin vcpu='$i' cpuset='$i'\/>" $FILE
done

/usr/bin/virsh define $FILE
echo set cputune finish
