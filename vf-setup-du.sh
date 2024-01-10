#!/bin/sh

echo ----------------------- vf-setup --------------------------------
echo [vf-setup] Creating 2 virtual functions
echo 2 > /sys/bus/pci/devices/0000:01:00.0/sriov_numvfs

echo [vf-setup] Setting MAC addresses for the virtual functions.
ip link set enp1s0f0 vf 0 mac 00:11:22:33:44:66 trust on mtu 9600
ip link set enp1s0f0 vf 0 spoofchk off
ip link set enp1s0f0 vf 1 mac 00:11:22:33:44:66 trust on mtu 9600
ip link set enp1s0f0 vf 1 spoofchk off

echo [vf-setup] Loading igb_uio driver into kernel modules.
modprobe uio
insmod /home/nr5glab/dpdk-kmods/linux/igb_uio/igb_uio.ko

echo [vf-setup] Binding virtual functions with igb_uio driver.
python3 /home/nr5glab/dpdk-stable-20.11.8/usertools/dpdk-devbind.py -b igb_uio 0000:01:01.0 0000:01:01.1

echo ----------------------- Done. ------------------------------------ 

# ip link set enp2s0f0 vf 0 mac 00:11:22:33:44:55 vlan 1
# ip link set enp2s0f0 vf 1 mac 00:11:22:33:44:66 vlan 2
