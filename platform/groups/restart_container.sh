#!/bin/bash
if [ $# -ne 1 ]; then
  echo $0: usage ./restart_container.sh container_name
  exit 1
fi
container_name=$1
source "/root/mini_internet_project/platform/setup/ovs-docker.sh"
if [ "1_LONDrouter" == $container_name ]; then
  echo "Create Link for 1_LONDrouter (host) on bridge "
  ip link add 9a887e0093b95_l type veth peer name 9a887e0093b95_c
  ovs-vsctl del-port 1-host 9a887e0093b95_l
  ovs-vsctl add-port 1-host 9a887e0093b95_l
  ovs-vsctl set interface 9a887e0093b95_l external_ids:container_id=1_LONDrouter external_ids:container_iface=host
  ip link set 9a887e0093b95_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_LONDrouter)
  create_netns_link
  ip link set 9a887e0093b95_c netns $PID
  ip netns exec $PID ip link set dev 9a887e0093b95_c name host
  ip netns exec $PID ip link set host up
fi
if [ "1_LONDhost" == $container_name ]; then
  echo "Create Link for 1_LONDhost (LONDrouter) on bridge "
  ip link add 9bd35019028f5_l type veth peer name 9bd35019028f5_c
  ovs-vsctl del-port 1-host 9bd35019028f5_l
  ovs-vsctl add-port 1-host 9bd35019028f5_l
  ovs-vsctl set interface 9bd35019028f5_l external_ids:container_id=1_LONDhost external_ids:container_iface=LONDrouter
  ip link set 9bd35019028f5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_LONDhost)
  create_netns_link
  ip link set 9bd35019028f5_c netns $PID
  ip netns exec $PID ip link set dev 9bd35019028f5_c name LONDrouter
  ip netns exec $PID ip link set LONDrouter up
fi
if [ "1_LONDrouter" == $container_name ] || [ "1_LONDhost" == $container_name ]; then
  echo "Link between 1_LONDrouter (host) and 1_LONDhost (LONDrouter)"
  port_id1=`ovs-vsctl get Interface 9a887e0093b95_l ofport`
  port_id2=`ovs-vsctl get Interface 9bd35019028f5_l ofport`
  ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_PARIrouter" == $container_name ]; then
  echo "Create Link for 1_PARIrouter (host) on bridge "
  ip link add 0005f2de67955_l type veth peer name 0005f2de67955_c
  ovs-vsctl del-port 1-host 0005f2de67955_l
  ovs-vsctl add-port 1-host 0005f2de67955_l
  ovs-vsctl set interface 0005f2de67955_l external_ids:container_id=1_PARIrouter external_ids:container_iface=host
  ip link set 0005f2de67955_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_PARIrouter)
  create_netns_link
  ip link set 0005f2de67955_c netns $PID
  ip netns exec $PID ip link set dev 0005f2de67955_c name host
  ip netns exec $PID ip link set host up
fi
if [ "1_PARIhost" == $container_name ]; then
  echo "Create Link for 1_PARIhost (PARIrouter) on bridge "
  ip link add 54b6a831cfa55_l type veth peer name 54b6a831cfa55_c
  ovs-vsctl del-port 1-host 54b6a831cfa55_l
  ovs-vsctl add-port 1-host 54b6a831cfa55_l
  ovs-vsctl set interface 54b6a831cfa55_l external_ids:container_id=1_PARIhost external_ids:container_iface=PARIrouter
  ip link set 54b6a831cfa55_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_PARIhost)
  create_netns_link
  ip link set 54b6a831cfa55_c netns $PID
  ip netns exec $PID ip link set dev 54b6a831cfa55_c name PARIrouter
  ip netns exec $PID ip link set PARIrouter up
fi
if [ "1_PARIrouter" == $container_name ] || [ "1_PARIhost" == $container_name ]; then
  echo "Link between 1_PARIrouter (host) and 1_PARIhost (PARIrouter)"
  port_id1=`ovs-vsctl get Interface 0005f2de67955_l ofport`
  port_id2=`ovs-vsctl get Interface 54b6a831cfa55_l ofport`
  ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_NEWYrouter" == $container_name ]; then
  echo "Create Link for 1_NEWYrouter (host) on bridge "
  ip link add 4fa7fc9cc7305_l type veth peer name 4fa7fc9cc7305_c
  ovs-vsctl del-port 1-host 4fa7fc9cc7305_l
  ovs-vsctl add-port 1-host 4fa7fc9cc7305_l
  ovs-vsctl set interface 4fa7fc9cc7305_l external_ids:container_id=1_NEWYrouter external_ids:container_iface=host
  ip link set 4fa7fc9cc7305_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_NEWYrouter)
  create_netns_link
  ip link set 4fa7fc9cc7305_c netns $PID
  ip netns exec $PID ip link set dev 4fa7fc9cc7305_c name host
  ip netns exec $PID ip link set host up
fi
if [ "1_NEWYhost" == $container_name ]; then
  echo "Create Link for 1_NEWYhost (NEWYrouter) on bridge "
  ip link add 313b353cf6655_l type veth peer name 313b353cf6655_c
  ovs-vsctl del-port 1-host 313b353cf6655_l
  ovs-vsctl add-port 1-host 313b353cf6655_l
  ovs-vsctl set interface 313b353cf6655_l external_ids:container_id=1_NEWYhost external_ids:container_iface=NEWYrouter
  ip link set 313b353cf6655_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_NEWYhost)
  create_netns_link
  ip link set 313b353cf6655_c netns $PID
  ip netns exec $PID ip link set dev 313b353cf6655_c name NEWYrouter
  ip netns exec $PID ip link set NEWYrouter up
fi
if [ "1_NEWYrouter" == $container_name ] || [ "1_NEWYhost" == $container_name ]; then
  echo "Link between 1_NEWYrouter (host) and 1_NEWYhost (NEWYrouter)"
  port_id1=`ovs-vsctl get Interface 4fa7fc9cc7305_l ofport`
  port_id2=`ovs-vsctl get Interface 313b353cf6655_l ofport`
  ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_BOSTrouter" == $container_name ]; then
  echo "Create Link for 1_BOSTrouter (host) on bridge "
  ip link add 88b8cde13aba5_l type veth peer name 88b8cde13aba5_c
  ovs-vsctl del-port 1-host 88b8cde13aba5_l
  ovs-vsctl add-port 1-host 88b8cde13aba5_l
  ovs-vsctl set interface 88b8cde13aba5_l external_ids:container_id=1_BOSTrouter external_ids:container_iface=host
  ip link set 88b8cde13aba5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_BOSTrouter)
  create_netns_link
  ip link set 88b8cde13aba5_c netns $PID
  ip netns exec $PID ip link set dev 88b8cde13aba5_c name host
  ip netns exec $PID ip link set host up
fi
if [ "1_BOSThost" == $container_name ]; then
  echo "Create Link for 1_BOSThost (BOSTrouter) on bridge "
  ip link add c16801781d145_l type veth peer name c16801781d145_c
  ovs-vsctl del-port 1-host c16801781d145_l
  ovs-vsctl add-port 1-host c16801781d145_l
  ovs-vsctl set interface c16801781d145_l external_ids:container_id=1_BOSThost external_ids:container_iface=BOSTrouter
  ip link set c16801781d145_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_BOSThost)
  create_netns_link
  ip link set c16801781d145_c netns $PID
  ip netns exec $PID ip link set dev c16801781d145_c name BOSTrouter
  ip netns exec $PID ip link set BOSTrouter up
fi
if [ "1_BOSTrouter" == $container_name ] || [ "1_BOSThost" == $container_name ]; then
  echo "Link between 1_BOSTrouter (host) and 1_BOSThost (BOSTrouter)"
  port_id1=`ovs-vsctl get Interface 88b8cde13aba5_l ofport`
  port_id2=`ovs-vsctl get Interface c16801781d145_l ofport`
  ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_ATLArouter" == $container_name ]; then
  echo "Create Link for 1_ATLArouter (host) on bridge "
  ip link add cbfcd102f9fe5_l type veth peer name cbfcd102f9fe5_c
  ovs-vsctl del-port 1-host cbfcd102f9fe5_l
  ovs-vsctl add-port 1-host cbfcd102f9fe5_l
  ovs-vsctl set interface cbfcd102f9fe5_l external_ids:container_id=1_ATLArouter external_ids:container_iface=host
  ip link set cbfcd102f9fe5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ATLArouter)
  create_netns_link
  ip link set cbfcd102f9fe5_c netns $PID
  ip netns exec $PID ip link set dev cbfcd102f9fe5_c name host
  ip netns exec $PID ip link set host up
fi
if [ "1_ATLAhost" == $container_name ]; then
  echo "Create Link for 1_ATLAhost (ATLArouter) on bridge "
  ip link add 800f8a801e9c5_l type veth peer name 800f8a801e9c5_c
  ovs-vsctl del-port 1-host 800f8a801e9c5_l
  ovs-vsctl add-port 1-host 800f8a801e9c5_l
  ovs-vsctl set interface 800f8a801e9c5_l external_ids:container_id=1_ATLAhost external_ids:container_iface=ATLArouter
  ip link set 800f8a801e9c5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ATLAhost)
  create_netns_link
  ip link set 800f8a801e9c5_c netns $PID
  ip netns exec $PID ip link set dev 800f8a801e9c5_c name ATLArouter
  ip netns exec $PID ip link set ATLArouter up
fi
if [ "1_ATLArouter" == $container_name ] || [ "1_ATLAhost" == $container_name ]; then
  echo "Link between 1_ATLArouter (host) and 1_ATLAhost (ATLArouter)"
  port_id1=`ovs-vsctl get Interface cbfcd102f9fe5_l ofport`
  port_id2=`ovs-vsctl get Interface 800f8a801e9c5_l ofport`
  ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_MIAMrouter" == $container_name ]; then
  echo "Create Link for 1_MIAMrouter (host) on bridge "
  ip link add d49c4f81576e5_l type veth peer name d49c4f81576e5_c
  ovs-vsctl del-port 1-host d49c4f81576e5_l
  ovs-vsctl add-port 1-host d49c4f81576e5_l
  ovs-vsctl set interface d49c4f81576e5_l external_ids:container_id=1_MIAMrouter external_ids:container_iface=host
  ip link set d49c4f81576e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_MIAMrouter)
  create_netns_link
  ip link set d49c4f81576e5_c netns $PID
  ip netns exec $PID ip link set dev d49c4f81576e5_c name host
  ip netns exec $PID ip link set host up
fi
if [ "1_MIAMhost" == $container_name ]; then
  echo "Create Link for 1_MIAMhost (MIAMrouter) on bridge "
  ip link add bd5ae80001a35_l type veth peer name bd5ae80001a35_c
  ovs-vsctl del-port 1-host bd5ae80001a35_l
  ovs-vsctl add-port 1-host bd5ae80001a35_l
  ovs-vsctl set interface bd5ae80001a35_l external_ids:container_id=1_MIAMhost external_ids:container_iface=MIAMrouter
  ip link set bd5ae80001a35_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_MIAMhost)
  create_netns_link
  ip link set bd5ae80001a35_c netns $PID
  ip netns exec $PID ip link set dev bd5ae80001a35_c name MIAMrouter
  ip netns exec $PID ip link set MIAMrouter up
fi
if [ "1_MIAMrouter" == $container_name ] || [ "1_MIAMhost" == $container_name ]; then
  echo "Link between 1_MIAMrouter (host) and 1_MIAMhost (MIAMrouter)"
  port_id1=`ovs-vsctl get Interface d49c4f81576e5_l ofport`
  port_id2=`ovs-vsctl get Interface bd5ae80001a35_l ofport`
  ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_LONDrouter" == $container_name ]; then
  echo "Create Link for 2_LONDrouter (host) on bridge "
  ip link add 4e1af881c9005_l type veth peer name 4e1af881c9005_c
  ovs-vsctl del-port 2-host 4e1af881c9005_l
  ovs-vsctl add-port 2-host 4e1af881c9005_l
  ovs-vsctl set interface 4e1af881c9005_l external_ids:container_id=2_LONDrouter external_ids:container_iface=host
  ip link set 4e1af881c9005_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_LONDrouter)
  create_netns_link
  ip link set 4e1af881c9005_c netns $PID
  ip netns exec $PID ip link set dev 4e1af881c9005_c name host
  ip netns exec $PID ip link set host up
fi
if [ "2_LONDhost" == $container_name ]; then
  echo "Create Link for 2_LONDhost (LONDrouter) on bridge "
  ip link add 990435db36665_l type veth peer name 990435db36665_c
  ovs-vsctl del-port 2-host 990435db36665_l
  ovs-vsctl add-port 2-host 990435db36665_l
  ovs-vsctl set interface 990435db36665_l external_ids:container_id=2_LONDhost external_ids:container_iface=LONDrouter
  ip link set 990435db36665_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_LONDhost)
  create_netns_link
  ip link set 990435db36665_c netns $PID
  ip netns exec $PID ip link set dev 990435db36665_c name LONDrouter
  ip netns exec $PID ip link set LONDrouter up
fi
if [ "2_LONDrouter" == $container_name ] || [ "2_LONDhost" == $container_name ]; then
  echo "Link between 2_LONDrouter (host) and 2_LONDhost (LONDrouter)"
  port_id1=`ovs-vsctl get Interface 4e1af881c9005_l ofport`
  port_id2=`ovs-vsctl get Interface 990435db36665_l ofport`
  ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_PARIrouter" == $container_name ]; then
  echo "Create Link for 2_PARIrouter (host) on bridge "
  ip link add e57d011e884e5_l type veth peer name e57d011e884e5_c
  ovs-vsctl del-port 2-host e57d011e884e5_l
  ovs-vsctl add-port 2-host e57d011e884e5_l
  ovs-vsctl set interface e57d011e884e5_l external_ids:container_id=2_PARIrouter external_ids:container_iface=host
  ip link set e57d011e884e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_PARIrouter)
  create_netns_link
  ip link set e57d011e884e5_c netns $PID
  ip netns exec $PID ip link set dev e57d011e884e5_c name host
  ip netns exec $PID ip link set host up
fi
if [ "2_PARIhost" == $container_name ]; then
  echo "Create Link for 2_PARIhost (PARIrouter) on bridge "
  ip link add c0230f07bdbe5_l type veth peer name c0230f07bdbe5_c
  ovs-vsctl del-port 2-host c0230f07bdbe5_l
  ovs-vsctl add-port 2-host c0230f07bdbe5_l
  ovs-vsctl set interface c0230f07bdbe5_l external_ids:container_id=2_PARIhost external_ids:container_iface=PARIrouter
  ip link set c0230f07bdbe5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_PARIhost)
  create_netns_link
  ip link set c0230f07bdbe5_c netns $PID
  ip netns exec $PID ip link set dev c0230f07bdbe5_c name PARIrouter
  ip netns exec $PID ip link set PARIrouter up
fi
if [ "2_PARIrouter" == $container_name ] || [ "2_PARIhost" == $container_name ]; then
  echo "Link between 2_PARIrouter (host) and 2_PARIhost (PARIrouter)"
  port_id1=`ovs-vsctl get Interface e57d011e884e5_l ofport`
  port_id2=`ovs-vsctl get Interface c0230f07bdbe5_l ofport`
  ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_NEWYrouter" == $container_name ]; then
  echo "Create Link for 2_NEWYrouter (host) on bridge "
  ip link add d7d5c5533f795_l type veth peer name d7d5c5533f795_c
  ovs-vsctl del-port 2-host d7d5c5533f795_l
  ovs-vsctl add-port 2-host d7d5c5533f795_l
  ovs-vsctl set interface d7d5c5533f795_l external_ids:container_id=2_NEWYrouter external_ids:container_iface=host
  ip link set d7d5c5533f795_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_NEWYrouter)
  create_netns_link
  ip link set d7d5c5533f795_c netns $PID
  ip netns exec $PID ip link set dev d7d5c5533f795_c name host
  ip netns exec $PID ip link set host up
