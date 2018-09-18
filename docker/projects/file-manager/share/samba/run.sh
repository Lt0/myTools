#!/bin/sh

account="lightimehpq"

show_help(){
echo "
Usage:

Start Service Steps:
  1. dump default samba conf
    docker run --rm ${account}/samba dumpconf
      It will dump an exmple conf of samba: smb.conf
  
  
  2. edit dumped samba conf: smb.conf
    Please check smb.conf(5) for details: man 5 smb.conf
  
  
  3. create user account conf
    Format: user:passwd per line
    Example:
     root:rootpasswd
     lightimehpq:lightimehpqpasswd
  
  
  4. start service
    docker run --name=samba -d --restart=always -v \$PWD/smb.conf:/etc/samba/smb.conf -v \$PWD/user.conf:/etc/samba/user.conf -v /share_path1:/share_path1 -v /sahre_path2:/share_path2 -p 139:139 -p 445:445 -it ${account}/samba start
      - start samba server container
      - auto start on boot
      - container name is samba 
      - samba configuration file is ./smb.conf on host, user configuration file is ./user.conf on host
      - /share_pathN is the path that need to be shared

Change conf:
  If you want to change the configuration of samba or user, please just attach the container to do it, like:
    docker attach samba


Others:
  1. dump tiny samba conf
    docker run --rm ${account}/samba dumpconf tiny
      -- tiny samba conf is a tiny conf of samba which just share users home directories and /vob path

"
}

create_users(){
	/root/create_users.sh
}

start_samba(){
	nmbd &
	smbd &
}

start_service(){
	if [ -f "/etc/samba/smb.conf" ]; then
		echo start samba service with user\'s smb.conf
	else
		echo start samba service with default smb.conf
		cp /etc/samba/default_smb.conf /etc/samba/smb.conf
	fi


	if [ -f "/user.conf" ]; then
		echo start samba service with user\'s user.conf
	else
		echo start samba service with default user.conf \(only contain one user: root/lightime\)
		cp /etc/samba/default_user.conf /etc/samba/user.conf
	fi

	create_users
	start_samba
	/bin/sh
}

dumpconf(){
	cat /etc/samba/default_smb.conf
}

dumpconf_tiny(){
	cat /etc/samba/tiny_smb.conf
}


case $# in
        0 )
                show_help
        ;;
        * )
                case $1 in
                        "start" )
                                echo start samba service
                                start_service
                        ;;
                        "dumpconf" )
				if [ "$2" = "tiny" ]; then
					dumpconf_tiny
				else
                                	dumpconf
				fi
                        ;;
                        "h" | "help" | "-h" | "--help" | "-help" | "--h" )
                                show_help
                        ;;
                        * )
                                echo unknow option: $*
                                show_help
                        ;;
                esac
        ;;
esac
