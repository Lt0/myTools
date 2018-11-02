#!/bin/sh

account="lightimehpq"

show_help(){
echo "
What is expose:
  expose is a tool for exposing your local service(IP:PORT) that behind NAT network to internet. 
  You need a linux server that has public ip and sshd service was run on it to do this.


Usage:
  Show help:
    docker run --rm expose

  Expose service:
    docker run --name=expose -d --restart=always -e local_port=xxx -e pub_ip=xxx -e pub_port=xxx -e pub_user=xxx -e pub_pwd=xxx -it ${account}/expose-ARCH start
    
    Args:
      local_ip: local ip (optional, default: 172.17.0.1)
      local_port: local port that want to expose
      pub_ip: public server ip
      pub_port: public port
      pub_user:  ssh user on public server
      pub_pwd: password
"
}

start_service(){
echo PUBLIC_IP: $pub_ip
echo PUBLIC_PORT: $pub_port

echo PUB_USER: $pub_user
echo PUB_PWD: $pub_pwd
	if [ -z $local_ip ]; then
		local_ip=172.17.0.1
	fi
	./expose $local_ip $local_port $pub_ip $pub_port $pub_user $pub_pwd
	/bin/sh
}

case $# in
        0 )
                show_help
        ;;
        * )
                case $1 in
                        "start" )
                                echo start expose service
                                start_service
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