fi
if [ "2_NEWYhost" == $container_name ]; then
  echo "Create Link for 2_NEWYhost (NEWYrouter) on bridge "
  ip link add c8edf20588995_l type veth peer name c8edf20588995_c
  ovs-vsctl del-port 2-host c8edf20588995_l
  ovs-vsctl add-port 2-host c8edf20588995_l
  ovs-vsctl set interface c8edf20588995_l external_ids:container_id=2_NEWYhost external_ids:container_iface=NEWYrouter
  ip link set c8edf20588995_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_NEWYhost)
  create_netns_link
  ip link set c8edf20588995_c netns $PID
  ip netns exec $PID ip link set dev c8edf20588995_c name NEWYrouter
  ip netns exec $PID ip link set NEWYrouter up
fi
if [ "2_NEWYrouter" == $container_name ] || [ "2_NEWYhost" == $container_name ]; then
  echo "Link between 2_NEWYrouter (host) and 2_NEWYhost (NEWYrouter)"
  port_id1=`ovs-vsctl get Interface d7d5c5533f795_l ofport`
  port_id2=`ovs-vsctl get Interface c8edf20588995_l ofport`
  ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_BOSTrouter" == $container_name ]; then
  echo "Create Link for 2_BOSTrouter (host) on bridge "
  ip link add 44462c0ac1645_l type veth peer name 44462c0ac1645_c
  ovs-vsctl del-port 2-host 44462c0ac1645_l
  ovs-vsctl add-port 2-host 44462c0ac1645_l
  ovs-vsctl set interface 44462c0ac1645_l external_ids:container_id=2_BOSTrouter external_ids:container_iface=host
  ip link set 44462c0ac1645_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_BOSTrouter)
  create_netns_link
  ip link set 44462c0ac1645_c netns $PID
  ip netns exec $PID ip link set dev 44462c0ac1645_c name host
  ip netns exec $PID ip link set host up
fi
if [ "2_BOSThost" == $container_name ]; then
  echo "Create Link for 2_BOSThost (BOSTrouter) on bridge "
  ip link add a36638d2aff05_l type veth peer name a36638d2aff05_c
  ovs-vsctl del-port 2-host a36638d2aff05_l
  ovs-vsctl add-port 2-host a36638d2aff05_l
  ovs-vsctl set interface a36638d2aff05_l external_ids:container_id=2_BOSThost external_ids:container_iface=BOSTrouter
  ip link set a36638d2aff05_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_BOSThost)
  create_netns_link
  ip link set a36638d2aff05_c netns $PID
  ip netns exec $PID ip link set dev a36638d2aff05_c name BOSTrouter
  ip netns exec $PID ip link set BOSTrouter up
fi
if [ "2_BOSTrouter" == $container_name ] || [ "2_BOSThost" == $container_name ]; then
  echo "Link between 2_BOSTrouter (host) and 2_BOSThost (BOSTrouter)"
  port_id1=`ovs-vsctl get Interface 44462c0ac1645_l ofport`
  port_id2=`ovs-vsctl get Interface a36638d2aff05_l ofport`
  ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_ATLArouter" == $container_name ]; then
  echo "Create Link for 2_ATLArouter (host) on bridge "
  ip link add 965ee8f95af15_l type veth peer name 965ee8f95af15_c
  ovs-vsctl del-port 2-host 965ee8f95af15_l
  ovs-vsctl add-port 2-host 965ee8f95af15_l
  ovs-vsctl set interface 965ee8f95af15_l external_ids:container_id=2_ATLArouter external_ids:container_iface=host
  ip link set 965ee8f95af15_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ATLArouter)
  create_netns_link
  ip link set 965ee8f95af15_c netns $PID
  ip netns exec $PID ip link set dev 965ee8f95af15_c name host
  ip netns exec $PID ip link set host up
fi
if [ "2_ATLAhost" == $container_name ]; then
  echo "Create Link for 2_ATLAhost (ATLArouter) on bridge "
  ip link add f2f93280613b5_l type veth peer name f2f93280613b5_c
  ovs-vsctl del-port 2-host f2f93280613b5_l
  ovs-vsctl add-port 2-host f2f93280613b5_l
  ovs-vsctl set interface f2f93280613b5_l external_ids:container_id=2_ATLAhost external_ids:container_iface=ATLArouter
  ip link set f2f93280613b5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ATLAhost)
  create_netns_link
  ip link set f2f93280613b5_c netns $PID
  ip netns exec $PID ip link set dev f2f93280613b5_c name ATLArouter
  ip netns exec $PID ip link set ATLArouter up
fi
if [ "2_ATLArouter" == $container_name ] || [ "2_ATLAhost" == $container_name ]; then
  echo "Link between 2_ATLArouter (host) and 2_ATLAhost (ATLArouter)"
  port_id1=`ovs-vsctl get Interface 965ee8f95af15_l ofport`
  port_id2=`ovs-vsctl get Interface f2f93280613b5_l ofport`
  ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_MIAMrouter" == $container_name ]; then
  echo "Create Link for 2_MIAMrouter (host) on bridge "
  ip link add 1e8bee111bba5_l type veth peer name 1e8bee111bba5_c
  ovs-vsctl del-port 2-host 1e8bee111bba5_l
  ovs-vsctl add-port 2-host 1e8bee111bba5_l
  ovs-vsctl set interface 1e8bee111bba5_l external_ids:container_id=2_MIAMrouter external_ids:container_iface=host
  ip link set 1e8bee111bba5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_MIAMrouter)
  create_netns_link
  ip link set 1e8bee111bba5_c netns $PID
  ip netns exec $PID ip link set dev 1e8bee111bba5_c name host
  ip netns exec $PID ip link set host up
fi
if [ "2_MIAMhost" == $container_name ]; then
  echo "Create Link for 2_MIAMhost (MIAMrouter) on bridge "
  ip link add b0e88b477aae5_l type veth peer name b0e88b477aae5_c
  ovs-vsctl del-port 2-host b0e88b477aae5_l
  ovs-vsctl add-port 2-host b0e88b477aae5_l
  ovs-vsctl set interface b0e88b477aae5_l external_ids:container_id=2_MIAMhost external_ids:container_iface=MIAMrouter
  ip link set b0e88b477aae5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_MIAMhost)
  create_netns_link
  ip link set b0e88b477aae5_c netns $PID
  ip netns exec $PID ip link set dev b0e88b477aae5_c name MIAMrouter
  ip netns exec $PID ip link set MIAMrouter up
