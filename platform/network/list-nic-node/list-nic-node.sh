#!/bin/bash
# maintainer hepeqin@casachina.com.cn

PCIS=$(lspci | grep Eth | sed 's/ .*$//')
CUR_NIC=
CUR_DN=

NICS=$(ip link show | grep -v "link\/" | sed "s/^.*: \(.*\): <.*/\1/")

match_pci_nic(){
	check_pci=$1
	nic_pci=$2
	m_nic=$3
	#echo mach_pci_nic: check_pci: $check_pci
	#echo mach_pci_nic: nic_pci: $nic_pci
	#echo mach_pci_nic: m_nic: $m_nic
	if [ "$check_pci" = "$nic_pci" ]
	then
		CUR_NIC=$m_nic
	fi
}

get_nic(){
	PCI=$1
	#echo getting nic for $PCI
	for nic in $NICS
	do
		tmp_pci=
		#echo checking $nic
		tmp_pci=$(ethtool -i $nic 2>/dev/null | grep bus-info | sed 's/bus-info: 0000://')
		#echo pci of $nic: $tmp_pci
		match_pci_nic $PCI $tmp_pci $nic
	done
}

get_dev_node(){
	pci=$1
	CUR_DN=$(cat /sys/bus/pci/devices/0000:$pci/numa_node)
}

print_info(){
	p_pci=$1
	if [ -n "$CUR_NIC" ]
	then
		printf  "$pci \t$CUR_NIC \t\tnode$CUR_DN\n"
	else
		printf  "$pci \tN/A \t\tnode$CUR_DN\n"
		
	fi
}

show_exp(){
echo "Explanation:
	1. N/A interface: ethtool could NOT get the name of specified pci device
	   eg: dp_x_y port that init from X710/virtio is NOT supported by ethtool 
	   eg: no driver for the pci device

	2. -1 node: value -1 of node means there is only have 1 or 0 NUMA node on this machine
"
}

show_header(){
printf "PCI \t\tInterface \tNUMA Node\n------------------------------------------\n"
}

show_header
for pci in $PCIS
do
	CUR_NIC=
	CUR_DN=
	get_nic $pci
	get_dev_node $pci
	print_info $pci
done
echo
show_exp
