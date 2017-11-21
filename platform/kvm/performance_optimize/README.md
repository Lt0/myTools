# 说明

脚本说明

grub_set.sh: 配置 /etc/default/grub，配置 120G 内存为 hugepage，并启用 iommu。这个脚本只有在 host 之前没执行过或在 /etc/default/grub 下配置过 hugepages 和 iommu 的情况下，才需要执行。如果之前执行过了，那么重新配置 VM 的 CPU、内存和 passthrough 接口都不需要再执行了。

cpu_set.sh: 配置 cputune，56 核，配置前会将 domain 的 xml 文件备份为 /etc/libvirt/qemu/<domain>.xml.cpu_bak

mem_set.sh: 配置 VM 使用 hugepage，配置前会将 domain 的 xml 文件备份为 /etc/libvirt/qemu/<domain>.xml.mem_bak

iface_add: 配置网卡为 passthrough 模式让 VM 直接使用网卡, 配置前会将 domain 的 xml 文件备份为 /etc/libvirt/qemu/<domain>.xml.iface_bak 


<br>
# 使用说明
```
./grub_set.sh
update-grub
reboot
./cpu_set.sh <domain>
./mem_set.sh <domain>
./iface_add <domain> <iface> [iface...]
```


<br>
# 示例
配置 WAG1，划分 120G 内存作为 hugepage 给它单独使用，56核 CPU 和物理机一一对应，并将 P2p1, p2p2, p3p1, p3p2, p7p1, p7p2 这些接口以 passthough 模式配置给它独占使用。

命令:
```
./grub_set.sh
update-grub
reboot
./cpu_set.sh WAG1
./mem_set.sh WAG1
./iface_add WAG1 p2p1 p2p2 p3p1 p3p2 p7p1 p7p2
reboot
```