fi
if [ "2_MIAMrouter" == $container_name ] || [ "2_MIAMhost" == $container_name ]; then
  echo "Link between 2_MIAMrouter (host) and 2_MIAMhost (MIAMrouter)"
  port_id1=`ovs-vsctl get Interface 1e8bee111bba5_l ofport`
  port_id2=`ovs-vsctl get Interface b0e88b477aae5_l ofport`
  ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_ETHZ (1-CERN) on bridge "
  ip link add 8b47f22f749e5_l type veth peer name 8b47f22f749e5_c
  ovs-vsctl del-port l2-1 8b47f22f749e5_l
  ovs-vsctl add-port l2-1 8b47f22f749e5_l
  ovs-vsctl set interface 8b47f22f749e5_l external_ids:container_id=1_L2_UNIV_ETHZ external_ids:container_iface=1-CERN
  ip link set 8b47f22f749e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_ETHZ)
  create_netns_link
  ip link set 8b47f22f749e5_c netns $PID
  ip netns exec $PID ip link set dev 8b47f22f749e5_c name 1-CERN
  ip netns exec $PID ip link set 1-CERN up
  tc qdisc add dev 8b47f22f749e5_l root netem delay 1000 
  ovs-vsctl set interface 8b47f22f749e5_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_CERN (1-ETHZ) on bridge "
  ip link add 34747abce97c5_l type veth peer name 34747abce97c5_c
  ovs-vsctl del-port l2-1 34747abce97c5_l
  ovs-vsctl add-port l2-1 34747abce97c5_l
  ovs-vsctl set interface 34747abce97c5_l external_ids:container_id=1_L2_UNIV_CERN external_ids:container_iface=1-ETHZ
  ip link set 34747abce97c5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_CERN)
  create_netns_link
  ip link set 34747abce97c5_c netns $PID
  ip netns exec $PID ip link set dev 34747abce97c5_c name 1-ETHZ
  ip netns exec $PID ip link set 1-ETHZ up
  tc qdisc add dev 34747abce97c5_l root netem delay 1000 
  ovs-vsctl set interface 34747abce97c5_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ] || [ "1_L2_UNIV_CERN" == $container_name ]; then
  echo "Link between 1_L2_UNIV_ETHZ (1-CERN) and 1_L2_UNIV_CERN (1-ETHZ)"
  port_id1=`ovs-vsctl get Interface 8b47f22f749e5_l ofport`
  port_id2=`ovs-vsctl get Interface 34747abce97c5_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_ETHZ (1-EPFL) on bridge "
  ip link add b4669d5438e45_l type veth peer name b4669d5438e45_c
  ovs-vsctl del-port l2-1 b4669d5438e45_l
  ovs-vsctl add-port l2-1 b4669d5438e45_l
  ovs-vsctl set interface b4669d5438e45_l external_ids:container_id=1_L2_UNIV_ETHZ external_ids:container_iface=1-EPFL
  ip link set b4669d5438e45_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_ETHZ)
  create_netns_link
  ip link set b4669d5438e45_c netns $PID
  ip netns exec $PID ip link set dev b4669d5438e45_c name 1-EPFL
  ip netns exec $PID ip link set 1-EPFL up
  tc qdisc add dev b4669d5438e45_l root netem delay 1000 
  ovs-vsctl set interface b4669d5438e45_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_EPFL (1-ETHZ) on bridge "
  ip link add c573b88be4855_l type veth peer name c573b88be4855_c
  ovs-vsctl del-port l2-1 c573b88be4855_l
  ovs-vsctl add-port l2-1 c573b88be4855_l
  ovs-vsctl set interface c573b88be4855_l external_ids:container_id=1_L2_UNIV_EPFL external_ids:container_iface=1-ETHZ
  ip link set c573b88be4855_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_EPFL)
  create_netns_link
  ip link set c573b88be4855_c netns $PID
  ip netns exec $PID ip link set dev c573b88be4855_c name 1-ETHZ
  ip netns exec $PID ip link set 1-ETHZ up
  tc qdisc add dev c573b88be4855_l root netem delay 1000 
  ovs-vsctl set interface c573b88be4855_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ] || [ "1_L2_UNIV_EPFL" == $container_name ]; then
  echo "Link between 1_L2_UNIV_ETHZ (1-EPFL) and 1_L2_UNIV_EPFL (1-ETHZ)"
  port_id1=`ovs-vsctl get Interface b4669d5438e45_l ofport`
  port_id2=`ovs-vsctl get Interface c573b88be4855_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_CERN (1-EPFL) on bridge "
  ip link add 9dfea811e72a5_l type veth peer name 9dfea811e72a5_c
  ovs-vsctl del-port l2-1 9dfea811e72a5_l
  ovs-vsctl add-port l2-1 9dfea811e72a5_l
  ovs-vsctl set interface 9dfea811e72a5_l external_ids:container_id=1_L2_UNIV_CERN external_ids:container_iface=1-EPFL
  ip link set 9dfea811e72a5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_CERN)
  create_netns_link
  ip link set 9dfea811e72a5_c netns $PID
  ip netns exec $PID ip link set dev 9dfea811e72a5_c name 1-EPFL
  ip netns exec $PID ip link set 1-EPFL up
  tc qdisc add dev 9dfea811e72a5_l root netem delay 1000 
  ovs-vsctl set interface 9dfea811e72a5_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_EPFL (1-CERN) on bridge "
  ip link add 1f336da0e4e95_l type veth peer name 1f336da0e4e95_c
  ovs-vsctl del-port l2-1 1f336da0e4e95_l
  ovs-vsctl add-port l2-1 1f336da0e4e95_l
  ovs-vsctl set interface 1f336da0e4e95_l external_ids:container_id=1_L2_UNIV_EPFL external_ids:container_iface=1-CERN
  ip link set 1f336da0e4e95_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_EPFL)
  create_netns_link
  ip link set 1f336da0e4e95_c netns $PID
  ip netns exec $PID ip link set dev 1f336da0e4e95_c name 1-CERN
  ip netns exec $PID ip link set 1-CERN up
  tc qdisc add dev 1f336da0e4e95_l root netem delay 1000 
  ovs-vsctl set interface 1f336da0e4e95_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_CERN" == $container_name ] || [ "1_L2_UNIV_EPFL" == $container_name ]; then
  echo "Link between 1_L2_UNIV_CERN (1-EPFL) and 1_L2_UNIV_EPFL (1-CERN)"
  port_id1=`ovs-vsctl get Interface 9dfea811e72a5_l ofport`
  port_id2=`ovs-vsctl get Interface 1f336da0e4e95_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_CERN (1-student-1) on bridge "
  ip link add 678412fc9c435_l type veth peer name 678412fc9c435_c
  ovs-vsctl del-port l2-1 678412fc9c435_l
  ovs-vsctl add-port l2-1 678412fc9c435_l
  ovs-vsctl set interface 678412fc9c435_l external_ids:container_id=1_L2_UNIV_CERN external_ids:container_iface=1-student-1
  ip link set 678412fc9c435_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_CERN)
  create_netns_link
  ip link set 678412fc9c435_c netns $PID
  ip netns exec $PID ip link set dev 678412fc9c435_c name 1-student-1
  ip netns exec $PID ip link set 1-student-1 up
  tc qdisc add dev 678412fc9c435_l root netem delay 1000 
  ovs-vsctl set interface 678412fc9c435_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_student-1" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_student-1 (1-CERN) on bridge "
  ip link add cd24433aea185_l type veth peer name cd24433aea185_c
  ovs-vsctl del-port l2-1 cd24433aea185_l
  ovs-vsctl add-port l2-1 cd24433aea185_l
  ovs-vsctl set interface cd24433aea185_l external_ids:container_id=1_L2_UNIV_student-1 external_ids:container_iface=1-CERN
  ip link set cd24433aea185_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_student-1)
  create_netns_link
  ip link set cd24433aea185_c netns $PID
  ip netns exec $PID ip link set dev cd24433aea185_c name 1-CERN
  ip netns exec $PID ip link set 1-CERN up
  tc qdisc add dev cd24433aea185_l root netem delay 1000 
  ovs-vsctl set interface cd24433aea185_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_CERN" == $container_name ] || [ "1_L2_UNIV_student-1" == $container_name ]; then
  echo "Link between 1_L2_UNIV_CERN (1-student-1) and 1_L2_UNIV_student-1 (1-CERN)"
  port_id1=`ovs-vsctl get Interface 678412fc9c435_l ofport`
  port_id2=`ovs-vsctl get Interface cd24433aea185_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_CERN (1-staff-1) on bridge "
  ip link add 54e1a20a25295_l type veth peer name 54e1a20a25295_c
  ovs-vsctl del-port l2-1 54e1a20a25295_l
  ovs-vsctl add-port l2-1 54e1a20a25295_l
  ovs-vsctl set interface 54e1a20a25295_l external_ids:container_id=1_L2_UNIV_CERN external_ids:container_iface=1-staff-1
  ip link set 54e1a20a25295_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_CERN)
  create_netns_link
  ip link set 54e1a20a25295_c netns $PID
  ip netns exec $PID ip link set dev 54e1a20a25295_c name 1-staff-1
  ip netns exec $PID ip link set 1-staff-1 up
  tc qdisc add dev 54e1a20a25295_l root netem delay 1000 
  ovs-vsctl set interface 54e1a20a25295_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_staff-1" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_staff-1 (1-CERN) on bridge "
  ip link add f034ca4802985_l type veth peer name f034ca4802985_c
  ovs-vsctl del-port l2-1 f034ca4802985_l
  ovs-vsctl add-port l2-1 f034ca4802985_l
  ovs-vsctl set interface f034ca4802985_l external_ids:container_id=1_L2_UNIV_staff-1 external_ids:container_iface=1-CERN
  ip link set f034ca4802985_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_staff-1)
  create_netns_link
  ip link set f034ca4802985_c netns $PID
  ip netns exec $PID ip link set dev f034ca4802985_c name 1-CERN
  ip netns exec $PID ip link set 1-CERN up
  tc qdisc add dev f034ca4802985_l root netem delay 1000 
  ovs-vsctl set interface f034ca4802985_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_CERN" == $container_name ] || [ "1_L2_UNIV_staff-1" == $container_name ]; then
  echo "Link between 1_L2_UNIV_CERN (1-staff-1) and 1_L2_UNIV_staff-1 (1-CERN)"
  port_id1=`ovs-vsctl get Interface 54e1a20a25295_l ofport`
  port_id2=`ovs-vsctl get Interface f034ca4802985_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_ETHZ (1-student-2) on bridge "
  ip link add 7d4d0b12ef895_l type veth peer name 7d4d0b12ef895_c
  ovs-vsctl del-port l2-1 7d4d0b12ef895_l
  ovs-vsctl add-port l2-1 7d4d0b12ef895_l
  ovs-vsctl set interface 7d4d0b12ef895_l external_ids:container_id=1_L2_UNIV_ETHZ external_ids:container_iface=1-student-2
  ip link set 7d4d0b12ef895_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_ETHZ)
  create_netns_link
  ip link set 7d4d0b12ef895_c netns $PID
  ip netns exec $PID ip link set dev 7d4d0b12ef895_c name 1-student-2
  ip netns exec $PID ip link set 1-student-2 up
  tc qdisc add dev 7d4d0b12ef895_l root netem delay 1000 
  ovs-vsctl set interface 7d4d0b12ef895_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_student-2" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_student-2 (1-ETHZ) on bridge "
  ip link add 54cd9a328f405_l type veth peer name 54cd9a328f405_c
  ovs-vsctl del-port l2-1 54cd9a328f405_l
  ovs-vsctl add-port l2-1 54cd9a328f405_l
  ovs-vsctl set interface 54cd9a328f405_l external_ids:container_id=1_L2_UNIV_student-2 external_ids:container_iface=1-ETHZ
  ip link set 54cd9a328f405_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_student-2)
  create_netns_link
  ip link set 54cd9a328f405_c netns $PID
  ip netns exec $PID ip link set dev 54cd9a328f405_c name 1-ETHZ
  ip netns exec $PID ip link set 1-ETHZ up
  tc qdisc add dev 54cd9a328f405_l root netem delay 1000 
  ovs-vsctl set interface 54cd9a328f405_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ] || [ "1_L2_UNIV_student-2" == $container_name ]; then
  echo "Link between 1_L2_UNIV_ETHZ (1-student-2) and 1_L2_UNIV_student-2 (1-ETHZ)"
  port_id1=`ovs-vsctl get Interface 7d4d0b12ef895_l ofport`
  port_id2=`ovs-vsctl get Interface 54cd9a328f405_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_ETHZ (1-staff-2) on bridge "
  ip link add e4f4630af3725_l type veth peer name e4f4630af3725_c
  ovs-vsctl del-port l2-1 e4f4630af3725_l
  ovs-vsctl add-port l2-1 e4f4630af3725_l
  ovs-vsctl set interface e4f4630af3725_l external_ids:container_id=1_L2_UNIV_ETHZ external_ids:container_iface=1-staff-2
  ip link set e4f4630af3725_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_ETHZ)
  create_netns_link
  ip link set e4f4630af3725_c netns $PID
  ip netns exec $PID ip link set dev e4f4630af3725_c name 1-staff-2
  ip netns exec $PID ip link set 1-staff-2 up
  tc qdisc add dev e4f4630af3725_l root netem delay 1000 
  ovs-vsctl set interface e4f4630af3725_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_staff-2" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_staff-2 (1-ETHZ) on bridge "
  ip link add 90251347b18b5_l type veth peer name 90251347b18b5_c
  ovs-vsctl del-port l2-1 90251347b18b5_l
  ovs-vsctl add-port l2-1 90251347b18b5_l
  ovs-vsctl set interface 90251347b18b5_l external_ids:container_id=1_L2_UNIV_staff-2 external_ids:container_iface=1-ETHZ
  ip link set 90251347b18b5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_staff-2)
  create_netns_link
  ip link set 90251347b18b5_c netns $PID
  ip netns exec $PID ip link set dev 90251347b18b5_c name 1-ETHZ
  ip netns exec $PID ip link set 1-ETHZ up
  tc qdisc add dev 90251347b18b5_l root netem delay 1000 
  ovs-vsctl set interface 90251347b18b5_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ] || [ "1_L2_UNIV_staff-2" == $container_name ]; then
  echo "Link between 1_L2_UNIV_ETHZ (1-staff-2) and 1_L2_UNIV_staff-2 (1-ETHZ)"
  port_id1=`ovs-vsctl get Interface e4f4630af3725_l ofport`
  port_id2=`ovs-vsctl get Interface 90251347b18b5_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_EPFL (1-student-3) on bridge "
  ip link add 403bd02b92005_l type veth peer name 403bd02b92005_c
  ovs-vsctl del-port l2-1 403bd02b92005_l
  ovs-vsctl add-port l2-1 403bd02b92005_l
  ovs-vsctl set interface 403bd02b92005_l external_ids:container_id=1_L2_UNIV_EPFL external_ids:container_iface=1-student-3
  ip link set 403bd02b92005_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_EPFL)
  create_netns_link
  ip link set 403bd02b92005_c netns $PID
  ip netns exec $PID ip link set dev 403bd02b92005_c name 1-student-3
  ip netns exec $PID ip link set 1-student-3 up
  tc qdisc add dev 403bd02b92005_l root netem delay 1000 
  ovs-vsctl set interface 403bd02b92005_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_student-3" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_student-3 (1-EPFL) on bridge "
  ip link add 392c9e7407f85_l type veth peer name 392c9e7407f85_c
  ovs-vsctl del-port l2-1 392c9e7407f85_l
  ovs-vsctl add-port l2-1 392c9e7407f85_l
  ovs-vsctl set interface 392c9e7407f85_l external_ids:container_id=1_L2_UNIV_student-3 external_ids:container_iface=1-EPFL
  ip link set 392c9e7407f85_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_student-3)
  create_netns_link
  ip link set 392c9e7407f85_c netns $PID
  ip netns exec $PID ip link set dev 392c9e7407f85_c name 1-EPFL
  ip netns exec $PID ip link set 1-EPFL up
  tc qdisc add dev 392c9e7407f85_l root netem delay 1000 
  ovs-vsctl set interface 392c9e7407f85_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_EPFL" == $container_name ] || [ "1_L2_UNIV_student-3" == $container_name ]; then
  echo "Link between 1_L2_UNIV_EPFL (1-student-3) and 1_L2_UNIV_student-3 (1-EPFL)"
  port_id1=`ovs-vsctl get Interface 403bd02b92005_l ofport`
  port_id2=`ovs-vsctl get Interface 392c9e7407f85_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_EPFL (1-staff-3) on bridge "
  ip link add 9106141effe15_l type veth peer name 9106141effe15_c
  ovs-vsctl del-port l2-1 9106141effe15_l
  ovs-vsctl add-port l2-1 9106141effe15_l
  ovs-vsctl set interface 9106141effe15_l external_ids:container_id=1_L2_UNIV_EPFL external_ids:container_iface=1-staff-3
  ip link set 9106141effe15_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_EPFL)
  create_netns_link
  ip link set 9106141effe15_c netns $PID
  ip netns exec $PID ip link set dev 9106141effe15_c name 1-staff-3
  ip netns exec $PID ip link set 1-staff-3 up
  tc qdisc add dev 9106141effe15_l root netem delay 1000 
  ovs-vsctl set interface 9106141effe15_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_staff-3" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_staff-3 (1-EPFL) on bridge "
  ip link add ebff9b083bbd5_l type veth peer name ebff9b083bbd5_c
  ovs-vsctl del-port l2-1 ebff9b083bbd5_l
  ovs-vsctl add-port l2-1 ebff9b083bbd5_l
  ovs-vsctl set interface ebff9b083bbd5_l external_ids:container_id=1_L2_UNIV_staff-3 external_ids:container_iface=1-EPFL
  ip link set ebff9b083bbd5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_staff-3)
  create_netns_link
  ip link set ebff9b083bbd5_c netns $PID
  ip netns exec $PID ip link set dev ebff9b083bbd5_c name 1-EPFL
  ip netns exec $PID ip link set 1-EPFL up
  tc qdisc add dev ebff9b083bbd5_l root netem delay 1000 
  ovs-vsctl set interface ebff9b083bbd5_l ingress_policing_rate=10000
fi
if [ "1_L2_UNIV_EPFL" == $container_name ] || [ "1_L2_UNIV_staff-3" == $container_name ]; then
  echo "Link between 1_L2_UNIV_EPFL (1-staff-3) and 1_L2_UNIV_staff-3 (1-EPFL)"
  port_id1=`ovs-vsctl get Interface 9106141effe15_l ofport`
  port_id2=`ovs-vsctl get Interface ebff9b083bbd5_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_ZURIrouter" == $container_name ]; then
  echo "Create Link for 1_ZURIrouter (ZURI-L2) on bridge "
  ip link add ee88ffbd51e55_l type veth peer name ee88ffbd51e55_c
  ovs-vsctl del-port l2-1 ee88ffbd51e55_l
  ovs-vsctl add-port l2-1 ee88ffbd51e55_l
  ovs-vsctl set interface ee88ffbd51e55_l external_ids:container_id=1_ZURIrouter external_ids:container_iface=ZURI-L2
  ip link set ee88ffbd51e55_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ZURIrouter)
  create_netns_link
  ip link set ee88ffbd51e55_c netns $PID
  ip netns exec $PID ip link set dev ee88ffbd51e55_c name ZURI-L2
  ip netns exec $PID ip link set ZURI-L2 up
fi
if [ "1_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_ETHZ (ZURIrouter) on bridge "
  ip link add c809849a08c95_l type veth peer name c809849a08c95_c
  ovs-vsctl del-port l2-1 c809849a08c95_l
  ovs-vsctl add-port l2-1 c809849a08c95_l
  ovs-vsctl set interface c809849a08c95_l external_ids:container_id=1_L2_UNIV_ETHZ external_ids:container_iface=ZURIrouter
  ip link set c809849a08c95_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_ETHZ)
  create_netns_link
  ip link set c809849a08c95_c netns $PID
  ip netns exec $PID ip link set dev c809849a08c95_c name ZURIrouter
  ip netns exec $PID ip link set ZURIrouter up
fi
if [ "1_ZURIrouter" == $container_name ] || [ "1_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Link between 1_ZURIrouter (ZURI-L2) and 1_L2_UNIV_ETHZ (ZURIrouter)"
  port_id1=`ovs-vsctl get Interface ee88ffbd51e55_l ofport`
  port_id2=`ovs-vsctl get Interface c809849a08c95_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_GENErouter" == $container_name ]; then
  echo "Create Link for 1_GENErouter (GENE-L2) on bridge "
  ip link add b9fa783cb3e55_l type veth peer name b9fa783cb3e55_c
  ovs-vsctl del-port l2-1 b9fa783cb3e55_l
  ovs-vsctl add-port l2-1 b9fa783cb3e55_l
  ovs-vsctl set interface b9fa783cb3e55_l external_ids:container_id=1_GENErouter external_ids:container_iface=GENE-L2
  ip link set b9fa783cb3e55_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_GENErouter)
  create_netns_link
  ip link set b9fa783cb3e55_c netns $PID
  ip netns exec $PID ip link set dev b9fa783cb3e55_c name GENE-L2
  ip netns exec $PID ip link set GENE-L2 up
fi
if [ "1_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 1_L2_UNIV_CERN (GENErouter) on bridge "
  ip link add c86b623846965_l type veth peer name c86b623846965_c
  ovs-vsctl del-port l2-1 c86b623846965_l
  ovs-vsctl add-port l2-1 c86b623846965_l
  ovs-vsctl set interface c86b623846965_l external_ids:container_id=1_L2_UNIV_CERN external_ids:container_iface=GENErouter
  ip link set c86b623846965_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_L2_UNIV_CERN)
  create_netns_link
  ip link set c86b623846965_c netns $PID
  ip netns exec $PID ip link set dev c86b623846965_c name GENErouter
  ip netns exec $PID ip link set GENErouter up
