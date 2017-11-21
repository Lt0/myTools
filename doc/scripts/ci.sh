#!/bin/bash

SRC_PATH=/vob/doc_nfv2_lte
DOC_GEN_TOOL_PATH=/opt/doc/scripts
DOC_GEN_TOOL=gen_doxy_file.sh

SEP="---------------------"
ACCUREV="/opt/AccuRev/bin/accurev"

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/AccuRev/bin:/root/bin
show_date(){
	echo $SEP $(date) $SEP
}

cd_src(){
cd $SRC_PATH
if [ "$PWD" != "$SRC_PATH" ]; then
	echo cd $SRC_PATH failed, exit....
	exit 1
fi
}

backup_ws(){
	echo backup workspace....
	sleep 3
	if [ -d "$SRC_PATH.bak2" ]; then
		rm -rf $SRC_PATH.bak2
	fi
	mv $SRC_PATH.bak $SRC_PATH.bak2
	mv $SRC_PATH $SRC_PATH.bak
	mkdir $SRC_PATH
}

login_accurev(){
	echo login accurev....
	sleep 3
	$ACCUREV login hepeiqin password
}

update_ws(){
	echo update and pop workspace....
	sleep 3
	cd_src
	$ACCUREV update > /dev/null
	$ACCUREV pop -R . > /dev/null
}

build_ws(){
	echo building workspace....
	sleep 3
	cd_src
	time make mobile > /dev/null
}

gen_doc(){
	echo generate documents....
	sleep 3
	cd $DOC_GEN_TOOL_PATH
	./$DOC_GEN_TOOL
}

echo "##################### running CI script for $SCR_PATH #####################"

show_date
backup_ws

show_date
login_accurev

show_date
update_ws

show_date
build_ws

show_date
gen_doc
