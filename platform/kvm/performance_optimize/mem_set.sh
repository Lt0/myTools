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
FILE_BAK=$FILE.mem_bak

if [[ -n $(/bin/cat $FILE | /bin/grep "</memoryBacking>") ]]; then
	echo memoryBacking already set, do nothing
	exit
fi

echo enable qemu-kvm\'s hugepages
/bin/sed -i 's/KVM_HUGEPAGES=0/KVM_HUGEPAGES=1/g' /etc/default/qemu-kvm

echo setting memoryBacking
echo backup $FILE to $FILE_BAK
/bin/cp $FILE $FILE_BAK

/usr/bin/virsh destroy $DOMAIN 2>/dev/null
/usr/bin/virsh undefine $DOMAIN 2>/dev/null

/bin/cp $FILE_BAK $FILE

/bin/sed -i "/<\/vcpu>/ a \ \ <memoryBacking>" $FILE
/bin/sed -i "/<memoryBacking>/ a \ \ <\/memoryBacking>" $FILE
/bin/sed -i "/<memoryBacking>/ a \ \ \ \ <\/hugepages>" $FILE
/bin/sed -i "/<memoryBacking>/ a \ \ \ \ \ \ <page size='1' unit='G' />" $FILE
/bin/sed -i "/<memoryBacking>/ a \ \ \ \ <hugepages>" $FILE

/usr/bin/virsh define $FILE

echo set memoryBacking finish, reboot host to take effect.