fi
if [ "1_GENErouter" == $container_name ] || [ "1_L2_UNIV_CERN" == $container_name ]; then
  echo "Link between 1_GENErouter (GENE-L2) and 1_L2_UNIV_CERN (GENErouter)"
  port_id1=`ovs-vsctl get Interface b9fa783cb3e55_l ofport`
  port_id2=`ovs-vsctl get Interface c86b623846965_l ofport`
  ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_ETHZ (2-CERN) on bridge "
  ip link add cc21683f7e265_l type veth peer name cc21683f7e265_c
  ovs-vsctl del-port l2-2 cc21683f7e265_l
  ovs-vsctl add-port l2-2 cc21683f7e265_l
  ovs-vsctl set interface cc21683f7e265_l external_ids:container_id=2_L2_UNIV_ETHZ external_ids:container_iface=2-CERN
  ip link set cc21683f7e265_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_ETHZ)
  create_netns_link
  ip link set cc21683f7e265_c netns $PID
  ip netns exec $PID ip link set dev cc21683f7e265_c name 2-CERN
  ip netns exec $PID ip link set 2-CERN up
  tc qdisc add dev cc21683f7e265_l root netem delay 1000 
  ovs-vsctl set interface cc21683f7e265_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_CERN (2-ETHZ) on bridge "
  ip link add c1b2bc185ac15_l type veth peer name c1b2bc185ac15_c
  ovs-vsctl del-port l2-2 c1b2bc185ac15_l
  ovs-vsctl add-port l2-2 c1b2bc185ac15_l
  ovs-vsctl set interface c1b2bc185ac15_l external_ids:container_id=2_L2_UNIV_CERN external_ids:container_iface=2-ETHZ
  ip link set c1b2bc185ac15_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_CERN)
  create_netns_link
  ip link set c1b2bc185ac15_c netns $PID
  ip netns exec $PID ip link set dev c1b2bc185ac15_c name 2-ETHZ
  ip netns exec $PID ip link set 2-ETHZ up
  tc qdisc add dev c1b2bc185ac15_l root netem delay 1000 
  ovs-vsctl set interface c1b2bc185ac15_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ] || [ "2_L2_UNIV_CERN" == $container_name ]; then
  echo "Link between 2_L2_UNIV_ETHZ (2-CERN) and 2_L2_UNIV_CERN (2-ETHZ)"
  port_id1=`ovs-vsctl get Interface cc21683f7e265_l ofport`
  port_id2=`ovs-vsctl get Interface c1b2bc185ac15_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_ETHZ (2-EPFL) on bridge "
  ip link add 3fca714f72cf5_l type veth peer name 3fca714f72cf5_c
  ovs-vsctl del-port l2-2 3fca714f72cf5_l
  ovs-vsctl add-port l2-2 3fca714f72cf5_l
  ovs-vsctl set interface 3fca714f72cf5_l external_ids:container_id=2_L2_UNIV_ETHZ external_ids:container_iface=2-EPFL
  ip link set 3fca714f72cf5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_ETHZ)
  create_netns_link
  ip link set 3fca714f72cf5_c netns $PID
  ip netns exec $PID ip link set dev 3fca714f72cf5_c name 2-EPFL
  ip netns exec $PID ip link set 2-EPFL up
  tc qdisc add dev 3fca714f72cf5_l root netem delay 1000 
  ovs-vsctl set interface 3fca714f72cf5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_EPFL (2-ETHZ) on bridge "
  ip link add e1837048f81f5_l type veth peer name e1837048f81f5_c
  ovs-vsctl del-port l2-2 e1837048f81f5_l
  ovs-vsctl add-port l2-2 e1837048f81f5_l
  ovs-vsctl set interface e1837048f81f5_l external_ids:container_id=2_L2_UNIV_EPFL external_ids:container_iface=2-ETHZ
  ip link set e1837048f81f5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_EPFL)
  create_netns_link
  ip link set e1837048f81f5_c netns $PID
  ip netns exec $PID ip link set dev e1837048f81f5_c name 2-ETHZ
  ip netns exec $PID ip link set 2-ETHZ up
  tc qdisc add dev e1837048f81f5_l root netem delay 1000 
  ovs-vsctl set interface e1837048f81f5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ] || [ "2_L2_UNIV_EPFL" == $container_name ]; then
  echo "Link between 2_L2_UNIV_ETHZ (2-EPFL) and 2_L2_UNIV_EPFL (2-ETHZ)"
  port_id1=`ovs-vsctl get Interface 3fca714f72cf5_l ofport`
  port_id2=`ovs-vsctl get Interface e1837048f81f5_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_CERN (2-EPFL) on bridge "
  ip link add e882d64b2a6e5_l type veth peer name e882d64b2a6e5_c
  ovs-vsctl del-port l2-2 e882d64b2a6e5_l
  ovs-vsctl add-port l2-2 e882d64b2a6e5_l
  ovs-vsctl set interface e882d64b2a6e5_l external_ids:container_id=2_L2_UNIV_CERN external_ids:container_iface=2-EPFL
  ip link set e882d64b2a6e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_CERN)
  create_netns_link
  ip link set e882d64b2a6e5_c netns $PID
  ip netns exec $PID ip link set dev e882d64b2a6e5_c name 2-EPFL
  ip netns exec $PID ip link set 2-EPFL up
  tc qdisc add dev e882d64b2a6e5_l root netem delay 1000 
  ovs-vsctl set interface e882d64b2a6e5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_EPFL (2-CERN) on bridge "
  ip link add 815c35d2df415_l type veth peer name 815c35d2df415_c
  ovs-vsctl del-port l2-2 815c35d2df415_l
  ovs-vsctl add-port l2-2 815c35d2df415_l
  ovs-vsctl set interface 815c35d2df415_l external_ids:container_id=2_L2_UNIV_EPFL external_ids:container_iface=2-CERN
  ip link set 815c35d2df415_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_EPFL)
  create_netns_link
  ip link set 815c35d2df415_c netns $PID
  ip netns exec $PID ip link set dev 815c35d2df415_c name 2-CERN
  ip netns exec $PID ip link set 2-CERN up
  tc qdisc add dev 815c35d2df415_l root netem delay 1000 
  ovs-vsctl set interface 815c35d2df415_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_CERN" == $container_name ] || [ "2_L2_UNIV_EPFL" == $container_name ]; then
  echo "Link between 2_L2_UNIV_CERN (2-EPFL) and 2_L2_UNIV_EPFL (2-CERN)"
  port_id1=`ovs-vsctl get Interface e882d64b2a6e5_l ofport`
  port_id2=`ovs-vsctl get Interface 815c35d2df415_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_CERN (2-student-1) on bridge "
  ip link add 112b35cd3c3a5_l type veth peer name 112b35cd3c3a5_c
  ovs-vsctl del-port l2-2 112b35cd3c3a5_l
  ovs-vsctl add-port l2-2 112b35cd3c3a5_l
  ovs-vsctl set interface 112b35cd3c3a5_l external_ids:container_id=2_L2_UNIV_CERN external_ids:container_iface=2-student-1
  ip link set 112b35cd3c3a5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_CERN)
  create_netns_link
  ip link set 112b35cd3c3a5_c netns $PID
  ip netns exec $PID ip link set dev 112b35cd3c3a5_c name 2-student-1
  ip netns exec $PID ip link set 2-student-1 up
  tc qdisc add dev 112b35cd3c3a5_l root netem delay 1000 
  ovs-vsctl set interface 112b35cd3c3a5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_student-1" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_student-1 (2-CERN) on bridge "
  ip link add 3fa562e686e45_l type veth peer name 3fa562e686e45_c
  ovs-vsctl del-port l2-2 3fa562e686e45_l
  ovs-vsctl add-port l2-2 3fa562e686e45_l
  ovs-vsctl set interface 3fa562e686e45_l external_ids:container_id=2_L2_UNIV_student-1 external_ids:container_iface=2-CERN
  ip link set 3fa562e686e45_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_student-1)
  create_netns_link
  ip link set 3fa562e686e45_c netns $PID
  ip netns exec $PID ip link set dev 3fa562e686e45_c name 2-CERN
  ip netns exec $PID ip link set 2-CERN up
  tc qdisc add dev 3fa562e686e45_l root netem delay 1000 
  ovs-vsctl set interface 3fa562e686e45_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_CERN" == $container_name ] || [ "2_L2_UNIV_student-1" == $container_name ]; then
  echo "Link between 2_L2_UNIV_CERN (2-student-1) and 2_L2_UNIV_student-1 (2-CERN)"
  port_id1=`ovs-vsctl get Interface 112b35cd3c3a5_l ofport`
  port_id2=`ovs-vsctl get Interface 3fa562e686e45_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_CERN (2-staff-1) on bridge "
  ip link add de3d6e5bb8ae5_l type veth peer name de3d6e5bb8ae5_c
  ovs-vsctl del-port l2-2 de3d6e5bb8ae5_l
  ovs-vsctl add-port l2-2 de3d6e5bb8ae5_l
  ovs-vsctl set interface de3d6e5bb8ae5_l external_ids:container_id=2_L2_UNIV_CERN external_ids:container_iface=2-staff-1
  ip link set de3d6e5bb8ae5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_CERN)
  create_netns_link
  ip link set de3d6e5bb8ae5_c netns $PID
  ip netns exec $PID ip link set dev de3d6e5bb8ae5_c name 2-staff-1
  ip netns exec $PID ip link set 2-staff-1 up
  tc qdisc add dev de3d6e5bb8ae5_l root netem delay 1000 
  ovs-vsctl set interface de3d6e5bb8ae5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_staff-1" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_staff-1 (2-CERN) on bridge "
  ip link add cb5fff76ff925_l type veth peer name cb5fff76ff925_c
  ovs-vsctl del-port l2-2 cb5fff76ff925_l
  ovs-vsctl add-port l2-2 cb5fff76ff925_l
  ovs-vsctl set interface cb5fff76ff925_l external_ids:container_id=2_L2_UNIV_staff-1 external_ids:container_iface=2-CERN
  ip link set cb5fff76ff925_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_staff-1)
  create_netns_link
  ip link set cb5fff76ff925_c netns $PID
  ip netns exec $PID ip link set dev cb5fff76ff925_c name 2-CERN
  ip netns exec $PID ip link set 2-CERN up
  tc qdisc add dev cb5fff76ff925_l root netem delay 1000 
  ovs-vsctl set interface cb5fff76ff925_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_CERN" == $container_name ] || [ "2_L2_UNIV_staff-1" == $container_name ]; then
  echo "Link between 2_L2_UNIV_CERN (2-staff-1) and 2_L2_UNIV_staff-1 (2-CERN)"
  port_id1=`ovs-vsctl get Interface de3d6e5bb8ae5_l ofport`
  port_id2=`ovs-vsctl get Interface cb5fff76ff925_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_ETHZ (2-student-2) on bridge "
  ip link add a7f5ad2b16eb5_l type veth peer name a7f5ad2b16eb5_c
  ovs-vsctl del-port l2-2 a7f5ad2b16eb5_l
  ovs-vsctl add-port l2-2 a7f5ad2b16eb5_l
  ovs-vsctl set interface a7f5ad2b16eb5_l external_ids:container_id=2_L2_UNIV_ETHZ external_ids:container_iface=2-student-2
  ip link set a7f5ad2b16eb5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_ETHZ)
  create_netns_link
  ip link set a7f5ad2b16eb5_c netns $PID
  ip netns exec $PID ip link set dev a7f5ad2b16eb5_c name 2-student-2
  ip netns exec $PID ip link set 2-student-2 up
  tc qdisc add dev a7f5ad2b16eb5_l root netem delay 1000 
  ovs-vsctl set interface a7f5ad2b16eb5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_student-2" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_student-2 (2-ETHZ) on bridge "
  ip link add 484efdf909e45_l type veth peer name 484efdf909e45_c
  ovs-vsctl del-port l2-2 484efdf909e45_l
  ovs-vsctl add-port l2-2 484efdf909e45_l
  ovs-vsctl set interface 484efdf909e45_l external_ids:container_id=2_L2_UNIV_student-2 external_ids:container_iface=2-ETHZ
  ip link set 484efdf909e45_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_student-2)
  create_netns_link
  ip link set 484efdf909e45_c netns $PID
  ip netns exec $PID ip link set dev 484efdf909e45_c name 2-ETHZ
  ip netns exec $PID ip link set 2-ETHZ up
  tc qdisc add dev 484efdf909e45_l root netem delay 1000 
  ovs-vsctl set interface 484efdf909e45_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ] || [ "2_L2_UNIV_student-2" == $container_name ]; then
  echo "Link between 2_L2_UNIV_ETHZ (2-student-2) and 2_L2_UNIV_student-2 (2-ETHZ)"
  port_id1=`ovs-vsctl get Interface a7f5ad2b16eb5_l ofport`
  port_id2=`ovs-vsctl get Interface 484efdf909e45_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_ETHZ (2-staff-2) on bridge "
  ip link add e7e2185aa5345_l type veth peer name e7e2185aa5345_c
  ovs-vsctl del-port l2-2 e7e2185aa5345_l
  ovs-vsctl add-port l2-2 e7e2185aa5345_l
  ovs-vsctl set interface e7e2185aa5345_l external_ids:container_id=2_L2_UNIV_ETHZ external_ids:container_iface=2-staff-2
  ip link set e7e2185aa5345_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_ETHZ)
  create_netns_link
  ip link set e7e2185aa5345_c netns $PID
  ip netns exec $PID ip link set dev e7e2185aa5345_c name 2-staff-2
  ip netns exec $PID ip link set 2-staff-2 up
  tc qdisc add dev e7e2185aa5345_l root netem delay 1000 
  ovs-vsctl set interface e7e2185aa5345_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_staff-2" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_staff-2 (2-ETHZ) on bridge "
  ip link add 5273a31aff8a5_l type veth peer name 5273a31aff8a5_c
  ovs-vsctl del-port l2-2 5273a31aff8a5_l
  ovs-vsctl add-port l2-2 5273a31aff8a5_l
  ovs-vsctl set interface 5273a31aff8a5_l external_ids:container_id=2_L2_UNIV_staff-2 external_ids:container_iface=2-ETHZ
  ip link set 5273a31aff8a5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_staff-2)
  create_netns_link
  ip link set 5273a31aff8a5_c netns $PID
  ip netns exec $PID ip link set dev 5273a31aff8a5_c name 2-ETHZ
  ip netns exec $PID ip link set 2-ETHZ up
  tc qdisc add dev 5273a31aff8a5_l root netem delay 1000 
  ovs-vsctl set interface 5273a31aff8a5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ] || [ "2_L2_UNIV_staff-2" == $container_name ]; then
  echo "Link between 2_L2_UNIV_ETHZ (2-staff-2) and 2_L2_UNIV_staff-2 (2-ETHZ)"
  port_id1=`ovs-vsctl get Interface e7e2185aa5345_l ofport`
  port_id2=`ovs-vsctl get Interface 5273a31aff8a5_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_EPFL (2-student-3) on bridge "
  ip link add 221d3acdcd3c5_l type veth peer name 221d3acdcd3c5_c
  ovs-vsctl del-port l2-2 221d3acdcd3c5_l
  ovs-vsctl add-port l2-2 221d3acdcd3c5_l
  ovs-vsctl set interface 221d3acdcd3c5_l external_ids:container_id=2_L2_UNIV_EPFL external_ids:container_iface=2-student-3
  ip link set 221d3acdcd3c5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_EPFL)
  create_netns_link
  ip link set 221d3acdcd3c5_c netns $PID
  ip netns exec $PID ip link set dev 221d3acdcd3c5_c name 2-student-3
  ip netns exec $PID ip link set 2-student-3 up
  tc qdisc add dev 221d3acdcd3c5_l root netem delay 1000 
  ovs-vsctl set interface 221d3acdcd3c5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_student-3" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_student-3 (2-EPFL) on bridge "
  ip link add 26b86114725d5_l type veth peer name 26b86114725d5_c
  ovs-vsctl del-port l2-2 26b86114725d5_l
  ovs-vsctl add-port l2-2 26b86114725d5_l
  ovs-vsctl set interface 26b86114725d5_l external_ids:container_id=2_L2_UNIV_student-3 external_ids:container_iface=2-EPFL
  ip link set 26b86114725d5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_student-3)
  create_netns_link
  ip link set 26b86114725d5_c netns $PID
  ip netns exec $PID ip link set dev 26b86114725d5_c name 2-EPFL
  ip netns exec $PID ip link set 2-EPFL up
  tc qdisc add dev 26b86114725d5_l root netem delay 1000 
  ovs-vsctl set interface 26b86114725d5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_EPFL" == $container_name ] || [ "2_L2_UNIV_student-3" == $container_name ]; then
  echo "Link between 2_L2_UNIV_EPFL (2-student-3) and 2_L2_UNIV_student-3 (2-EPFL)"
  port_id1=`ovs-vsctl get Interface 221d3acdcd3c5_l ofport`
  port_id2=`ovs-vsctl get Interface 26b86114725d5_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_L2_UNIV_EPFL" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_EPFL (2-staff-3) on bridge "
  ip link add 180143d5a1a05_l type veth peer name 180143d5a1a05_c
  ovs-vsctl del-port l2-2 180143d5a1a05_l
  ovs-vsctl add-port l2-2 180143d5a1a05_l
  ovs-vsctl set interface 180143d5a1a05_l external_ids:container_id=2_L2_UNIV_EPFL external_ids:container_iface=2-staff-3
  ip link set 180143d5a1a05_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_EPFL)
  create_netns_link
  ip link set 180143d5a1a05_c netns $PID
  ip netns exec $PID ip link set dev 180143d5a1a05_c name 2-staff-3
  ip netns exec $PID ip link set 2-staff-3 up
  tc qdisc add dev 180143d5a1a05_l root netem delay 1000 
  ovs-vsctl set interface 180143d5a1a05_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_staff-3" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_staff-3 (2-EPFL) on bridge "
  ip link add cb59f97af79e5_l type veth peer name cb59f97af79e5_c
  ovs-vsctl del-port l2-2 cb59f97af79e5_l
  ovs-vsctl add-port l2-2 cb59f97af79e5_l
  ovs-vsctl set interface cb59f97af79e5_l external_ids:container_id=2_L2_UNIV_staff-3 external_ids:container_iface=2-EPFL
  ip link set cb59f97af79e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_staff-3)
  create_netns_link
  ip link set cb59f97af79e5_c netns $PID
  ip netns exec $PID ip link set dev cb59f97af79e5_c name 2-EPFL
  ip netns exec $PID ip link set 2-EPFL up
  tc qdisc add dev cb59f97af79e5_l root netem delay 1000 
  ovs-vsctl set interface cb59f97af79e5_l ingress_policing_rate=10000
