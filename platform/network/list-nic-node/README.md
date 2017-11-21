# 概述

list-nic-node.sh 脚本是一个列出本机所有网卡的 NUMA 节点信息

# 支持平台
ubuntu 14.04(amd64)

# 依赖
ethtool


# 使用方法
```
./list-nic-node.sh 
PCI 		Interface 	NUMA Node
------------------------------------------
01:00.0 	N/A 		node0
01:00.1 	N/A 		node0
03:00.0 	N/A 		node0
03:00.1 	N/A 		node0
05:00.0 	em3 		node0
05:00.1 	dp_0_4 		node0
81:00.0 	N/A 		node1
81:00.1 	dp_0_6 		node1

Explanation:
	1. N/A interface: ethtool could NOT get the name of specified pci device
	   eg: dp_x_y port that init from X710/virtio is NOT supported by ethtool 
	   eg: no driver for the pci device

	2. -1 node: value -1 of node means there is only have 1 or 0 NUMA node on this machine
  ```

