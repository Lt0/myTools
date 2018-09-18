#!/bin/sh

conf=/etc/samba/user.conf

create_system_user() {
	echo create sys account: ${name}/${passwd}
	name=$1
	passwd=$2
adduser $name << !SYS_PASSWD!
$passwd
$passwd
!SYS_PASSWD!
}

create_samba_user() {
	name=$1
	passwd=$2
	echo creat samba accout: ${name}/${passwd}
smbpasswd -a $name << !SMB_PASSWD!
$passwd
$passwd
!SMB_PASSWD!
}

comment="################"
print_head(){
	echo -n $comment
	echo -n " Creating Users "
	echo $comment
}
print_tail(){
	echo -n $comment
	echo -n " Creating Users End "
	echo $comment
}

print_head
cat ${conf} | while read ln; do
	echo create user: $ln
	name=${ln%%:*}
	passwd=${ln##*:}

	create_system_user $name $passwd
	create_samba_user $name $passwd
done
print_tail