fi
if [ "2_L2_UNIV_EPFL" == $container_name ] || [ "2_L2_UNIV_staff-3" == $container_name ]; then
  echo "Link between 2_L2_UNIV_EPFL (2-staff-3) and 2_L2_UNIV_staff-3 (2-EPFL)"
  port_id1=`ovs-vsctl get Interface 180143d5a1a05_l ofport`
  port_id2=`ovs-vsctl get Interface cb59f97af79e5_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_ZURIrouter" == $container_name ]; then
  echo "Create Link for 2_ZURIrouter (ZURI-L2) on bridge "
  ip link add bea9dacb3eee5_l type veth peer name bea9dacb3eee5_c
  ovs-vsctl del-port l2-2 bea9dacb3eee5_l
  ovs-vsctl add-port l2-2 bea9dacb3eee5_l
  ovs-vsctl set interface bea9dacb3eee5_l external_ids:container_id=2_ZURIrouter external_ids:container_iface=ZURI-L2
  ip link set bea9dacb3eee5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ZURIrouter)
  create_netns_link
  ip link set bea9dacb3eee5_c netns $PID
  ip netns exec $PID ip link set dev bea9dacb3eee5_c name ZURI-L2
  ip netns exec $PID ip link set ZURI-L2 up
fi
if [ "2_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_ETHZ (ZURIrouter) on bridge "
  ip link add 3dbfa967cf855_l type veth peer name 3dbfa967cf855_c
  ovs-vsctl del-port l2-2 3dbfa967cf855_l
  ovs-vsctl add-port l2-2 3dbfa967cf855_l
  ovs-vsctl set interface 3dbfa967cf855_l external_ids:container_id=2_L2_UNIV_ETHZ external_ids:container_iface=ZURIrouter
  ip link set 3dbfa967cf855_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_ETHZ)
  create_netns_link
  ip link set 3dbfa967cf855_c netns $PID
  ip netns exec $PID ip link set dev 3dbfa967cf855_c name ZURIrouter
  ip netns exec $PID ip link set ZURIrouter up
fi
if [ "2_ZURIrouter" == $container_name ] || [ "2_L2_UNIV_ETHZ" == $container_name ]; then
  echo "Link between 2_ZURIrouter (ZURI-L2) and 2_L2_UNIV_ETHZ (ZURIrouter)"
  port_id1=`ovs-vsctl get Interface bea9dacb3eee5_l ofport`
  port_id2=`ovs-vsctl get Interface 3dbfa967cf855_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_GENErouter" == $container_name ]; then
  echo "Create Link for 2_GENErouter (GENE-L2) on bridge "
  ip link add 02a552141d625_l type veth peer name 02a552141d625_c
  ovs-vsctl del-port l2-2 02a552141d625_l
  ovs-vsctl add-port l2-2 02a552141d625_l
  ovs-vsctl set interface 02a552141d625_l external_ids:container_id=2_GENErouter external_ids:container_iface=GENE-L2
  ip link set 02a552141d625_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_GENErouter)
  create_netns_link
  ip link set 02a552141d625_c netns $PID
  ip netns exec $PID ip link set dev 02a552141d625_c name GENE-L2
  ip netns exec $PID ip link set GENE-L2 up
fi
if [ "2_L2_UNIV_CERN" == $container_name ]; then
  echo "Create Link for 2_L2_UNIV_CERN (GENErouter) on bridge "
  ip link add 929ac03595d75_l type veth peer name 929ac03595d75_c
  ovs-vsctl del-port l2-2 929ac03595d75_l
  ovs-vsctl add-port l2-2 929ac03595d75_l
  ovs-vsctl set interface 929ac03595d75_l external_ids:container_id=2_L2_UNIV_CERN external_ids:container_iface=GENErouter
  ip link set 929ac03595d75_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_L2_UNIV_CERN)
  create_netns_link
  ip link set 929ac03595d75_c netns $PID
  ip netns exec $PID ip link set dev 929ac03595d75_c name GENErouter
  ip netns exec $PID ip link set GENErouter up
fi
if [ "2_GENErouter" == $container_name ] || [ "2_L2_UNIV_CERN" == $container_name ]; then
  echo "Link between 2_GENErouter (GENE-L2) and 2_L2_UNIV_CERN (GENErouter)"
  port_id1=`ovs-vsctl get Interface 02a552141d625_l ofport`
  port_id2=`ovs-vsctl get Interface 929ac03595d75_l ofport`
  ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_ZURIrouter" == $container_name ]; then
  echo "Create Link for 1_ZURIrouter (port_PARI) on bridge "
  ip link add 57f7628155a65_l type veth peer name 57f7628155a65_c
  ovs-vsctl del-port int-1 57f7628155a65_l
  ovs-vsctl add-port int-1 57f7628155a65_l
  ovs-vsctl set interface 57f7628155a65_l external_ids:container_id=1_ZURIrouter external_ids:container_iface=port_PARI
  ip link set 57f7628155a65_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ZURIrouter)
  create_netns_link
  ip link set 57f7628155a65_c netns $PID
  ip netns exec $PID ip link set dev 57f7628155a65_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev 57f7628155a65_l root netem delay 100 
  ovs-vsctl set interface 57f7628155a65_l ingress_policing_rate=100000
fi
if [ "1_PARIrouter" == $container_name ]; then
  echo "Create Link for 1_PARIrouter (port_ZURI) on bridge "
  ip link add 2d0661670ed85_l type veth peer name 2d0661670ed85_c
  ovs-vsctl del-port int-1 2d0661670ed85_l
  ovs-vsctl add-port int-1 2d0661670ed85_l
  ovs-vsctl set interface 2d0661670ed85_l external_ids:container_id=1_PARIrouter external_ids:container_iface=port_ZURI
  ip link set 2d0661670ed85_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_PARIrouter)
  create_netns_link
  ip link set 2d0661670ed85_c netns $PID
  ip netns exec $PID ip link set dev 2d0661670ed85_c name port_ZURI
  ip netns exec $PID ip link set port_ZURI up
  tc qdisc add dev 2d0661670ed85_l root netem delay 100 
  ovs-vsctl set interface 2d0661670ed85_l ingress_policing_rate=100000
fi
if [ "1_ZURIrouter" == $container_name ] || [ "1_PARIrouter" == $container_name ]; then
  echo "Link between 1_ZURIrouter (port_PARI) and 1_PARIrouter (port_ZURI)"
  port_id1=`ovs-vsctl get Interface 57f7628155a65_l ofport`
  port_id2=`ovs-vsctl get Interface 2d0661670ed85_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_ZURIrouter" == $container_name ]; then
  echo "Create Link for 1_ZURIrouter (port_LOND) on bridge "
  ip link add d8b4f41fd1045_l type veth peer name d8b4f41fd1045_c
  ovs-vsctl del-port int-1 d8b4f41fd1045_l
  ovs-vsctl add-port int-1 d8b4f41fd1045_l
  ovs-vsctl set interface d8b4f41fd1045_l external_ids:container_id=1_ZURIrouter external_ids:container_iface=port_LOND
  ip link set d8b4f41fd1045_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ZURIrouter)
  create_netns_link
  ip link set d8b4f41fd1045_c netns $PID
  ip netns exec $PID ip link set dev d8b4f41fd1045_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev d8b4f41fd1045_l root netem delay 1000 
  ovs-vsctl set interface d8b4f41fd1045_l ingress_policing_rate=100000
fi
if [ "1_LONDrouter" == $container_name ]; then
  echo "Create Link for 1_LONDrouter (port_ZURI) on bridge "
  ip link add c62bc80903ee5_l type veth peer name c62bc80903ee5_c
  ovs-vsctl del-port int-1 c62bc80903ee5_l
  ovs-vsctl add-port int-1 c62bc80903ee5_l
  ovs-vsctl set interface c62bc80903ee5_l external_ids:container_id=1_LONDrouter external_ids:container_iface=port_ZURI
  ip link set c62bc80903ee5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_LONDrouter)
  create_netns_link
  ip link set c62bc80903ee5_c netns $PID
  ip netns exec $PID ip link set dev c62bc80903ee5_c name port_ZURI
  ip netns exec $PID ip link set port_ZURI up
  tc qdisc add dev c62bc80903ee5_l root netem delay 1000 
  ovs-vsctl set interface c62bc80903ee5_l ingress_policing_rate=100000
fi
if [ "1_ZURIrouter" == $container_name ] || [ "1_LONDrouter" == $container_name ]; then
  echo "Link between 1_ZURIrouter (port_LOND) and 1_LONDrouter (port_ZURI)"
  port_id1=`ovs-vsctl get Interface d8b4f41fd1045_l ofport`
  port_id2=`ovs-vsctl get Interface c62bc80903ee5_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_PARIrouter" == $container_name ]; then
  echo "Create Link for 1_PARIrouter (port_GENE) on bridge "
  ip link add 3692691c63395_l type veth peer name 3692691c63395_c
  ovs-vsctl del-port int-1 3692691c63395_l
  ovs-vsctl add-port int-1 3692691c63395_l
  ovs-vsctl set interface 3692691c63395_l external_ids:container_id=1_PARIrouter external_ids:container_iface=port_GENE
  ip link set 3692691c63395_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_PARIrouter)
  create_netns_link
  ip link set 3692691c63395_c netns $PID
  ip netns exec $PID ip link set dev 3692691c63395_c name port_GENE
  ip netns exec $PID ip link set port_GENE up
  tc qdisc add dev 3692691c63395_l root netem delay 20 
  ovs-vsctl set interface 3692691c63395_l ingress_policing_rate=100000
fi
if [ "1_GENErouter" == $container_name ]; then
  echo "Create Link for 1_GENErouter (port_PARI) on bridge "
  ip link add cb26dd7d45a35_l type veth peer name cb26dd7d45a35_c
  ovs-vsctl del-port int-1 cb26dd7d45a35_l
  ovs-vsctl add-port int-1 cb26dd7d45a35_l
  ovs-vsctl set interface cb26dd7d45a35_l external_ids:container_id=1_GENErouter external_ids:container_iface=port_PARI
  ip link set cb26dd7d45a35_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_GENErouter)
  create_netns_link
  ip link set cb26dd7d45a35_c netns $PID
  ip netns exec $PID ip link set dev cb26dd7d45a35_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev cb26dd7d45a35_l root netem delay 20 
  ovs-vsctl set interface cb26dd7d45a35_l ingress_policing_rate=100000
