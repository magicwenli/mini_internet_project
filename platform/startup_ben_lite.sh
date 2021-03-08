#!/bin/bash
#
# starts whole network

set -o errexit
set -o pipefail
set -o nounset


save_file="./benchmark/result/AS_${1}.txt"

time_save(){
	{ /usr/bin/time -f "\t%U\t%S\t%E\t%P\n" $*; } 2>> $save_file
}

start=$(date +%s)

# Check for programs we'll need.
search_path () {
    save_IFS=$IFS
    IFS=:
    for dir in $PATH; do
        IFS=$save_IFS
        if test -x "$dir/$1"; then
            return 0
        fi
    done
    IFS=$save_IFS
    echo >&2 "$0: $1 not found in \$PATH, please install and try again"
    exit 1
}

search_path ovs-vsctl
search_path docker
search_path uuidgen

if (ip netns) > /dev/null 2>&1; then :; else
    echo >&2 "${0##*/}: ip utility not found (or it does not support netns),"\
             "cannot proceed"
    exit 1
fi

DIRECTORY=$(cd `dirname $0` && pwd)

echo "$(date +%Y-%m-%d_%H-%M-%S)"

echo "cleanup.sh: "
echo -n "cleanup.sh" >> $save_file
time_save ./cleanup/cleanup.sh "${DIRECTORY}"

echo ""
echo ""

# change size of ARP table necessary for large networks
sysctl net.ipv4.neigh.default.gc_thresh1=4096
sysctl net.ipv4.neigh.default.gc_thresh2=8192
sysctl net.ipv4.neigh.default.gc_thresh3=16384
sysctl -p

# Increase the max number of running processes
sysctl kernel.pid_max=4194304

# Load MPLS kernel modules
modprobe mpls_router
modprobe mpls_gso
modprobe mpls_iptunnel

echo "folder_setup.sh $(($(date +%s%N)/1000000))" > "${DIRECTORY}"/log.txt
echo "folder_setup.sh: "

echo -n "folder_setup.sh" >> $save_file
time_save ./setup/folder_setup.sh "${DIRECTORY}"

echo ""
echo ""

echo "dns_config.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
echo "dns_config.sh: "

echo -n "dns_config.sh" >> $save_file
time_save ./setup/dns_config.sh "${DIRECTORY}"

echo ""
echo ""

echo "vpn_config.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
echo "vpn_config.sh: "

echo -n "vpn_config.sh" >> $save_file
time_save ./setup/vpn_config.sh "${DIRECTORY}"

echo ""
echo ""

echo "goto_scripts.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
echo "goto_scripts.sh: "

echo -n "goto_scripts.sh" >> $save_file
time_save ./setup/goto_scripts.sh "${DIRECTORY}"

echo ""
echo ""

echo "save_configs.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
echo "save_configs.sh: "

echo -n "save_configs.sh" >> $save_file
time_save ./setup/save_configs.sh "${DIRECTORY}"

echo ""
echo ""

echo "container_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
echo "container_setup.sh: "

echo -n "container_setup.sh" >> $save_file
time_save ./setup/container_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"host links\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "host_links_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo "host_links_setup.sh: "

# echo -n "host_links_setup.sh" >> $save_file
# time_save ./setup/host_links_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"layer2 links\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "layer2_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo "layer2_setup.sh: "

# echo -n "layer2_setup.sh" >> $save_file
# time_save ./setup/layer2_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"internal links\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "internal_links_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo "internal_links_setup.sh: "

# echo -n "internal_links_setup.sh" >> $save_file
# time_save ./setup/internal_links_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"external links\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "external_links_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo "external_links_setup.sh: "

# echo -n "external_links_setup.sh" >> $save_file
# time_save ./setup/external_links_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"measurement links\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "measurement_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo "measurement_setup.sh: "

# echo -n "measurement_setup.sh" >> $save_file
# time_save ./setup/measurement_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"ssh links\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "ssh_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo "ssh_setup.sh: "

# echo -n "ssh_setup.sh" >> $save_file
# time_save ./setup/ssh_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"matrix_setup\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "matrix_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo "matrix_setup.sh: "

# echo -n "matrix_setup.sh" >> $save_file
# time_save ./setup/matrix_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "echo \"dns links\"" >> "${DIRECTORY}"/groups/ip_setup.sh
# echo "dns_setup.sh: "

# echo "dns_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "dns_setup.sh" >> $save_file
# time_save ./setup/dns_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "add_bridges.sh: "
# echo "add_bridges.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt

# echo -n "add_bridges.sh" >> $save_file
# time_save ./groups/add_bridges.sh

# echo ""
# echo ""

# echo "add_ports.sh: "
# echo "add_ports.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "add_ports.sh" >> $save_file
# time_save ./groups/add_ports.sh

# echo ""
# echo ""

# echo "ip_setup.sh: "
# echo "ip_setup.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "ip_setup.sh" >> $save_file
# time_save ./groups/ip_setup.sh
# sleep 10

# echo ""
# echo ""

# echo "dns_routes"
# echo "dns_routes $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "dns_routes.sh" >> $save_file
# time_save ./groups/dns_routes.sh

# echo ""
# echo ""

# echo "l2_init_switch.sh: "
# echo "l2_init_switch.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "l2_init_switch.sh" >> $save_file
# time_save ./groups/l2_init_switch.sh

# echo ""
# echo ""

# echo "add_vpns.sh: "
# echo "add_vpns.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "add_vpns.sh" >> $save_file
# time_save ./groups/add_vpns.sh

# echo ""
# echo ""

# echo "layer2_config.sh: "
# echo "layer2_config.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "layer2_config.sh" >> $save_file
# time_save ./setup/layer2_config.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "router_config.sh: "
# echo "router_config.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "router_config.sh" >> $save_file
# time_save ./setup/router_config.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "mpls.sh: "
# echo "mpls.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "mpls.sh" >> $save_file
# time_save ./setup/mpls_setup.sh "${DIRECTORY}"

# echo ""
# echo ""

# echo "wait" >> "${DIRECTORY}"/groups/delay_throughput.sh
# echo "delay_throughput.sh: "
# echo "delay_throughput.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "delay_throughput.sh" >> $save_file
# time_save ./groups/delay_throughput.sh

# echo ""
# echo ""

# echo "throughput.sh: "
# echo "throughput.sh $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt
# echo -n "throughput.sh" >> $save_file
# time_save ./groups/throughput.sh

# echo "Run ./groups/open_vpn_ports.sh to open the ports used by the vpn servers."
# echo "END $(($(date +%s%N)/1000000))" >> "${DIRECTORY}"/log.txt

echo ""
echo ""

# restart dns server with new configs
if [ -n "$(isula ps | grep "DNS")" ]; then
    isula exec -d DNS service bind9 restart
fi

echo "$(date +%Y-%m-%d_%H-%M-%S)"

end=$(date +%s)
take=$(( end - start ))
echo Time taken to execute commands is ${take} seconds.
