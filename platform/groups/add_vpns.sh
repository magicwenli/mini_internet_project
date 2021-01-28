#!/bin/bash
source "/root/mini_internet_project/platform/setup/ovs-docker.sh"
ovs-vsctl add-br vpnbr_1_vpn-1
openvpn --config /root/mini_internet_project/platform/groups/g1/vpn/vpn-1/server.conf --log /root/mini_internet_project/platform/groups/g1/vpn/vpn-1/log.txt &
echo kill $! >> groups/del_vpns.sh
ovs-vsctl add-br vpnbr_1_vpn-3
openvpn --config /root/mini_internet_project/platform/groups/g1/vpn/vpn-3/server.conf --log /root/mini_internet_project/platform/groups/g1/vpn/vpn-3/log.txt &
echo kill $! >> groups/del_vpns.sh
ovs-vsctl add-br vpnbr_2_vpn-1
openvpn --config /root/mini_internet_project/platform/groups/g2/vpn/vpn-1/server.conf --log /root/mini_internet_project/platform/groups/g2/vpn/vpn-1/log.txt &
echo kill $! >> groups/del_vpns.sh
ovs-vsctl add-br vpnbr_2_vpn-3
openvpn --config /root/mini_internet_project/platform/groups/g2/vpn/vpn-3/server.conf --log /root/mini_internet_project/platform/groups/g2/vpn/vpn-3/log.txt &
echo kill $! >> groups/del_vpns.sh
ip link add 1-vpn-1 type veth peer name g1_vpn-1
PID=455438
create_netns_link
ip link set 1-vpn-1 netns $PID
ip netns exec $PID ip link set dev 1-vpn-1 up
isula exec -d 1_L2_UNIV_CERN ovs-vsctl add-port br0 1-vpn-1
ip link set dev g1_vpn-1 up
ip link set dev tap_g1_vpn-1 up
ovs-vsctl add-port vpnbr_1_vpn-1 tap_g1_vpn-1
ovs-vsctl add-port vpnbr_1_vpn-1 g1_vpn-1
ip link add 1-vpn-3 type veth peer name g1_vpn-3
PID=455810
create_netns_link
ip link set 1-vpn-3 netns $PID
ip netns exec $PID ip link set dev 1-vpn-3 up
isula exec -d 1_L2_UNIV_EPFL ovs-vsctl add-port br0 1-vpn-3
ip link set dev g1_vpn-3 up
ip link set dev tap_g1_vpn-3 up
ovs-vsctl add-port vpnbr_1_vpn-3 tap_g1_vpn-3
ovs-vsctl add-port vpnbr_1_vpn-3 g1_vpn-3
ip link add 2-vpn-1 type veth peer name g2_vpn-1
PID=457273
create_netns_link
ip link set 2-vpn-1 netns $PID
ip netns exec $PID ip link set dev 2-vpn-1 up
isula exec -d 2_L2_UNIV_CERN ovs-vsctl add-port br0 2-vpn-1
ip link set dev g2_vpn-1 up
ip link set dev tap_g2_vpn-1 up
ovs-vsctl add-port vpnbr_2_vpn-1 tap_g2_vpn-1
ovs-vsctl add-port vpnbr_2_vpn-1 g2_vpn-1
ip link add 2-vpn-3 type veth peer name g2_vpn-3
PID=457649
create_netns_link
ip link set 2-vpn-3 netns $PID
ip netns exec $PID ip link set dev 2-vpn-3 up
isula exec -d 2_L2_UNIV_EPFL ovs-vsctl add-port br0 2-vpn-3
ip link set dev g2_vpn-3 up
ip link set dev tap_g2_vpn-3 up
ovs-vsctl add-port vpnbr_2_vpn-3 tap_g2_vpn-3
ovs-vsctl add-port vpnbr_2_vpn-3 g2_vpn-3