fi
if [ "1_PARIrouter" == $container_name ] || [ "1_GENErouter" == $container_name ]; then
  echo "Link between 1_PARIrouter (port_GENE) and 1_GENErouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface 3692691c63395_l ofport`
  port_id2=`ovs-vsctl get Interface cb26dd7d45a35_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_PARIrouter" == $container_name ]; then
  echo "Create Link for 1_PARIrouter (port_LOND) on bridge "
  ip link add f82e2fadd1a45_l type veth peer name f82e2fadd1a45_c
  ovs-vsctl del-port int-1 f82e2fadd1a45_l
  ovs-vsctl add-port int-1 f82e2fadd1a45_l
  ovs-vsctl set interface f82e2fadd1a45_l external_ids:container_id=1_PARIrouter external_ids:container_iface=port_LOND
  ip link set f82e2fadd1a45_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_PARIrouter)
  create_netns_link
  ip link set f82e2fadd1a45_c netns $PID
  ip netns exec $PID ip link set dev f82e2fadd1a45_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev f82e2fadd1a45_l root netem delay 20 
  ovs-vsctl set interface f82e2fadd1a45_l ingress_policing_rate=100000
fi
if [ "1_LONDrouter" == $container_name ]; then
  echo "Create Link for 1_LONDrouter (port_PARI) on bridge "
  ip link add ac50c6e5f3245_l type veth peer name ac50c6e5f3245_c
  ovs-vsctl del-port int-1 ac50c6e5f3245_l
  ovs-vsctl add-port int-1 ac50c6e5f3245_l
  ovs-vsctl set interface ac50c6e5f3245_l external_ids:container_id=1_LONDrouter external_ids:container_iface=port_PARI
  ip link set ac50c6e5f3245_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_LONDrouter)
  create_netns_link
  ip link set ac50c6e5f3245_c netns $PID
  ip netns exec $PID ip link set dev ac50c6e5f3245_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev ac50c6e5f3245_l root netem delay 20 
  ovs-vsctl set interface ac50c6e5f3245_l ingress_policing_rate=100000
fi
if [ "1_PARIrouter" == $container_name ] || [ "1_LONDrouter" == $container_name ]; then
  echo "Link between 1_PARIrouter (port_LOND) and 1_LONDrouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface f82e2fadd1a45_l ofport`
  port_id2=`ovs-vsctl get Interface ac50c6e5f3245_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_PARIrouter" == $container_name ]; then
  echo "Create Link for 1_PARIrouter (port_NEWY) on bridge "
  ip link add 50df403685995_l type veth peer name 50df403685995_c
  ovs-vsctl del-port int-1 50df403685995_l
  ovs-vsctl add-port int-1 50df403685995_l
  ovs-vsctl set interface 50df403685995_l external_ids:container_id=1_PARIrouter external_ids:container_iface=port_NEWY
  ip link set 50df403685995_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_PARIrouter)
  create_netns_link
  ip link set 50df403685995_c netns $PID
  ip netns exec $PID ip link set dev 50df403685995_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev 50df403685995_l root netem delay 1000 
  ovs-vsctl set interface 50df403685995_l ingress_policing_rate=100000
fi
if [ "1_NEWYrouter" == $container_name ]; then
  echo "Create Link for 1_NEWYrouter (port_PARI) on bridge "
  ip link add 4fc4efe9fc665_l type veth peer name 4fc4efe9fc665_c
  ovs-vsctl del-port int-1 4fc4efe9fc665_l
  ovs-vsctl add-port int-1 4fc4efe9fc665_l
  ovs-vsctl set interface 4fc4efe9fc665_l external_ids:container_id=1_NEWYrouter external_ids:container_iface=port_PARI
  ip link set 4fc4efe9fc665_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_NEWYrouter)
  create_netns_link
  ip link set 4fc4efe9fc665_c netns $PID
  ip netns exec $PID ip link set dev 4fc4efe9fc665_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev 4fc4efe9fc665_l root netem delay 1000 
  ovs-vsctl set interface 4fc4efe9fc665_l ingress_policing_rate=100000
fi
if [ "1_PARIrouter" == $container_name ] || [ "1_NEWYrouter" == $container_name ]; then
  echo "Link between 1_PARIrouter (port_NEWY) and 1_NEWYrouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface 50df403685995_l ofport`
  port_id2=`ovs-vsctl get Interface 4fc4efe9fc665_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_PARIrouter" == $container_name ]; then
  echo "Create Link for 1_PARIrouter (port_MIAM) on bridge "
  ip link add ad3f31b490fa5_l type veth peer name ad3f31b490fa5_c
  ovs-vsctl del-port int-1 ad3f31b490fa5_l
  ovs-vsctl add-port int-1 ad3f31b490fa5_l
  ovs-vsctl set interface ad3f31b490fa5_l external_ids:container_id=1_PARIrouter external_ids:container_iface=port_MIAM
  ip link set ad3f31b490fa5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_PARIrouter)
  create_netns_link
  ip link set ad3f31b490fa5_c netns $PID
  ip netns exec $PID ip link set dev ad3f31b490fa5_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev ad3f31b490fa5_l root netem delay 50 
  ovs-vsctl set interface ad3f31b490fa5_l ingress_policing_rate=10000
fi
if [ "1_MIAMrouter" == $container_name ]; then
  echo "Create Link for 1_MIAMrouter (port_PARI) on bridge "
  ip link add 4f7e8d7f5ccc5_l type veth peer name 4f7e8d7f5ccc5_c
  ovs-vsctl del-port int-1 4f7e8d7f5ccc5_l
  ovs-vsctl add-port int-1 4f7e8d7f5ccc5_l
  ovs-vsctl set interface 4f7e8d7f5ccc5_l external_ids:container_id=1_MIAMrouter external_ids:container_iface=port_PARI
  ip link set 4f7e8d7f5ccc5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_MIAMrouter)
  create_netns_link
  ip link set 4f7e8d7f5ccc5_c netns $PID
  ip netns exec $PID ip link set dev 4f7e8d7f5ccc5_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev 4f7e8d7f5ccc5_l root netem delay 50 
  ovs-vsctl set interface 4f7e8d7f5ccc5_l ingress_policing_rate=10000
fi
if [ "1_PARIrouter" == $container_name ] || [ "1_MIAMrouter" == $container_name ]; then
  echo "Link between 1_PARIrouter (port_MIAM) and 1_MIAMrouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface ad3f31b490fa5_l ofport`
  port_id2=`ovs-vsctl get Interface 4f7e8d7f5ccc5_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_LONDrouter" == $container_name ]; then
  echo "Create Link for 1_LONDrouter (port_BOST) on bridge "
  ip link add cd7ebf6ece3d5_l type veth peer name cd7ebf6ece3d5_c
  ovs-vsctl del-port int-1 cd7ebf6ece3d5_l
  ovs-vsctl add-port int-1 cd7ebf6ece3d5_l
  ovs-vsctl set interface cd7ebf6ece3d5_l external_ids:container_id=1_LONDrouter external_ids:container_iface=port_BOST
  ip link set cd7ebf6ece3d5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_LONDrouter)
  create_netns_link
  ip link set cd7ebf6ece3d5_c netns $PID
  ip netns exec $PID ip link set dev cd7ebf6ece3d5_c name port_BOST
  ip netns exec $PID ip link set port_BOST up
  tc qdisc add dev cd7ebf6ece3d5_l root netem delay 10000 
  ovs-vsctl set interface cd7ebf6ece3d5_l ingress_policing_rate=10000
fi
if [ "1_BOSTrouter" == $container_name ]; then
  echo "Create Link for 1_BOSTrouter (port_LOND) on bridge "
  ip link add 119ded19b4de5_l type veth peer name 119ded19b4de5_c
  ovs-vsctl del-port int-1 119ded19b4de5_l
  ovs-vsctl add-port int-1 119ded19b4de5_l
  ovs-vsctl set interface 119ded19b4de5_l external_ids:container_id=1_BOSTrouter external_ids:container_iface=port_LOND
  ip link set 119ded19b4de5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_BOSTrouter)
  create_netns_link
  ip link set 119ded19b4de5_c netns $PID
  ip netns exec $PID ip link set dev 119ded19b4de5_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev 119ded19b4de5_l root netem delay 10000 
  ovs-vsctl set interface 119ded19b4de5_l ingress_policing_rate=10000
fi
if [ "1_LONDrouter" == $container_name ] || [ "1_BOSTrouter" == $container_name ]; then
  echo "Link between 1_LONDrouter (port_BOST) and 1_BOSTrouter (port_LOND)"
  port_id1=`ovs-vsctl get Interface cd7ebf6ece3d5_l ofport`
  port_id2=`ovs-vsctl get Interface 119ded19b4de5_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_LONDrouter" == $container_name ]; then
  echo "Create Link for 1_LONDrouter (port_NEWY) on bridge "
  ip link add 3891ca77504b5_l type veth peer name 3891ca77504b5_c
  ovs-vsctl del-port int-1 3891ca77504b5_l
  ovs-vsctl add-port int-1 3891ca77504b5_l
  ovs-vsctl set interface 3891ca77504b5_l external_ids:container_id=1_LONDrouter external_ids:container_iface=port_NEWY
  ip link set 3891ca77504b5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_LONDrouter)
  create_netns_link
  ip link set 3891ca77504b5_c netns $PID
  ip netns exec $PID ip link set dev 3891ca77504b5_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev 3891ca77504b5_l root netem delay 100 
  ovs-vsctl set interface 3891ca77504b5_l ingress_policing_rate=100000
fi
if [ "1_NEWYrouter" == $container_name ]; then
  echo "Create Link for 1_NEWYrouter (port_LOND) on bridge "
  ip link add db797f923d8c5_l type veth peer name db797f923d8c5_c
  ovs-vsctl del-port int-1 db797f923d8c5_l
  ovs-vsctl add-port int-1 db797f923d8c5_l
  ovs-vsctl set interface db797f923d8c5_l external_ids:container_id=1_NEWYrouter external_ids:container_iface=port_LOND
  ip link set db797f923d8c5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_NEWYrouter)
  create_netns_link
  ip link set db797f923d8c5_c netns $PID
  ip netns exec $PID ip link set dev db797f923d8c5_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev db797f923d8c5_l root netem delay 100 
  ovs-vsctl set interface db797f923d8c5_l ingress_policing_rate=100000
fi
if [ "1_LONDrouter" == $container_name ] || [ "1_NEWYrouter" == $container_name ]; then
  echo "Link between 1_LONDrouter (port_NEWY) and 1_NEWYrouter (port_LOND)"
  port_id1=`ovs-vsctl get Interface 3891ca77504b5_l ofport`
  port_id2=`ovs-vsctl get Interface db797f923d8c5_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_GENErouter" == $container_name ]; then
  echo "Create Link for 1_GENErouter (port_MIAM) on bridge "
  ip link add 0ed10f73231e5_l type veth peer name 0ed10f73231e5_c
  ovs-vsctl del-port int-1 0ed10f73231e5_l
  ovs-vsctl add-port int-1 0ed10f73231e5_l
  ovs-vsctl set interface 0ed10f73231e5_l external_ids:container_id=1_GENErouter external_ids:container_iface=port_MIAM
  ip link set 0ed10f73231e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_GENErouter)
  create_netns_link
  ip link set 0ed10f73231e5_c netns $PID
  ip netns exec $PID ip link set dev 0ed10f73231e5_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev 0ed10f73231e5_l root netem delay 100 
  ovs-vsctl set interface 0ed10f73231e5_l ingress_policing_rate=1000
fi
if [ "1_MIAMrouter" == $container_name ]; then
  echo "Create Link for 1_MIAMrouter (port_GENE) on bridge "
  ip link add fab839ff790f5_l type veth peer name fab839ff790f5_c
  ovs-vsctl del-port int-1 fab839ff790f5_l
  ovs-vsctl add-port int-1 fab839ff790f5_l
  ovs-vsctl set interface fab839ff790f5_l external_ids:container_id=1_MIAMrouter external_ids:container_iface=port_GENE
  ip link set fab839ff790f5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_MIAMrouter)
  create_netns_link
  ip link set fab839ff790f5_c netns $PID
  ip netns exec $PID ip link set dev fab839ff790f5_c name port_GENE
  ip netns exec $PID ip link set port_GENE up
  tc qdisc add dev fab839ff790f5_l root netem delay 100 
  ovs-vsctl set interface fab839ff790f5_l ingress_policing_rate=1000
fi
if [ "1_GENErouter" == $container_name ] || [ "1_MIAMrouter" == $container_name ]; then
  echo "Link between 1_GENErouter (port_MIAM) and 1_MIAMrouter (port_GENE)"
  port_id1=`ovs-vsctl get Interface 0ed10f73231e5_l ofport`
  port_id2=`ovs-vsctl get Interface fab839ff790f5_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_NEWYrouter" == $container_name ]; then
  echo "Create Link for 1_NEWYrouter (port_BOST) on bridge "
  ip link add 8a2ab342b0485_l type veth peer name 8a2ab342b0485_c
  ovs-vsctl del-port int-1 8a2ab342b0485_l
  ovs-vsctl add-port int-1 8a2ab342b0485_l
  ovs-vsctl set interface 8a2ab342b0485_l external_ids:container_id=1_NEWYrouter external_ids:container_iface=port_BOST
  ip link set 8a2ab342b0485_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_NEWYrouter)
  create_netns_link
  ip link set 8a2ab342b0485_c netns $PID
  ip netns exec $PID ip link set dev 8a2ab342b0485_c name port_BOST
  ip netns exec $PID ip link set port_BOST up
  tc qdisc add dev 8a2ab342b0485_l root netem delay 10 
  ovs-vsctl set interface 8a2ab342b0485_l ingress_policing_rate=100000
fi
if [ "1_BOSTrouter" == $container_name ]; then
  echo "Create Link for 1_BOSTrouter (port_NEWY) on bridge "
  ip link add c70b35236ac55_l type veth peer name c70b35236ac55_c
  ovs-vsctl del-port int-1 c70b35236ac55_l
  ovs-vsctl add-port int-1 c70b35236ac55_l
  ovs-vsctl set interface c70b35236ac55_l external_ids:container_id=1_BOSTrouter external_ids:container_iface=port_NEWY
  ip link set c70b35236ac55_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_BOSTrouter)
  create_netns_link
  ip link set c70b35236ac55_c netns $PID
  ip netns exec $PID ip link set dev c70b35236ac55_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev c70b35236ac55_l root netem delay 10 
  ovs-vsctl set interface c70b35236ac55_l ingress_policing_rate=100000
fi
if [ "1_NEWYrouter" == $container_name ] || [ "1_BOSTrouter" == $container_name ]; then
  echo "Link between 1_NEWYrouter (port_BOST) and 1_BOSTrouter (port_NEWY)"
  port_id1=`ovs-vsctl get Interface 8a2ab342b0485_l ofport`
  port_id2=`ovs-vsctl get Interface c70b35236ac55_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_NEWYrouter" == $container_name ]; then
  echo "Create Link for 1_NEWYrouter (port_ATLA) on bridge "
  ip link add 3a81517af39d5_l type veth peer name 3a81517af39d5_c
  ovs-vsctl del-port int-1 3a81517af39d5_l
  ovs-vsctl add-port int-1 3a81517af39d5_l
  ovs-vsctl set interface 3a81517af39d5_l external_ids:container_id=1_NEWYrouter external_ids:container_iface=port_ATLA
  ip link set 3a81517af39d5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_NEWYrouter)
  create_netns_link
  ip link set 3a81517af39d5_c netns $PID
  ip netns exec $PID ip link set dev 3a81517af39d5_c name port_ATLA
  ip netns exec $PID ip link set port_ATLA up
  tc qdisc add dev 3a81517af39d5_l root netem delay 100 
  ovs-vsctl set interface 3a81517af39d5_l ingress_policing_rate=100000
fi
if [ "1_ATLArouter" == $container_name ]; then
  echo "Create Link for 1_ATLArouter (port_NEWY) on bridge "
  ip link add f0dfc83646755_l type veth peer name f0dfc83646755_c
  ovs-vsctl del-port int-1 f0dfc83646755_l
  ovs-vsctl add-port int-1 f0dfc83646755_l
  ovs-vsctl set interface f0dfc83646755_l external_ids:container_id=1_ATLArouter external_ids:container_iface=port_NEWY
  ip link set f0dfc83646755_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ATLArouter)
  create_netns_link
  ip link set f0dfc83646755_c netns $PID
  ip netns exec $PID ip link set dev f0dfc83646755_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev f0dfc83646755_l root netem delay 100 
  ovs-vsctl set interface f0dfc83646755_l ingress_policing_rate=100000
fi
if [ "1_NEWYrouter" == $container_name ] || [ "1_ATLArouter" == $container_name ]; then
  echo "Link between 1_NEWYrouter (port_ATLA) and 1_ATLArouter (port_NEWY)"
  port_id1=`ovs-vsctl get Interface 3a81517af39d5_l ofport`
  port_id2=`ovs-vsctl get Interface f0dfc83646755_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_NEWYrouter" == $container_name ]; then
  echo "Create Link for 1_NEWYrouter (port_MIAM) on bridge "
  ip link add 89ac4c17b95c5_l type veth peer name 89ac4c17b95c5_c
  ovs-vsctl del-port int-1 89ac4c17b95c5_l
  ovs-vsctl add-port int-1 89ac4c17b95c5_l
  ovs-vsctl set interface 89ac4c17b95c5_l external_ids:container_id=1_NEWYrouter external_ids:container_iface=port_MIAM
  ip link set 89ac4c17b95c5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_NEWYrouter)
  create_netns_link
  ip link set 89ac4c17b95c5_c netns $PID
  ip netns exec $PID ip link set dev 89ac4c17b95c5_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev 89ac4c17b95c5_l root netem delay 10 
  ovs-vsctl set interface 89ac4c17b95c5_l ingress_policing_rate=100000
fi
if [ "1_MIAMrouter" == $container_name ]; then
  echo "Create Link for 1_MIAMrouter (port_NEWY) on bridge "
  ip link add 695b257b5db65_l type veth peer name 695b257b5db65_c
  ovs-vsctl del-port int-1 695b257b5db65_l
  ovs-vsctl add-port int-1 695b257b5db65_l
  ovs-vsctl set interface 695b257b5db65_l external_ids:container_id=1_MIAMrouter external_ids:container_iface=port_NEWY
  ip link set 695b257b5db65_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_MIAMrouter)
  create_netns_link
  ip link set 695b257b5db65_c netns $PID
  ip netns exec $PID ip link set dev 695b257b5db65_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev 695b257b5db65_l root netem delay 10 
  ovs-vsctl set interface 695b257b5db65_l ingress_policing_rate=100000
