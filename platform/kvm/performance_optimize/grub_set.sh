#!/bin/bash

echo enable hugepage and iommu on host
/bin/sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"\"/GRUB_CMDLINE_LINUX_DEFAULT=\"default_hugepagesz=1G hugepagesz=1G hugepages=120 intel_iommu=on\"/" /etc/default/grub
#/usr/sbin/update-grub
echo run "update-grub" and reboot to take effect