fi
if [ "1_NEWYrouter" == $container_name ] || [ "1_MIAMrouter" == $container_name ]; then
  echo "Link between 1_NEWYrouter (port_MIAM) and 1_MIAMrouter (port_NEWY)"
  port_id1=`ovs-vsctl get Interface 89ac4c17b95c5_l ofport`
  port_id2=`ovs-vsctl get Interface 695b257b5db65_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_ATLArouter" == $container_name ]; then
  echo "Create Link for 1_ATLArouter (port_MIAM) on bridge "
  ip link add 1f14aa3219f45_l type veth peer name 1f14aa3219f45_c
  ovs-vsctl del-port int-1 1f14aa3219f45_l
  ovs-vsctl add-port int-1 1f14aa3219f45_l
  ovs-vsctl set interface 1f14aa3219f45_l external_ids:container_id=1_ATLArouter external_ids:container_iface=port_MIAM
  ip link set 1f14aa3219f45_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ATLArouter)
  create_netns_link
  ip link set 1f14aa3219f45_c netns $PID
  ip netns exec $PID ip link set dev 1f14aa3219f45_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev 1f14aa3219f45_l root netem delay 100 
  ovs-vsctl set interface 1f14aa3219f45_l ingress_policing_rate=100000
fi
if [ "1_MIAMrouter" == $container_name ]; then
  echo "Create Link for 1_MIAMrouter (port_ATLA) on bridge "
  ip link add 47d7221f8c905_l type veth peer name 47d7221f8c905_c
  ovs-vsctl del-port int-1 47d7221f8c905_l
  ovs-vsctl add-port int-1 47d7221f8c905_l
  ovs-vsctl set interface 47d7221f8c905_l external_ids:container_id=1_MIAMrouter external_ids:container_iface=port_ATLA
  ip link set 47d7221f8c905_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_MIAMrouter)
  create_netns_link
  ip link set 47d7221f8c905_c netns $PID
  ip netns exec $PID ip link set dev 47d7221f8c905_c name port_ATLA
  ip netns exec $PID ip link set port_ATLA up
  tc qdisc add dev 47d7221f8c905_l root netem delay 100 
  ovs-vsctl set interface 47d7221f8c905_l ingress_policing_rate=100000
fi
if [ "1_ATLArouter" == $container_name ] || [ "1_MIAMrouter" == $container_name ]; then
  echo "Link between 1_ATLArouter (port_MIAM) and 1_MIAMrouter (port_ATLA)"
  port_id1=`ovs-vsctl get Interface 1f14aa3219f45_l ofport`
  port_id2=`ovs-vsctl get Interface 47d7221f8c905_l ofport`
  ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_ZURIrouter" == $container_name ]; then
  echo "Create Link for 2_ZURIrouter (port_PARI) on bridge "
  ip link add 346917b814d35_l type veth peer name 346917b814d35_c
  ovs-vsctl del-port int-2 346917b814d35_l
  ovs-vsctl add-port int-2 346917b814d35_l
  ovs-vsctl set interface 346917b814d35_l external_ids:container_id=2_ZURIrouter external_ids:container_iface=port_PARI
  ip link set 346917b814d35_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ZURIrouter)
  create_netns_link
  ip link set 346917b814d35_c netns $PID
  ip netns exec $PID ip link set dev 346917b814d35_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev 346917b814d35_l root netem delay 100 
  ovs-vsctl set interface 346917b814d35_l ingress_policing_rate=100000
fi
if [ "2_PARIrouter" == $container_name ]; then
  echo "Create Link for 2_PARIrouter (port_ZURI) on bridge "
  ip link add 95519b49b05c5_l type veth peer name 95519b49b05c5_c
  ovs-vsctl del-port int-2 95519b49b05c5_l
  ovs-vsctl add-port int-2 95519b49b05c5_l
  ovs-vsctl set interface 95519b49b05c5_l external_ids:container_id=2_PARIrouter external_ids:container_iface=port_ZURI
  ip link set 95519b49b05c5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_PARIrouter)
  create_netns_link
  ip link set 95519b49b05c5_c netns $PID
  ip netns exec $PID ip link set dev 95519b49b05c5_c name port_ZURI
  ip netns exec $PID ip link set port_ZURI up
  tc qdisc add dev 95519b49b05c5_l root netem delay 100 
  ovs-vsctl set interface 95519b49b05c5_l ingress_policing_rate=100000
fi
if [ "2_ZURIrouter" == $container_name ] || [ "2_PARIrouter" == $container_name ]; then
  echo "Link between 2_ZURIrouter (port_PARI) and 2_PARIrouter (port_ZURI)"
  port_id1=`ovs-vsctl get Interface 346917b814d35_l ofport`
  port_id2=`ovs-vsctl get Interface 95519b49b05c5_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_ZURIrouter" == $container_name ]; then
  echo "Create Link for 2_ZURIrouter (port_LOND) on bridge "
  ip link add 7c453dae95265_l type veth peer name 7c453dae95265_c
  ovs-vsctl del-port int-2 7c453dae95265_l
  ovs-vsctl add-port int-2 7c453dae95265_l
  ovs-vsctl set interface 7c453dae95265_l external_ids:container_id=2_ZURIrouter external_ids:container_iface=port_LOND
  ip link set 7c453dae95265_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ZURIrouter)
  create_netns_link
  ip link set 7c453dae95265_c netns $PID
  ip netns exec $PID ip link set dev 7c453dae95265_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev 7c453dae95265_l root netem delay 1000 
  ovs-vsctl set interface 7c453dae95265_l ingress_policing_rate=100000
fi
if [ "2_LONDrouter" == $container_name ]; then
  echo "Create Link for 2_LONDrouter (port_ZURI) on bridge "
  ip link add 48c3c0893c095_l type veth peer name 48c3c0893c095_c
  ovs-vsctl del-port int-2 48c3c0893c095_l
  ovs-vsctl add-port int-2 48c3c0893c095_l
  ovs-vsctl set interface 48c3c0893c095_l external_ids:container_id=2_LONDrouter external_ids:container_iface=port_ZURI
  ip link set 48c3c0893c095_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_LONDrouter)
  create_netns_link
  ip link set 48c3c0893c095_c netns $PID
  ip netns exec $PID ip link set dev 48c3c0893c095_c name port_ZURI
  ip netns exec $PID ip link set port_ZURI up
  tc qdisc add dev 48c3c0893c095_l root netem delay 1000 
  ovs-vsctl set interface 48c3c0893c095_l ingress_policing_rate=100000
fi
if [ "2_ZURIrouter" == $container_name ] || [ "2_LONDrouter" == $container_name ]; then
  echo "Link between 2_ZURIrouter (port_LOND) and 2_LONDrouter (port_ZURI)"
  port_id1=`ovs-vsctl get Interface 7c453dae95265_l ofport`
  port_id2=`ovs-vsctl get Interface 48c3c0893c095_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_PARIrouter" == $container_name ]; then
  echo "Create Link for 2_PARIrouter (port_GENE) on bridge "
  ip link add b9ca6db45e665_l type veth peer name b9ca6db45e665_c
  ovs-vsctl del-port int-2 b9ca6db45e665_l
  ovs-vsctl add-port int-2 b9ca6db45e665_l
  ovs-vsctl set interface b9ca6db45e665_l external_ids:container_id=2_PARIrouter external_ids:container_iface=port_GENE
  ip link set b9ca6db45e665_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_PARIrouter)
  create_netns_link
  ip link set b9ca6db45e665_c netns $PID
  ip netns exec $PID ip link set dev b9ca6db45e665_c name port_GENE
  ip netns exec $PID ip link set port_GENE up
  tc qdisc add dev b9ca6db45e665_l root netem delay 20 
  ovs-vsctl set interface b9ca6db45e665_l ingress_policing_rate=100000
fi
if [ "2_GENErouter" == $container_name ]; then
  echo "Create Link for 2_GENErouter (port_PARI) on bridge "
  ip link add c762cdaef08b5_l type veth peer name c762cdaef08b5_c
  ovs-vsctl del-port int-2 c762cdaef08b5_l
  ovs-vsctl add-port int-2 c762cdaef08b5_l
  ovs-vsctl set interface c762cdaef08b5_l external_ids:container_id=2_GENErouter external_ids:container_iface=port_PARI
  ip link set c762cdaef08b5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_GENErouter)
  create_netns_link
  ip link set c762cdaef08b5_c netns $PID
  ip netns exec $PID ip link set dev c762cdaef08b5_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev c762cdaef08b5_l root netem delay 20 
  ovs-vsctl set interface c762cdaef08b5_l ingress_policing_rate=100000
fi
if [ "2_PARIrouter" == $container_name ] || [ "2_GENErouter" == $container_name ]; then
  echo "Link between 2_PARIrouter (port_GENE) and 2_GENErouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface b9ca6db45e665_l ofport`
  port_id2=`ovs-vsctl get Interface c762cdaef08b5_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_PARIrouter" == $container_name ]; then
  echo "Create Link for 2_PARIrouter (port_LOND) on bridge "
  ip link add 1c96a4bfc8705_l type veth peer name 1c96a4bfc8705_c
  ovs-vsctl del-port int-2 1c96a4bfc8705_l
  ovs-vsctl add-port int-2 1c96a4bfc8705_l
  ovs-vsctl set interface 1c96a4bfc8705_l external_ids:container_id=2_PARIrouter external_ids:container_iface=port_LOND
  ip link set 1c96a4bfc8705_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_PARIrouter)
  create_netns_link
  ip link set 1c96a4bfc8705_c netns $PID
  ip netns exec $PID ip link set dev 1c96a4bfc8705_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev 1c96a4bfc8705_l root netem delay 20 
  ovs-vsctl set interface 1c96a4bfc8705_l ingress_policing_rate=100000
fi
if [ "2_LONDrouter" == $container_name ]; then
  echo "Create Link for 2_LONDrouter (port_PARI) on bridge "
  ip link add 04b6d15310a35_l type veth peer name 04b6d15310a35_c
  ovs-vsctl del-port int-2 04b6d15310a35_l
  ovs-vsctl add-port int-2 04b6d15310a35_l
  ovs-vsctl set interface 04b6d15310a35_l external_ids:container_id=2_LONDrouter external_ids:container_iface=port_PARI
  ip link set 04b6d15310a35_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_LONDrouter)
  create_netns_link
  ip link set 04b6d15310a35_c netns $PID
  ip netns exec $PID ip link set dev 04b6d15310a35_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev 04b6d15310a35_l root netem delay 20 
  ovs-vsctl set interface 04b6d15310a35_l ingress_policing_rate=100000
fi
if [ "2_PARIrouter" == $container_name ] || [ "2_LONDrouter" == $container_name ]; then
  echo "Link between 2_PARIrouter (port_LOND) and 2_LONDrouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface 1c96a4bfc8705_l ofport`
  port_id2=`ovs-vsctl get Interface 04b6d15310a35_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_PARIrouter" == $container_name ]; then
  echo "Create Link for 2_PARIrouter (port_NEWY) on bridge "
  ip link add 12a0559b28be5_l type veth peer name 12a0559b28be5_c
  ovs-vsctl del-port int-2 12a0559b28be5_l
  ovs-vsctl add-port int-2 12a0559b28be5_l
  ovs-vsctl set interface 12a0559b28be5_l external_ids:container_id=2_PARIrouter external_ids:container_iface=port_NEWY
  ip link set 12a0559b28be5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_PARIrouter)
  create_netns_link
  ip link set 12a0559b28be5_c netns $PID
  ip netns exec $PID ip link set dev 12a0559b28be5_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev 12a0559b28be5_l root netem delay 1000 
  ovs-vsctl set interface 12a0559b28be5_l ingress_policing_rate=10000
fi
if [ "2_NEWYrouter" == $container_name ]; then
  echo "Create Link for 2_NEWYrouter (port_PARI) on bridge "
  ip link add 7daed37f1a945_l type veth peer name 7daed37f1a945_c
  ovs-vsctl del-port int-2 7daed37f1a945_l
  ovs-vsctl add-port int-2 7daed37f1a945_l
  ovs-vsctl set interface 7daed37f1a945_l external_ids:container_id=2_NEWYrouter external_ids:container_iface=port_PARI
  ip link set 7daed37f1a945_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_NEWYrouter)
  create_netns_link
  ip link set 7daed37f1a945_c netns $PID
  ip netns exec $PID ip link set dev 7daed37f1a945_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev 7daed37f1a945_l root netem delay 1000 
  ovs-vsctl set interface 7daed37f1a945_l ingress_policing_rate=10000
fi
if [ "2_PARIrouter" == $container_name ] || [ "2_NEWYrouter" == $container_name ]; then
  echo "Link between 2_PARIrouter (port_NEWY) and 2_NEWYrouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface 12a0559b28be5_l ofport`
  port_id2=`ovs-vsctl get Interface 7daed37f1a945_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_PARIrouter" == $container_name ]; then
  echo "Create Link for 2_PARIrouter (port_MIAM) on bridge "
  ip link add 60b09a5226ff5_l type veth peer name 60b09a5226ff5_c
  ovs-vsctl del-port int-2 60b09a5226ff5_l
  ovs-vsctl add-port int-2 60b09a5226ff5_l
  ovs-vsctl set interface 60b09a5226ff5_l external_ids:container_id=2_PARIrouter external_ids:container_iface=port_MIAM
  ip link set 60b09a5226ff5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_PARIrouter)
  create_netns_link
  ip link set 60b09a5226ff5_c netns $PID
  ip netns exec $PID ip link set dev 60b09a5226ff5_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev 60b09a5226ff5_l root netem delay 50 
  ovs-vsctl set interface 60b09a5226ff5_l ingress_policing_rate=100000
fi
if [ "2_MIAMrouter" == $container_name ]; then
  echo "Create Link for 2_MIAMrouter (port_PARI) on bridge "
  ip link add 807c0a3dae345_l type veth peer name 807c0a3dae345_c
  ovs-vsctl del-port int-2 807c0a3dae345_l
  ovs-vsctl add-port int-2 807c0a3dae345_l
  ovs-vsctl set interface 807c0a3dae345_l external_ids:container_id=2_MIAMrouter external_ids:container_iface=port_PARI
  ip link set 807c0a3dae345_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_MIAMrouter)
  create_netns_link
  ip link set 807c0a3dae345_c netns $PID
  ip netns exec $PID ip link set dev 807c0a3dae345_c name port_PARI
  ip netns exec $PID ip link set port_PARI up
  tc qdisc add dev 807c0a3dae345_l root netem delay 50 
  ovs-vsctl set interface 807c0a3dae345_l ingress_policing_rate=100000
fi
if [ "2_PARIrouter" == $container_name ] || [ "2_MIAMrouter" == $container_name ]; then
  echo "Link between 2_PARIrouter (port_MIAM) and 2_MIAMrouter (port_PARI)"
  port_id1=`ovs-vsctl get Interface 60b09a5226ff5_l ofport`
  port_id2=`ovs-vsctl get Interface 807c0a3dae345_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_LONDrouter" == $container_name ]; then
  echo "Create Link for 2_LONDrouter (port_BOST) on bridge "
  ip link add a0660d49486e5_l type veth peer name a0660d49486e5_c
  ovs-vsctl del-port int-2 a0660d49486e5_l
  ovs-vsctl add-port int-2 a0660d49486e5_l
  ovs-vsctl set interface a0660d49486e5_l external_ids:container_id=2_LONDrouter external_ids:container_iface=port_BOST
  ip link set a0660d49486e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_LONDrouter)
  create_netns_link
  ip link set a0660d49486e5_c netns $PID
  ip netns exec $PID ip link set dev a0660d49486e5_c name port_BOST
  ip netns exec $PID ip link set port_BOST up
  tc qdisc add dev a0660d49486e5_l root netem delay 10000 
  ovs-vsctl set interface a0660d49486e5_l ingress_policing_rate=1000
fi
if [ "2_BOSTrouter" == $container_name ]; then
  echo "Create Link for 2_BOSTrouter (port_LOND) on bridge "
  ip link add 8d2b92ab3fcf5_l type veth peer name 8d2b92ab3fcf5_c
  ovs-vsctl del-port int-2 8d2b92ab3fcf5_l
  ovs-vsctl add-port int-2 8d2b92ab3fcf5_l
  ovs-vsctl set interface 8d2b92ab3fcf5_l external_ids:container_id=2_BOSTrouter external_ids:container_iface=port_LOND
  ip link set 8d2b92ab3fcf5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_BOSTrouter)
  create_netns_link
  ip link set 8d2b92ab3fcf5_c netns $PID
  ip netns exec $PID ip link set dev 8d2b92ab3fcf5_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev 8d2b92ab3fcf5_l root netem delay 10000 
  ovs-vsctl set interface 8d2b92ab3fcf5_l ingress_policing_rate=1000
fi
if [ "2_LONDrouter" == $container_name ] || [ "2_BOSTrouter" == $container_name ]; then
  echo "Link between 2_LONDrouter (port_BOST) and 2_BOSTrouter (port_LOND)"
  port_id1=`ovs-vsctl get Interface a0660d49486e5_l ofport`
  port_id2=`ovs-vsctl get Interface 8d2b92ab3fcf5_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_LONDrouter" == $container_name ]; then
  echo "Create Link for 2_LONDrouter (port_NEWY) on bridge "
  ip link add 81159ed71d5d5_l type veth peer name 81159ed71d5d5_c
  ovs-vsctl del-port int-2 81159ed71d5d5_l
  ovs-vsctl add-port int-2 81159ed71d5d5_l
  ovs-vsctl set interface 81159ed71d5d5_l external_ids:container_id=2_LONDrouter external_ids:container_iface=port_NEWY
  ip link set 81159ed71d5d5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_LONDrouter)
  create_netns_link
  ip link set 81159ed71d5d5_c netns $PID
  ip netns exec $PID ip link set dev 81159ed71d5d5_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev 81159ed71d5d5_l root netem delay 100 
  ovs-vsctl set interface 81159ed71d5d5_l ingress_policing_rate=100000
fi
if [ "2_NEWYrouter" == $container_name ]; then
  echo "Create Link for 2_NEWYrouter (port_LOND) on bridge "
  ip link add da0e18277c255_l type veth peer name da0e18277c255_c
  ovs-vsctl del-port int-2 da0e18277c255_l
  ovs-vsctl add-port int-2 da0e18277c255_l
  ovs-vsctl set interface da0e18277c255_l external_ids:container_id=2_NEWYrouter external_ids:container_iface=port_LOND
  ip link set da0e18277c255_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_NEWYrouter)
  create_netns_link
  ip link set da0e18277c255_c netns $PID
  ip netns exec $PID ip link set dev da0e18277c255_c name port_LOND
  ip netns exec $PID ip link set port_LOND up
  tc qdisc add dev da0e18277c255_l root netem delay 100 
  ovs-vsctl set interface da0e18277c255_l ingress_policing_rate=100000
fi
if [ "2_LONDrouter" == $container_name ] || [ "2_NEWYrouter" == $container_name ]; then
  echo "Link between 2_LONDrouter (port_NEWY) and 2_NEWYrouter (port_LOND)"
  port_id1=`ovs-vsctl get Interface 81159ed71d5d5_l ofport`
  port_id2=`ovs-vsctl get Interface da0e18277c255_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_GENErouter" == $container_name ]; then
  echo "Create Link for 2_GENErouter (port_MIAM) on bridge "
  ip link add 929c7decf89e5_l type veth peer name 929c7decf89e5_c
  ovs-vsctl del-port int-2 929c7decf89e5_l
  ovs-vsctl add-port int-2 929c7decf89e5_l
  ovs-vsctl set interface 929c7decf89e5_l external_ids:container_id=2_GENErouter external_ids:container_iface=port_MIAM
  ip link set 929c7decf89e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_GENErouter)
  create_netns_link
  ip link set 929c7decf89e5_c netns $PID
  ip netns exec $PID ip link set dev 929c7decf89e5_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev 929c7decf89e5_l root netem delay 100 
  ovs-vsctl set interface 929c7decf89e5_l ingress_policing_rate=10000
fi
if [ "2_MIAMrouter" == $container_name ]; then
  echo "Create Link for 2_MIAMrouter (port_GENE) on bridge "
  ip link add 9d90b60b92885_l type veth peer name 9d90b60b92885_c
  ovs-vsctl del-port int-2 9d90b60b92885_l
  ovs-vsctl add-port int-2 9d90b60b92885_l
  ovs-vsctl set interface 9d90b60b92885_l external_ids:container_id=2_MIAMrouter external_ids:container_iface=port_GENE
  ip link set 9d90b60b92885_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_MIAMrouter)
  create_netns_link
  ip link set 9d90b60b92885_c netns $PID
  ip netns exec $PID ip link set dev 9d90b60b92885_c name port_GENE
  ip netns exec $PID ip link set port_GENE up
  tc qdisc add dev 9d90b60b92885_l root netem delay 100 
  ovs-vsctl set interface 9d90b60b92885_l ingress_policing_rate=10000
fi
if [ "2_GENErouter" == $container_name ] || [ "2_MIAMrouter" == $container_name ]; then
  echo "Link between 2_GENErouter (port_MIAM) and 2_MIAMrouter (port_GENE)"
  port_id1=`ovs-vsctl get Interface 929c7decf89e5_l ofport`
  port_id2=`ovs-vsctl get Interface 9d90b60b92885_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_NEWYrouter" == $container_name ]; then
  echo "Create Link for 2_NEWYrouter (port_BOST) on bridge "
  ip link add cd4091f4e2f05_l type veth peer name cd4091f4e2f05_c
  ovs-vsctl del-port int-2 cd4091f4e2f05_l
  ovs-vsctl add-port int-2 cd4091f4e2f05_l
  ovs-vsctl set interface cd4091f4e2f05_l external_ids:container_id=2_NEWYrouter external_ids:container_iface=port_BOST
  ip link set cd4091f4e2f05_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_NEWYrouter)
  create_netns_link
  ip link set cd4091f4e2f05_c netns $PID
  ip netns exec $PID ip link set dev cd4091f4e2f05_c name port_BOST
  ip netns exec $PID ip link set port_BOST up
  tc qdisc add dev cd4091f4e2f05_l root netem delay 10 
  ovs-vsctl set interface cd4091f4e2f05_l ingress_policing_rate=100000
fi
if [ "2_BOSTrouter" == $container_name ]; then
  echo "Create Link for 2_BOSTrouter (port_NEWY) on bridge "
  ip link add 0a89087aa5995_l type veth peer name 0a89087aa5995_c
  ovs-vsctl del-port int-2 0a89087aa5995_l
  ovs-vsctl add-port int-2 0a89087aa5995_l
  ovs-vsctl set interface 0a89087aa5995_l external_ids:container_id=2_BOSTrouter external_ids:container_iface=port_NEWY
  ip link set 0a89087aa5995_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_BOSTrouter)
  create_netns_link
  ip link set 0a89087aa5995_c netns $PID
  ip netns exec $PID ip link set dev 0a89087aa5995_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev 0a89087aa5995_l root netem delay 10 
  ovs-vsctl set interface 0a89087aa5995_l ingress_policing_rate=100000
fi
if [ "2_NEWYrouter" == $container_name ] || [ "2_BOSTrouter" == $container_name ]; then
  echo "Link between 2_NEWYrouter (port_BOST) and 2_BOSTrouter (port_NEWY)"
  port_id1=`ovs-vsctl get Interface cd4091f4e2f05_l ofport`
  port_id2=`ovs-vsctl get Interface 0a89087aa5995_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_NEWYrouter" == $container_name ]; then
  echo "Create Link for 2_NEWYrouter (port_ATLA) on bridge "
  ip link add 6cfe762b704b5_l type veth peer name 6cfe762b704b5_c
  ovs-vsctl del-port int-2 6cfe762b704b5_l
  ovs-vsctl add-port int-2 6cfe762b704b5_l
  ovs-vsctl set interface 6cfe762b704b5_l external_ids:container_id=2_NEWYrouter external_ids:container_iface=port_ATLA
  ip link set 6cfe762b704b5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_NEWYrouter)
  create_netns_link
  ip link set 6cfe762b704b5_c netns $PID
  ip netns exec $PID ip link set dev 6cfe762b704b5_c name port_ATLA
  ip netns exec $PID ip link set port_ATLA up
  tc qdisc add dev 6cfe762b704b5_l root netem delay 100 
  ovs-vsctl set interface 6cfe762b704b5_l ingress_policing_rate=100000
fi
if [ "2_ATLArouter" == $container_name ]; then
  echo "Create Link for 2_ATLArouter (port_NEWY) on bridge "
  ip link add e060572a5a855_l type veth peer name e060572a5a855_c
  ovs-vsctl del-port int-2 e060572a5a855_l
  ovs-vsctl add-port int-2 e060572a5a855_l
  ovs-vsctl set interface e060572a5a855_l external_ids:container_id=2_ATLArouter external_ids:container_iface=port_NEWY
  ip link set e060572a5a855_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ATLArouter)
  create_netns_link
  ip link set e060572a5a855_c netns $PID
  ip netns exec $PID ip link set dev e060572a5a855_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev e060572a5a855_l root netem delay 100 
  ovs-vsctl set interface e060572a5a855_l ingress_policing_rate=100000
fi
if [ "2_NEWYrouter" == $container_name ] || [ "2_ATLArouter" == $container_name ]; then
  echo "Link between 2_NEWYrouter (port_ATLA) and 2_ATLArouter (port_NEWY)"
  port_id1=`ovs-vsctl get Interface 6cfe762b704b5_l ofport`
  port_id2=`ovs-vsctl get Interface e060572a5a855_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_NEWYrouter" == $container_name ]; then
  echo "Create Link for 2_NEWYrouter (port_MIAM) on bridge "
  ip link add 28d2b385a7845_l type veth peer name 28d2b385a7845_c
  ovs-vsctl del-port int-2 28d2b385a7845_l
  ovs-vsctl add-port int-2 28d2b385a7845_l
  ovs-vsctl set interface 28d2b385a7845_l external_ids:container_id=2_NEWYrouter external_ids:container_iface=port_MIAM
  ip link set 28d2b385a7845_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_NEWYrouter)
  create_netns_link
  ip link set 28d2b385a7845_c netns $PID
  ip netns exec $PID ip link set dev 28d2b385a7845_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev 28d2b385a7845_l root netem delay 10 
  ovs-vsctl set interface 28d2b385a7845_l ingress_policing_rate=100000
fi
if [ "2_MIAMrouter" == $container_name ]; then
  echo "Create Link for 2_MIAMrouter (port_NEWY) on bridge "
  ip link add be4369d48e7e5_l type veth peer name be4369d48e7e5_c
  ovs-vsctl del-port int-2 be4369d48e7e5_l
  ovs-vsctl add-port int-2 be4369d48e7e5_l
  ovs-vsctl set interface be4369d48e7e5_l external_ids:container_id=2_MIAMrouter external_ids:container_iface=port_NEWY
  ip link set be4369d48e7e5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_MIAMrouter)
  create_netns_link
  ip link set be4369d48e7e5_c netns $PID
  ip netns exec $PID ip link set dev be4369d48e7e5_c name port_NEWY
  ip netns exec $PID ip link set port_NEWY up
  tc qdisc add dev be4369d48e7e5_l root netem delay 10 
  ovs-vsctl set interface be4369d48e7e5_l ingress_policing_rate=100000
fi
if [ "2_NEWYrouter" == $container_name ] || [ "2_MIAMrouter" == $container_name ]; then
  echo "Link between 2_NEWYrouter (port_MIAM) and 2_MIAMrouter (port_NEWY)"
  port_id1=`ovs-vsctl get Interface 28d2b385a7845_l ofport`
  port_id2=`ovs-vsctl get Interface be4369d48e7e5_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "2_ATLArouter" == $container_name ]; then
  echo "Create Link for 2_ATLArouter (port_MIAM) on bridge "
  ip link add 23c22342dbd75_l type veth peer name 23c22342dbd75_c
  ovs-vsctl del-port int-2 23c22342dbd75_l
  ovs-vsctl add-port int-2 23c22342dbd75_l
  ovs-vsctl set interface 23c22342dbd75_l external_ids:container_id=2_ATLArouter external_ids:container_iface=port_MIAM
  ip link set 23c22342dbd75_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ATLArouter)
  create_netns_link
  ip link set 23c22342dbd75_c netns $PID
  ip netns exec $PID ip link set dev 23c22342dbd75_c name port_MIAM
  ip netns exec $PID ip link set port_MIAM up
  tc qdisc add dev 23c22342dbd75_l root netem delay 100 
  ovs-vsctl set interface 23c22342dbd75_l ingress_policing_rate=100000
fi
if [ "2_MIAMrouter" == $container_name ]; then
  echo "Create Link for 2_MIAMrouter (port_ATLA) on bridge "
  ip link add c6a1d6269eca5_l type veth peer name c6a1d6269eca5_c
  ovs-vsctl del-port int-2 c6a1d6269eca5_l
  ovs-vsctl add-port int-2 c6a1d6269eca5_l
  ovs-vsctl set interface c6a1d6269eca5_l external_ids:container_id=2_MIAMrouter external_ids:container_iface=port_ATLA
  ip link set c6a1d6269eca5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_MIAMrouter)
  create_netns_link
  ip link set c6a1d6269eca5_c netns $PID
  ip netns exec $PID ip link set dev c6a1d6269eca5_c name port_ATLA
  ip netns exec $PID ip link set port_ATLA up
  tc qdisc add dev c6a1d6269eca5_l root netem delay 100 
  ovs-vsctl set interface c6a1d6269eca5_l ingress_policing_rate=100000
fi
if [ "2_ATLArouter" == $container_name ] || [ "2_MIAMrouter" == $container_name ]; then
  echo "Link between 2_ATLArouter (port_MIAM) and 2_MIAMrouter (port_ATLA)"
  port_id1=`ovs-vsctl get Interface 23c22342dbd75_l ofport`
  port_id2=`ovs-vsctl get Interface c6a1d6269eca5_l ofport`
  ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
  ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
fi
if [ "1_ZURIrouter" == $container_name ]; then
  echo "Create Link for 1_ZURIrouter (ext_2_ZURI) on bridge "
  ip link add 6d0745e594805_l type veth peer name 6d0745e594805_c
  ovs-vsctl del-port ext-0 6d0745e594805_l
  ovs-vsctl add-port ext-0 6d0745e594805_l
  ovs-vsctl set interface 6d0745e594805_l external_ids:container_id=1_ZURIrouter external_ids:container_iface=ext_2_ZURI
  ip link set 6d0745e594805_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 1_ZURIrouter)
  create_netns_link
  ip link set 6d0745e594805_c netns $PID
  ip netns exec $PID ip link set dev 6d0745e594805_c name ext_2_ZURI
  ip netns exec $PID ip link set ext_2_ZURI up
  tc qdisc add dev 6d0745e594805_l root netem delay 1000 
  ovs-vsctl set interface 6d0745e594805_l ingress_policing_rate=100000
fi
if [ "2_ZURIrouter" == $container_name ]; then
  echo "Create Link for 2_ZURIrouter (ext_1_ZURI) on bridge "
  ip link add 085cd7c001ea5_l type veth peer name 085cd7c001ea5_c
  ovs-vsctl del-port ext-0 085cd7c001ea5_l
  ovs-vsctl add-port ext-0 085cd7c001ea5_l
  ovs-vsctl set interface 085cd7c001ea5_l external_ids:container_id=2_ZURIrouter external_ids:container_iface=ext_1_ZURI
  ip link set 085cd7c001ea5_l up
  PID=$(isula inspect -f '{{.State.Pid}}' 2_ZURIrouter)
  create_netns_link
  ip link set 085cd7c001ea5_c netns $PID
  ip netns exec $PID ip link set dev 085cd7c001ea5_c name ext_1_ZURI
  ip netns exec $PID ip link set ext_1_ZURI up
  tc qdisc add dev 085cd7c001ea5_l root netem delay 1000 
  ovs-vsctl set interface 085cd7c001ea5_l ingress_policing_rate=100000
fi
