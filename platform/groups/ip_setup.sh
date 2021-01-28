#!/bin/bash
source "/root/mini_internet_project/platform/setup/ovs-docker.sh"
echo "host links"
ip a add 0.0.0.0 dev 1-host
#ip link add 9a887e0093b95_l type veth peer name 9a887e0093b95_c
ip link set 9a887e0093b95_l up
PID=456382
create_netns_link
ip link set 9a887e0093b95_c netns $PID
ip netns exec $PID ip link set dev 9a887e0093b95_c name host
ip netns exec $PID ip link set host up
#ip link add 9bd35019028f5_l type veth peer name 9bd35019028f5_c
ip link set 9bd35019028f5_l up
PID=456427
create_netns_link
ip link set 9bd35019028f5_c netns $PID
ip netns exec $PID ip link set dev 9bd35019028f5_c name LONDrouter
ip netns exec $PID ip link set LONDrouter up
port_id1=`ovs-vsctl get Interface 9a887e0093b95_l ofport`
port_id2=`ovs-vsctl get Interface 9bd35019028f5_l ofport`
ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
PID=456427
create_netns_link
ip netns exec $PID ip a add 1.101.0.1/24 dev LONDrouter
ip netns exec $PID ip link set dev LONDrouter up
ip netns exec $PID ip route add default via 1.101.0.2
#ip link add 0005f2de67955_l type veth peer name 0005f2de67955_c
ip link set 0005f2de67955_l up
PID=456516
create_netns_link
ip link set 0005f2de67955_c netns $PID
ip netns exec $PID ip link set dev 0005f2de67955_c name host
ip netns exec $PID ip link set host up
#ip link add 54b6a831cfa55_l type veth peer name 54b6a831cfa55_c
ip link set 54b6a831cfa55_l up
PID=456601
create_netns_link
ip link set 54b6a831cfa55_c netns $PID
ip netns exec $PID ip link set dev 54b6a831cfa55_c name PARIrouter
ip netns exec $PID ip link set PARIrouter up
port_id1=`ovs-vsctl get Interface 0005f2de67955_l ofport`
port_id2=`ovs-vsctl get Interface 54b6a831cfa55_l ofport`
ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
PID=456601
create_netns_link
ip netns exec $PID ip a add 1.103.0.1/24 dev PARIrouter
ip netns exec $PID ip link set dev PARIrouter up
ip netns exec $PID ip route add default via 1.103.0.2
#ip link add 4fa7fc9cc7305_l type veth peer name 4fa7fc9cc7305_c
ip link set 4fa7fc9cc7305_l up
PID=456719
create_netns_link
ip link set 4fa7fc9cc7305_c netns $PID
ip netns exec $PID ip link set dev 4fa7fc9cc7305_c name host
ip netns exec $PID ip link set host up
#ip link add 313b353cf6655_l type veth peer name 313b353cf6655_c
ip link set 313b353cf6655_l up
PID=456807
create_netns_link
ip link set 313b353cf6655_c netns $PID
ip netns exec $PID ip link set dev 313b353cf6655_c name NEWYrouter
ip netns exec $PID ip link set NEWYrouter up
port_id1=`ovs-vsctl get Interface 4fa7fc9cc7305_l ofport`
port_id2=`ovs-vsctl get Interface 313b353cf6655_l ofport`
ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
PID=456807
create_netns_link
ip netns exec $PID ip a add 1.105.0.1/24 dev NEWYrouter
ip netns exec $PID ip link set dev NEWYrouter up
ip netns exec $PID ip route add default via 1.105.0.2
#ip link add 88b8cde13aba5_l type veth peer name 88b8cde13aba5_c
ip link set 88b8cde13aba5_l up
PID=456857
create_netns_link
ip link set 88b8cde13aba5_c netns $PID
ip netns exec $PID ip link set dev 88b8cde13aba5_c name host
ip netns exec $PID ip link set host up
#ip link add c16801781d145_l type veth peer name c16801781d145_c
ip link set c16801781d145_l up
PID=456967
create_netns_link
ip link set c16801781d145_c netns $PID
ip netns exec $PID ip link set dev c16801781d145_c name BOSTrouter
ip netns exec $PID ip link set BOSTrouter up
port_id1=`ovs-vsctl get Interface 88b8cde13aba5_l ofport`
port_id2=`ovs-vsctl get Interface c16801781d145_l ofport`
ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
PID=456967
create_netns_link
ip netns exec $PID ip a add 1.106.0.1/24 dev BOSTrouter
ip netns exec $PID ip link set dev BOSTrouter up
ip netns exec $PID ip route add default via 1.106.0.2
#ip link add cbfcd102f9fe5_l type veth peer name cbfcd102f9fe5_c
ip link set cbfcd102f9fe5_l up
PID=456992
create_netns_link
ip link set cbfcd102f9fe5_c netns $PID
ip netns exec $PID ip link set dev cbfcd102f9fe5_c name host
ip netns exec $PID ip link set host up
#ip link add 800f8a801e9c5_l type veth peer name 800f8a801e9c5_c
ip link set 800f8a801e9c5_l up
PID=457051
create_netns_link
ip link set 800f8a801e9c5_c netns $PID
ip netns exec $PID ip link set dev 800f8a801e9c5_c name ATLArouter
ip netns exec $PID ip link set ATLArouter up
port_id1=`ovs-vsctl get Interface cbfcd102f9fe5_l ofport`
port_id2=`ovs-vsctl get Interface 800f8a801e9c5_l ofport`
ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
PID=457051
create_netns_link
ip netns exec $PID ip a add 1.107.0.1/24 dev ATLArouter
ip netns exec $PID ip link set dev ATLArouter up
ip netns exec $PID ip route add default via 1.107.0.2
#ip link add d49c4f81576e5_l type veth peer name d49c4f81576e5_c
ip link set d49c4f81576e5_l up
PID=457106
create_netns_link
ip link set d49c4f81576e5_c netns $PID
ip netns exec $PID ip link set dev d49c4f81576e5_c name host
ip netns exec $PID ip link set host up
#ip link add bd5ae80001a35_l type veth peer name bd5ae80001a35_c
ip link set bd5ae80001a35_l up
PID=457193
create_netns_link
ip link set bd5ae80001a35_c netns $PID
ip netns exec $PID ip link set dev bd5ae80001a35_c name MIAMrouter
ip netns exec $PID ip link set MIAMrouter up
port_id1=`ovs-vsctl get Interface d49c4f81576e5_l ofport`
port_id2=`ovs-vsctl get Interface bd5ae80001a35_l ofport`
ovs-ofctl add-flow 1-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 1-host in_port=$port_id2,actions=output:$port_id1
PID=457193
create_netns_link
ip netns exec $PID ip a add 1.108.0.1/24 dev MIAMrouter
ip netns exec $PID ip link set dev MIAMrouter up
ip netns exec $PID ip route add default via 1.108.0.2
ip a add 0.0.0.0 dev 2-host
#ip link add 4e1af881c9005_l type veth peer name 4e1af881c9005_c
ip link set 4e1af881c9005_l up
PID=457972
create_netns_link
ip link set 4e1af881c9005_c netns $PID
ip netns exec $PID ip link set dev 4e1af881c9005_c name host
ip netns exec $PID ip link set host up
#ip link add 990435db36665_l type veth peer name 990435db36665_c
ip link set 990435db36665_l up
PID=458018
create_netns_link
ip link set 990435db36665_c netns $PID
ip netns exec $PID ip link set dev 990435db36665_c name LONDrouter
ip netns exec $PID ip link set LONDrouter up
port_id1=`ovs-vsctl get Interface 4e1af881c9005_l ofport`
port_id2=`ovs-vsctl get Interface 990435db36665_l ofport`
ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
PID=458018
create_netns_link
ip netns exec $PID ip a add 2.101.0.1/24 dev LONDrouter
ip netns exec $PID ip link set dev LONDrouter up
ip netns exec $PID ip route add default via 2.101.0.2
#ip link add e57d011e884e5_l type veth peer name e57d011e884e5_c
ip link set e57d011e884e5_l up
PID=458114
create_netns_link
ip link set e57d011e884e5_c netns $PID
ip netns exec $PID ip link set dev e57d011e884e5_c name host
ip netns exec $PID ip link set host up
#ip link add c0230f07bdbe5_l type veth peer name c0230f07bdbe5_c
ip link set c0230f07bdbe5_l up
PID=458193
create_netns_link
ip link set c0230f07bdbe5_c netns $PID
ip netns exec $PID ip link set dev c0230f07bdbe5_c name PARIrouter
ip netns exec $PID ip link set PARIrouter up
port_id1=`ovs-vsctl get Interface e57d011e884e5_l ofport`
port_id2=`ovs-vsctl get Interface c0230f07bdbe5_l ofport`
ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
PID=458193
create_netns_link
ip netns exec $PID ip a add 2.103.0.1/24 dev PARIrouter
ip netns exec $PID ip link set dev PARIrouter up
ip netns exec $PID ip route add default via 2.103.0.2
#ip link add d7d5c5533f795_l type veth peer name d7d5c5533f795_c
ip link set d7d5c5533f795_l up
PID=458338
create_netns_link
ip link set d7d5c5533f795_c netns $PID
ip netns exec $PID ip link set dev d7d5c5533f795_c name host
ip netns exec $PID ip link set host up
#ip link add c8edf20588995_l type veth peer name c8edf20588995_c
ip link set c8edf20588995_l up
PID=458412
create_netns_link
ip link set c8edf20588995_c netns $PID
ip netns exec $PID ip link set dev c8edf20588995_c name NEWYrouter
ip netns exec $PID ip link set NEWYrouter up
port_id1=`ovs-vsctl get Interface d7d5c5533f795_l ofport`
port_id2=`ovs-vsctl get Interface c8edf20588995_l ofport`
ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
PID=458412
create_netns_link
ip netns exec $PID ip a add 2.105.0.1/24 dev NEWYrouter
ip netns exec $PID ip link set dev NEWYrouter up
ip netns exec $PID ip route add default via 2.105.0.2
#ip link add 44462c0ac1645_l type veth peer name 44462c0ac1645_c
ip link set 44462c0ac1645_l up
PID=458491
create_netns_link
ip link set 44462c0ac1645_c netns $PID
ip netns exec $PID ip link set dev 44462c0ac1645_c name host
ip netns exec $PID ip link set host up
#ip link add a36638d2aff05_l type veth peer name a36638d2aff05_c
ip link set a36638d2aff05_l up
PID=458557
create_netns_link
ip link set a36638d2aff05_c netns $PID
ip netns exec $PID ip link set dev a36638d2aff05_c name BOSTrouter
ip netns exec $PID ip link set BOSTrouter up
port_id1=`ovs-vsctl get Interface 44462c0ac1645_l ofport`
port_id2=`ovs-vsctl get Interface a36638d2aff05_l ofport`
ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
PID=458557
create_netns_link
ip netns exec $PID ip a add 2.106.0.1/24 dev BOSTrouter
ip netns exec $PID ip link set dev BOSTrouter up
ip netns exec $PID ip route add default via 2.106.0.2
#ip link add 965ee8f95af15_l type veth peer name 965ee8f95af15_c
ip link set 965ee8f95af15_l up
PID=458584
create_netns_link
ip link set 965ee8f95af15_c netns $PID
ip netns exec $PID ip link set dev 965ee8f95af15_c name host
ip netns exec $PID ip link set host up
#ip link add f2f93280613b5_l type veth peer name f2f93280613b5_c
ip link set f2f93280613b5_l up
PID=458709
create_netns_link
ip link set f2f93280613b5_c netns $PID
ip netns exec $PID ip link set dev f2f93280613b5_c name ATLArouter
ip netns exec $PID ip link set ATLArouter up
port_id1=`ovs-vsctl get Interface 965ee8f95af15_l ofport`
port_id2=`ovs-vsctl get Interface f2f93280613b5_l ofport`
ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
PID=458709
create_netns_link
ip netns exec $PID ip a add 2.107.0.1/24 dev ATLArouter
ip netns exec $PID ip link set dev ATLArouter up
ip netns exec $PID ip route add default via 2.107.0.2
#ip link add 1e8bee111bba5_l type veth peer name 1e8bee111bba5_c
ip link set 1e8bee111bba5_l up
PID=458733
create_netns_link
ip link set 1e8bee111bba5_c netns $PID
ip netns exec $PID ip link set dev 1e8bee111bba5_c name host
ip netns exec $PID ip link set host up
#ip link add b0e88b477aae5_l type veth peer name b0e88b477aae5_c
ip link set b0e88b477aae5_l up
PID=458783
create_netns_link
ip link set b0e88b477aae5_c netns $PID
ip netns exec $PID ip link set dev b0e88b477aae5_c name MIAMrouter
ip netns exec $PID ip link set MIAMrouter up
port_id1=`ovs-vsctl get Interface 1e8bee111bba5_l ofport`
port_id2=`ovs-vsctl get Interface b0e88b477aae5_l ofport`
ovs-ofctl add-flow 2-host in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow 2-host in_port=$port_id2,actions=output:$port_id1
PID=458783
create_netns_link
ip netns exec $PID ip a add 2.108.0.1/24 dev MIAMrouter
ip netns exec $PID ip link set dev MIAMrouter up
ip netns exec $PID ip route add default via 2.108.0.2
echo "layer2 links"
#ip link add 8b47f22f749e5_l type veth peer name 8b47f22f749e5_c
ip link set 8b47f22f749e5_l up
PID=455624
create_netns_link
ip link set 8b47f22f749e5_c netns $PID
ip netns exec $PID ip link set dev 8b47f22f749e5_c name 1-CERN
ip netns exec $PID ip link set 1-CERN up
#ip link add 34747abce97c5_l type veth peer name 34747abce97c5_c
ip link set 34747abce97c5_l up
PID=455438
create_netns_link
ip link set 34747abce97c5_c netns $PID
ip netns exec $PID ip link set dev 34747abce97c5_c name 1-ETHZ
ip netns exec $PID ip link set 1-ETHZ up
port_id1=`ovs-vsctl get Interface 8b47f22f749e5_l ofport`
port_id2=`ovs-vsctl get Interface 34747abce97c5_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add b4669d5438e45_l type veth peer name b4669d5438e45_c
ip link set b4669d5438e45_l up
PID=455624
create_netns_link
ip link set b4669d5438e45_c netns $PID
ip netns exec $PID ip link set dev b4669d5438e45_c name 1-EPFL
ip netns exec $PID ip link set 1-EPFL up
#ip link add c573b88be4855_l type veth peer name c573b88be4855_c
ip link set c573b88be4855_l up
PID=455810
create_netns_link
ip link set c573b88be4855_c netns $PID
ip netns exec $PID ip link set dev c573b88be4855_c name 1-ETHZ
ip netns exec $PID ip link set 1-ETHZ up
port_id1=`ovs-vsctl get Interface b4669d5438e45_l ofport`
port_id2=`ovs-vsctl get Interface c573b88be4855_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 9dfea811e72a5_l type veth peer name 9dfea811e72a5_c
ip link set 9dfea811e72a5_l up
PID=455438
create_netns_link
ip link set 9dfea811e72a5_c netns $PID
ip netns exec $PID ip link set dev 9dfea811e72a5_c name 1-EPFL
ip netns exec $PID ip link set 1-EPFL up
#ip link add 1f336da0e4e95_l type veth peer name 1f336da0e4e95_c
ip link set 1f336da0e4e95_l up
PID=455810
create_netns_link
ip link set 1f336da0e4e95_c netns $PID
ip netns exec $PID ip link set dev 1f336da0e4e95_c name 1-CERN
ip netns exec $PID ip link set 1-CERN up
port_id1=`ovs-vsctl get Interface 9dfea811e72a5_l ofport`
port_id2=`ovs-vsctl get Interface 1f336da0e4e95_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 678412fc9c435_l type veth peer name 678412fc9c435_c
ip link set 678412fc9c435_l up
PID=455438
create_netns_link
ip link set 678412fc9c435_c netns $PID
ip netns exec $PID ip link set dev 678412fc9c435_c name 1-student-1
ip netns exec $PID ip link set 1-student-1 up
#ip link add cd24433aea185_l type veth peer name cd24433aea185_c
ip link set cd24433aea185_l up
PID=455995
create_netns_link
ip link set cd24433aea185_c netns $PID
ip netns exec $PID ip link set dev cd24433aea185_c name 1-CERN
ip netns exec $PID ip link set 1-CERN up
port_id1=`ovs-vsctl get Interface 678412fc9c435_l ofport`
port_id2=`ovs-vsctl get Interface cd24433aea185_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 54e1a20a25295_l type veth peer name 54e1a20a25295_c
ip link set 54e1a20a25295_l up
PID=455438
create_netns_link
ip link set 54e1a20a25295_c netns $PID
ip netns exec $PID ip link set dev 54e1a20a25295_c name 1-staff-1
ip netns exec $PID ip link set 1-staff-1 up
#ip link add f034ca4802985_l type veth peer name f034ca4802985_c
ip link set f034ca4802985_l up
PID=456021
create_netns_link
ip link set f034ca4802985_c netns $PID
ip netns exec $PID ip link set dev f034ca4802985_c name 1-CERN
ip netns exec $PID ip link set 1-CERN up
port_id1=`ovs-vsctl get Interface 54e1a20a25295_l ofport`
port_id2=`ovs-vsctl get Interface f034ca4802985_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 7d4d0b12ef895_l type veth peer name 7d4d0b12ef895_c
ip link set 7d4d0b12ef895_l up
PID=455624
create_netns_link
ip link set 7d4d0b12ef895_c netns $PID
ip netns exec $PID ip link set dev 7d4d0b12ef895_c name 1-student-2
ip netns exec $PID ip link set 1-student-2 up
#ip link add 54cd9a328f405_l type veth peer name 54cd9a328f405_c
ip link set 54cd9a328f405_l up
PID=456043
create_netns_link
ip link set 54cd9a328f405_c netns $PID
ip netns exec $PID ip link set dev 54cd9a328f405_c name 1-ETHZ
ip netns exec $PID ip link set 1-ETHZ up
port_id1=`ovs-vsctl get Interface 7d4d0b12ef895_l ofport`
port_id2=`ovs-vsctl get Interface 54cd9a328f405_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add e4f4630af3725_l type veth peer name e4f4630af3725_c
ip link set e4f4630af3725_l up
PID=455624
create_netns_link
ip link set e4f4630af3725_c netns $PID
ip netns exec $PID ip link set dev e4f4630af3725_c name 1-staff-2
ip netns exec $PID ip link set 1-staff-2 up
#ip link add 90251347b18b5_l type veth peer name 90251347b18b5_c
ip link set 90251347b18b5_l up
PID=456065
create_netns_link
ip link set 90251347b18b5_c netns $PID
ip netns exec $PID ip link set dev 90251347b18b5_c name 1-ETHZ
ip netns exec $PID ip link set 1-ETHZ up
port_id1=`ovs-vsctl get Interface e4f4630af3725_l ofport`
port_id2=`ovs-vsctl get Interface 90251347b18b5_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 403bd02b92005_l type veth peer name 403bd02b92005_c
ip link set 403bd02b92005_l up
PID=455810
create_netns_link
ip link set 403bd02b92005_c netns $PID
ip netns exec $PID ip link set dev 403bd02b92005_c name 1-student-3
ip netns exec $PID ip link set 1-student-3 up
#ip link add 392c9e7407f85_l type veth peer name 392c9e7407f85_c
ip link set 392c9e7407f85_l up
PID=456087
create_netns_link
ip link set 392c9e7407f85_c netns $PID
ip netns exec $PID ip link set dev 392c9e7407f85_c name 1-EPFL
ip netns exec $PID ip link set 1-EPFL up
port_id1=`ovs-vsctl get Interface 403bd02b92005_l ofport`
port_id2=`ovs-vsctl get Interface 392c9e7407f85_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 9106141effe15_l type veth peer name 9106141effe15_c
ip link set 9106141effe15_l up
PID=455810
create_netns_link
ip link set 9106141effe15_c netns $PID
ip netns exec $PID ip link set dev 9106141effe15_c name 1-staff-3
ip netns exec $PID ip link set 1-staff-3 up
#ip link add ebff9b083bbd5_l type veth peer name ebff9b083bbd5_c
ip link set ebff9b083bbd5_l up
PID=456109
create_netns_link
ip link set ebff9b083bbd5_c netns $PID
ip netns exec $PID ip link set dev ebff9b083bbd5_c name 1-EPFL
ip netns exec $PID ip link set 1-EPFL up
port_id1=`ovs-vsctl get Interface 9106141effe15_l ofport`
port_id2=`ovs-vsctl get Interface ebff9b083bbd5_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add ee88ffbd51e55_l type veth peer name ee88ffbd51e55_c
ip link set ee88ffbd51e55_l up
PID=456456
create_netns_link
ip link set ee88ffbd51e55_c netns $PID
ip netns exec $PID ip link set dev ee88ffbd51e55_c name ZURI-L2
ip netns exec $PID ip link set ZURI-L2 up
#ip link add c809849a08c95_l type veth peer name c809849a08c95_c
ip link set c809849a08c95_l up
PID=455624
create_netns_link
ip link set c809849a08c95_c netns $PID
ip netns exec $PID ip link set dev c809849a08c95_c name ZURIrouter
ip netns exec $PID ip link set ZURIrouter up
port_id1=`ovs-vsctl get Interface ee88ffbd51e55_l ofport`
port_id2=`ovs-vsctl get Interface c809849a08c95_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add b9fa783cb3e55_l type veth peer name b9fa783cb3e55_c
ip link set b9fa783cb3e55_l up
PID=456662
create_netns_link
ip link set b9fa783cb3e55_c netns $PID
ip netns exec $PID ip link set dev b9fa783cb3e55_c name GENE-L2
ip netns exec $PID ip link set GENE-L2 up
#ip link add c86b623846965_l type veth peer name c86b623846965_c
ip link set c86b623846965_l up
PID=455438
create_netns_link
ip link set c86b623846965_c netns $PID
ip netns exec $PID ip link set dev c86b623846965_c name GENErouter
ip netns exec $PID ip link set GENErouter up
port_id1=`ovs-vsctl get Interface b9fa783cb3e55_l ofport`
port_id2=`ovs-vsctl get Interface c86b623846965_l ofport`
ovs-ofctl add-flow l2-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-1 in_port=$port_id2,actions=output:$port_id1
#ip link add cc21683f7e265_l type veth peer name cc21683f7e265_c
ip link set cc21683f7e265_l up
PID=457395
create_netns_link
ip link set cc21683f7e265_c netns $PID
ip netns exec $PID ip link set dev cc21683f7e265_c name 2-CERN
ip netns exec $PID ip link set 2-CERN up
#ip link add c1b2bc185ac15_l type veth peer name c1b2bc185ac15_c
ip link set c1b2bc185ac15_l up
PID=457273
create_netns_link
ip link set c1b2bc185ac15_c netns $PID
ip netns exec $PID ip link set dev c1b2bc185ac15_c name 2-ETHZ
ip netns exec $PID ip link set 2-ETHZ up
port_id1=`ovs-vsctl get Interface cc21683f7e265_l ofport`
port_id2=`ovs-vsctl get Interface c1b2bc185ac15_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 3fca714f72cf5_l type veth peer name 3fca714f72cf5_c
ip link set 3fca714f72cf5_l up
PID=457395
create_netns_link
ip link set 3fca714f72cf5_c netns $PID
ip netns exec $PID ip link set dev 3fca714f72cf5_c name 2-EPFL
ip netns exec $PID ip link set 2-EPFL up
#ip link add e1837048f81f5_l type veth peer name e1837048f81f5_c
ip link set e1837048f81f5_l up
PID=457649
create_netns_link
ip link set e1837048f81f5_c netns $PID
ip netns exec $PID ip link set dev e1837048f81f5_c name 2-ETHZ
ip netns exec $PID ip link set 2-ETHZ up
port_id1=`ovs-vsctl get Interface 3fca714f72cf5_l ofport`
port_id2=`ovs-vsctl get Interface e1837048f81f5_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add e882d64b2a6e5_l type veth peer name e882d64b2a6e5_c
ip link set e882d64b2a6e5_l up
PID=457273
create_netns_link
ip link set e882d64b2a6e5_c netns $PID
ip netns exec $PID ip link set dev e882d64b2a6e5_c name 2-EPFL
ip netns exec $PID ip link set 2-EPFL up
#ip link add 815c35d2df415_l type veth peer name 815c35d2df415_c
ip link set 815c35d2df415_l up
PID=457649
create_netns_link
ip link set 815c35d2df415_c netns $PID
ip netns exec $PID ip link set dev 815c35d2df415_c name 2-CERN
ip netns exec $PID ip link set 2-CERN up
port_id1=`ovs-vsctl get Interface e882d64b2a6e5_l ofport`
port_id2=`ovs-vsctl get Interface 815c35d2df415_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 112b35cd3c3a5_l type veth peer name 112b35cd3c3a5_c
ip link set 112b35cd3c3a5_l up
PID=457273
create_netns_link
ip link set 112b35cd3c3a5_c netns $PID
ip netns exec $PID ip link set dev 112b35cd3c3a5_c name 2-student-1
ip netns exec $PID ip link set 2-student-1 up
#ip link add 3fa562e686e45_l type veth peer name 3fa562e686e45_c
ip link set 3fa562e686e45_l up
PID=457835
create_netns_link
ip link set 3fa562e686e45_c netns $PID
ip netns exec $PID ip link set dev 3fa562e686e45_c name 2-CERN
ip netns exec $PID ip link set 2-CERN up
port_id1=`ovs-vsctl get Interface 112b35cd3c3a5_l ofport`
port_id2=`ovs-vsctl get Interface 3fa562e686e45_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add de3d6e5bb8ae5_l type veth peer name de3d6e5bb8ae5_c
ip link set de3d6e5bb8ae5_l up
PID=457273
create_netns_link
ip link set de3d6e5bb8ae5_c netns $PID
ip netns exec $PID ip link set dev de3d6e5bb8ae5_c name 2-staff-1
ip netns exec $PID ip link set 2-staff-1 up
#ip link add cb5fff76ff925_l type veth peer name cb5fff76ff925_c
ip link set cb5fff76ff925_l up
PID=457857
create_netns_link
ip link set cb5fff76ff925_c netns $PID
ip netns exec $PID ip link set dev cb5fff76ff925_c name 2-CERN
ip netns exec $PID ip link set 2-CERN up
port_id1=`ovs-vsctl get Interface de3d6e5bb8ae5_l ofport`
port_id2=`ovs-vsctl get Interface cb5fff76ff925_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add a7f5ad2b16eb5_l type veth peer name a7f5ad2b16eb5_c
ip link set a7f5ad2b16eb5_l up
PID=457395
create_netns_link
ip link set a7f5ad2b16eb5_c netns $PID
ip netns exec $PID ip link set dev a7f5ad2b16eb5_c name 2-student-2
ip netns exec $PID ip link set 2-student-2 up
#ip link add 484efdf909e45_l type veth peer name 484efdf909e45_c
ip link set 484efdf909e45_l up
PID=457879
create_netns_link
ip link set 484efdf909e45_c netns $PID
ip netns exec $PID ip link set dev 484efdf909e45_c name 2-ETHZ
ip netns exec $PID ip link set 2-ETHZ up
port_id1=`ovs-vsctl get Interface a7f5ad2b16eb5_l ofport`
port_id2=`ovs-vsctl get Interface 484efdf909e45_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add e7e2185aa5345_l type veth peer name e7e2185aa5345_c
ip link set e7e2185aa5345_l up
PID=457395
create_netns_link
ip link set e7e2185aa5345_c netns $PID
ip netns exec $PID ip link set dev e7e2185aa5345_c name 2-staff-2
ip netns exec $PID ip link set 2-staff-2 up
#ip link add 5273a31aff8a5_l type veth peer name 5273a31aff8a5_c
ip link set 5273a31aff8a5_l up
PID=457904
create_netns_link
ip link set 5273a31aff8a5_c netns $PID
ip netns exec $PID ip link set dev 5273a31aff8a5_c name 2-ETHZ
ip netns exec $PID ip link set 2-ETHZ up
port_id1=`ovs-vsctl get Interface e7e2185aa5345_l ofport`
port_id2=`ovs-vsctl get Interface 5273a31aff8a5_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 221d3acdcd3c5_l type veth peer name 221d3acdcd3c5_c
ip link set 221d3acdcd3c5_l up
PID=457649
create_netns_link
ip link set 221d3acdcd3c5_c netns $PID
ip netns exec $PID ip link set dev 221d3acdcd3c5_c name 2-student-3
ip netns exec $PID ip link set 2-student-3 up
#ip link add 26b86114725d5_l type veth peer name 26b86114725d5_c
ip link set 26b86114725d5_l up
PID=457926
create_netns_link
ip link set 26b86114725d5_c netns $PID
ip netns exec $PID ip link set dev 26b86114725d5_c name 2-EPFL
ip netns exec $PID ip link set 2-EPFL up
port_id1=`ovs-vsctl get Interface 221d3acdcd3c5_l ofport`
port_id2=`ovs-vsctl get Interface 26b86114725d5_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 180143d5a1a05_l type veth peer name 180143d5a1a05_c
ip link set 180143d5a1a05_l up
PID=457649
create_netns_link
ip link set 180143d5a1a05_c netns $PID
ip netns exec $PID ip link set dev 180143d5a1a05_c name 2-staff-3
ip netns exec $PID ip link set 2-staff-3 up
#ip link add cb59f97af79e5_l type veth peer name cb59f97af79e5_c
ip link set cb59f97af79e5_l up
PID=457948
create_netns_link
ip link set cb59f97af79e5_c netns $PID
ip netns exec $PID ip link set dev cb59f97af79e5_c name 2-EPFL
ip netns exec $PID ip link set 2-EPFL up
port_id1=`ovs-vsctl get Interface 180143d5a1a05_l ofport`
port_id2=`ovs-vsctl get Interface cb59f97af79e5_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add bea9dacb3eee5_l type veth peer name bea9dacb3eee5_c
ip link set bea9dacb3eee5_l up
PID=458047
create_netns_link
ip link set bea9dacb3eee5_c netns $PID
ip netns exec $PID ip link set dev bea9dacb3eee5_c name ZURI-L2
ip netns exec $PID ip link set ZURI-L2 up
#ip link add 3dbfa967cf855_l type veth peer name 3dbfa967cf855_c
ip link set 3dbfa967cf855_l up
PID=457395
create_netns_link
ip link set 3dbfa967cf855_c netns $PID
ip netns exec $PID ip link set dev 3dbfa967cf855_c name ZURIrouter
ip netns exec $PID ip link set ZURIrouter up
port_id1=`ovs-vsctl get Interface bea9dacb3eee5_l ofport`
port_id2=`ovs-vsctl get Interface 3dbfa967cf855_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 02a552141d625_l type veth peer name 02a552141d625_c
ip link set 02a552141d625_l up
PID=458259
create_netns_link
ip link set 02a552141d625_c netns $PID
ip netns exec $PID ip link set dev 02a552141d625_c name GENE-L2
ip netns exec $PID ip link set GENE-L2 up
#ip link add 929ac03595d75_l type veth peer name 929ac03595d75_c
ip link set 929ac03595d75_l up
PID=457273
create_netns_link
ip link set 929ac03595d75_c netns $PID
ip netns exec $PID ip link set dev 929ac03595d75_c name GENErouter
ip netns exec $PID ip link set GENErouter up
port_id1=`ovs-vsctl get Interface 02a552141d625_l ofport`
port_id2=`ovs-vsctl get Interface 929ac03595d75_l ofport`
ovs-ofctl add-flow l2-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow l2-2 in_port=$port_id2,actions=output:$port_id1
echo "internal links"
ip link set dev int-1 up
#ip link add 57f7628155a65_l type veth peer name 57f7628155a65_c
ip link set 57f7628155a65_l up
PID=456456
create_netns_link
ip link set 57f7628155a65_c netns $PID
ip netns exec $PID ip link set dev 57f7628155a65_c name port_PARI
ip netns exec $PID ip link set port_PARI up
#ip link add 2d0661670ed85_l type veth peer name 2d0661670ed85_c
ip link set 2d0661670ed85_l up
PID=456516
create_netns_link
ip link set 2d0661670ed85_c netns $PID
ip netns exec $PID ip link set dev 2d0661670ed85_c name port_ZURI
ip netns exec $PID ip link set port_ZURI up
port_id1=`ovs-vsctl get Interface 57f7628155a65_l ofport`
port_id2=`ovs-vsctl get Interface 2d0661670ed85_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add d8b4f41fd1045_l type veth peer name d8b4f41fd1045_c
ip link set d8b4f41fd1045_l up
PID=456456
create_netns_link
ip link set d8b4f41fd1045_c netns $PID
ip netns exec $PID ip link set dev d8b4f41fd1045_c name port_LOND
ip netns exec $PID ip link set port_LOND up
#ip link add c62bc80903ee5_l type veth peer name c62bc80903ee5_c
ip link set c62bc80903ee5_l up
PID=456382
create_netns_link
ip link set c62bc80903ee5_c netns $PID
ip netns exec $PID ip link set dev c62bc80903ee5_c name port_ZURI
ip netns exec $PID ip link set port_ZURI up
port_id1=`ovs-vsctl get Interface d8b4f41fd1045_l ofport`
port_id2=`ovs-vsctl get Interface c62bc80903ee5_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 3692691c63395_l type veth peer name 3692691c63395_c
ip link set 3692691c63395_l up
PID=456516
create_netns_link
ip link set 3692691c63395_c netns $PID
ip netns exec $PID ip link set dev 3692691c63395_c name port_GENE
ip netns exec $PID ip link set port_GENE up
#ip link add cb26dd7d45a35_l type veth peer name cb26dd7d45a35_c
ip link set cb26dd7d45a35_l up
PID=456662
create_netns_link
ip link set cb26dd7d45a35_c netns $PID
ip netns exec $PID ip link set dev cb26dd7d45a35_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface 3692691c63395_l ofport`
port_id2=`ovs-vsctl get Interface cb26dd7d45a35_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add f82e2fadd1a45_l type veth peer name f82e2fadd1a45_c
ip link set f82e2fadd1a45_l up
PID=456516
create_netns_link
ip link set f82e2fadd1a45_c netns $PID
ip netns exec $PID ip link set dev f82e2fadd1a45_c name port_LOND
ip netns exec $PID ip link set port_LOND up
#ip link add ac50c6e5f3245_l type veth peer name ac50c6e5f3245_c
ip link set ac50c6e5f3245_l up
PID=456382
create_netns_link
ip link set ac50c6e5f3245_c netns $PID
ip netns exec $PID ip link set dev ac50c6e5f3245_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface f82e2fadd1a45_l ofport`
port_id2=`ovs-vsctl get Interface ac50c6e5f3245_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 50df403685995_l type veth peer name 50df403685995_c
ip link set 50df403685995_l up
PID=456516
create_netns_link
ip link set 50df403685995_c netns $PID
ip netns exec $PID ip link set dev 50df403685995_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
#ip link add 4fc4efe9fc665_l type veth peer name 4fc4efe9fc665_c
ip link set 4fc4efe9fc665_l up
PID=456719
create_netns_link
ip link set 4fc4efe9fc665_c netns $PID
ip netns exec $PID ip link set dev 4fc4efe9fc665_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface 50df403685995_l ofport`
port_id2=`ovs-vsctl get Interface 4fc4efe9fc665_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add ad3f31b490fa5_l type veth peer name ad3f31b490fa5_c
ip link set ad3f31b490fa5_l up
PID=456516
create_netns_link
ip link set ad3f31b490fa5_c netns $PID
ip netns exec $PID ip link set dev ad3f31b490fa5_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add 4f7e8d7f5ccc5_l type veth peer name 4f7e8d7f5ccc5_c
ip link set 4f7e8d7f5ccc5_l up
PID=457106
create_netns_link
ip link set 4f7e8d7f5ccc5_c netns $PID
ip netns exec $PID ip link set dev 4f7e8d7f5ccc5_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface ad3f31b490fa5_l ofport`
port_id2=`ovs-vsctl get Interface 4f7e8d7f5ccc5_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add cd7ebf6ece3d5_l type veth peer name cd7ebf6ece3d5_c
ip link set cd7ebf6ece3d5_l up
PID=456382
create_netns_link
ip link set cd7ebf6ece3d5_c netns $PID
ip netns exec $PID ip link set dev cd7ebf6ece3d5_c name port_BOST
ip netns exec $PID ip link set port_BOST up
#ip link add 119ded19b4de5_l type veth peer name 119ded19b4de5_c
ip link set 119ded19b4de5_l up
PID=456857
create_netns_link
ip link set 119ded19b4de5_c netns $PID
ip netns exec $PID ip link set dev 119ded19b4de5_c name port_LOND
ip netns exec $PID ip link set port_LOND up
port_id1=`ovs-vsctl get Interface cd7ebf6ece3d5_l ofport`
port_id2=`ovs-vsctl get Interface 119ded19b4de5_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 3891ca77504b5_l type veth peer name 3891ca77504b5_c
ip link set 3891ca77504b5_l up
PID=456382
create_netns_link
ip link set 3891ca77504b5_c netns $PID
ip netns exec $PID ip link set dev 3891ca77504b5_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
#ip link add db797f923d8c5_l type veth peer name db797f923d8c5_c
ip link set db797f923d8c5_l up
PID=456719
create_netns_link
ip link set db797f923d8c5_c netns $PID
ip netns exec $PID ip link set dev db797f923d8c5_c name port_LOND
ip netns exec $PID ip link set port_LOND up
port_id1=`ovs-vsctl get Interface 3891ca77504b5_l ofport`
port_id2=`ovs-vsctl get Interface db797f923d8c5_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 0ed10f73231e5_l type veth peer name 0ed10f73231e5_c
ip link set 0ed10f73231e5_l up
PID=456662
create_netns_link
ip link set 0ed10f73231e5_c netns $PID
ip netns exec $PID ip link set dev 0ed10f73231e5_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add fab839ff790f5_l type veth peer name fab839ff790f5_c
ip link set fab839ff790f5_l up
PID=457106
create_netns_link
ip link set fab839ff790f5_c netns $PID
ip netns exec $PID ip link set dev fab839ff790f5_c name port_GENE
ip netns exec $PID ip link set port_GENE up
port_id1=`ovs-vsctl get Interface 0ed10f73231e5_l ofport`
port_id2=`ovs-vsctl get Interface fab839ff790f5_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 8a2ab342b0485_l type veth peer name 8a2ab342b0485_c
ip link set 8a2ab342b0485_l up
PID=456719
create_netns_link
ip link set 8a2ab342b0485_c netns $PID
ip netns exec $PID ip link set dev 8a2ab342b0485_c name port_BOST
ip netns exec $PID ip link set port_BOST up
#ip link add c70b35236ac55_l type veth peer name c70b35236ac55_c
ip link set c70b35236ac55_l up
PID=456857
create_netns_link
ip link set c70b35236ac55_c netns $PID
ip netns exec $PID ip link set dev c70b35236ac55_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
port_id1=`ovs-vsctl get Interface 8a2ab342b0485_l ofport`
port_id2=`ovs-vsctl get Interface c70b35236ac55_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 3a81517af39d5_l type veth peer name 3a81517af39d5_c
ip link set 3a81517af39d5_l up
PID=456719
create_netns_link
ip link set 3a81517af39d5_c netns $PID
ip netns exec $PID ip link set dev 3a81517af39d5_c name port_ATLA
ip netns exec $PID ip link set port_ATLA up
#ip link add f0dfc83646755_l type veth peer name f0dfc83646755_c
ip link set f0dfc83646755_l up
PID=456992
create_netns_link
ip link set f0dfc83646755_c netns $PID
ip netns exec $PID ip link set dev f0dfc83646755_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
port_id1=`ovs-vsctl get Interface 3a81517af39d5_l ofport`
port_id2=`ovs-vsctl get Interface f0dfc83646755_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 89ac4c17b95c5_l type veth peer name 89ac4c17b95c5_c
ip link set 89ac4c17b95c5_l up
PID=456719
create_netns_link
ip link set 89ac4c17b95c5_c netns $PID
ip netns exec $PID ip link set dev 89ac4c17b95c5_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add 695b257b5db65_l type veth peer name 695b257b5db65_c
ip link set 695b257b5db65_l up
PID=457106
create_netns_link
ip link set 695b257b5db65_c netns $PID
ip netns exec $PID ip link set dev 695b257b5db65_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
port_id1=`ovs-vsctl get Interface 89ac4c17b95c5_l ofport`
port_id2=`ovs-vsctl get Interface 695b257b5db65_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
#ip link add 1f14aa3219f45_l type veth peer name 1f14aa3219f45_c
ip link set 1f14aa3219f45_l up
PID=456992
create_netns_link
ip link set 1f14aa3219f45_c netns $PID
ip netns exec $PID ip link set dev 1f14aa3219f45_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add 47d7221f8c905_l type veth peer name 47d7221f8c905_c
ip link set 47d7221f8c905_l up
PID=457106
create_netns_link
ip link set 47d7221f8c905_c netns $PID
ip netns exec $PID ip link set dev 47d7221f8c905_c name port_ATLA
ip netns exec $PID ip link set port_ATLA up
port_id1=`ovs-vsctl get Interface 1f14aa3219f45_l ofport`
port_id2=`ovs-vsctl get Interface 47d7221f8c905_l ofport`
ovs-ofctl add-flow int-1 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-1 in_port=$port_id2,actions=output:$port_id1
ip link set dev int-2 up
#ip link add 346917b814d35_l type veth peer name 346917b814d35_c
ip link set 346917b814d35_l up
PID=458047
create_netns_link
ip link set 346917b814d35_c netns $PID
ip netns exec $PID ip link set dev 346917b814d35_c name port_PARI
ip netns exec $PID ip link set port_PARI up
#ip link add 95519b49b05c5_l type veth peer name 95519b49b05c5_c
ip link set 95519b49b05c5_l up
PID=458114
create_netns_link
ip link set 95519b49b05c5_c netns $PID
ip netns exec $PID ip link set dev 95519b49b05c5_c name port_ZURI
ip netns exec $PID ip link set port_ZURI up
port_id1=`ovs-vsctl get Interface 346917b814d35_l ofport`
port_id2=`ovs-vsctl get Interface 95519b49b05c5_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 7c453dae95265_l type veth peer name 7c453dae95265_c
ip link set 7c453dae95265_l up
PID=458047
create_netns_link
ip link set 7c453dae95265_c netns $PID
ip netns exec $PID ip link set dev 7c453dae95265_c name port_LOND
ip netns exec $PID ip link set port_LOND up
#ip link add 48c3c0893c095_l type veth peer name 48c3c0893c095_c
ip link set 48c3c0893c095_l up
PID=457972
create_netns_link
ip link set 48c3c0893c095_c netns $PID
ip netns exec $PID ip link set dev 48c3c0893c095_c name port_ZURI
ip netns exec $PID ip link set port_ZURI up
port_id1=`ovs-vsctl get Interface 7c453dae95265_l ofport`
port_id2=`ovs-vsctl get Interface 48c3c0893c095_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add b9ca6db45e665_l type veth peer name b9ca6db45e665_c
ip link set b9ca6db45e665_l up
PID=458114
create_netns_link
ip link set b9ca6db45e665_c netns $PID
ip netns exec $PID ip link set dev b9ca6db45e665_c name port_GENE
ip netns exec $PID ip link set port_GENE up
#ip link add c762cdaef08b5_l type veth peer name c762cdaef08b5_c
ip link set c762cdaef08b5_l up
PID=458259
create_netns_link
ip link set c762cdaef08b5_c netns $PID
ip netns exec $PID ip link set dev c762cdaef08b5_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface b9ca6db45e665_l ofport`
port_id2=`ovs-vsctl get Interface c762cdaef08b5_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 1c96a4bfc8705_l type veth peer name 1c96a4bfc8705_c
ip link set 1c96a4bfc8705_l up
PID=458114
create_netns_link
ip link set 1c96a4bfc8705_c netns $PID
ip netns exec $PID ip link set dev 1c96a4bfc8705_c name port_LOND
ip netns exec $PID ip link set port_LOND up
#ip link add 04b6d15310a35_l type veth peer name 04b6d15310a35_c
ip link set 04b6d15310a35_l up
PID=457972
create_netns_link
ip link set 04b6d15310a35_c netns $PID
ip netns exec $PID ip link set dev 04b6d15310a35_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface 1c96a4bfc8705_l ofport`
port_id2=`ovs-vsctl get Interface 04b6d15310a35_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 12a0559b28be5_l type veth peer name 12a0559b28be5_c
ip link set 12a0559b28be5_l up
PID=458114
create_netns_link
ip link set 12a0559b28be5_c netns $PID
ip netns exec $PID ip link set dev 12a0559b28be5_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
#ip link add 7daed37f1a945_l type veth peer name 7daed37f1a945_c
ip link set 7daed37f1a945_l up
PID=458338
create_netns_link
ip link set 7daed37f1a945_c netns $PID
ip netns exec $PID ip link set dev 7daed37f1a945_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface 12a0559b28be5_l ofport`
port_id2=`ovs-vsctl get Interface 7daed37f1a945_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 60b09a5226ff5_l type veth peer name 60b09a5226ff5_c
ip link set 60b09a5226ff5_l up
PID=458114
create_netns_link
ip link set 60b09a5226ff5_c netns $PID
ip netns exec $PID ip link set dev 60b09a5226ff5_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add 807c0a3dae345_l type veth peer name 807c0a3dae345_c
ip link set 807c0a3dae345_l up
PID=458733
create_netns_link
ip link set 807c0a3dae345_c netns $PID
ip netns exec $PID ip link set dev 807c0a3dae345_c name port_PARI
ip netns exec $PID ip link set port_PARI up
port_id1=`ovs-vsctl get Interface 60b09a5226ff5_l ofport`
port_id2=`ovs-vsctl get Interface 807c0a3dae345_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add a0660d49486e5_l type veth peer name a0660d49486e5_c
ip link set a0660d49486e5_l up
PID=457972
create_netns_link
ip link set a0660d49486e5_c netns $PID
ip netns exec $PID ip link set dev a0660d49486e5_c name port_BOST
ip netns exec $PID ip link set port_BOST up
#ip link add 8d2b92ab3fcf5_l type veth peer name 8d2b92ab3fcf5_c
ip link set 8d2b92ab3fcf5_l up
PID=458491
create_netns_link
ip link set 8d2b92ab3fcf5_c netns $PID
ip netns exec $PID ip link set dev 8d2b92ab3fcf5_c name port_LOND
ip netns exec $PID ip link set port_LOND up
port_id1=`ovs-vsctl get Interface a0660d49486e5_l ofport`
port_id2=`ovs-vsctl get Interface 8d2b92ab3fcf5_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 81159ed71d5d5_l type veth peer name 81159ed71d5d5_c
ip link set 81159ed71d5d5_l up
PID=457972
create_netns_link
ip link set 81159ed71d5d5_c netns $PID
ip netns exec $PID ip link set dev 81159ed71d5d5_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
#ip link add da0e18277c255_l type veth peer name da0e18277c255_c
ip link set da0e18277c255_l up
PID=458338
create_netns_link
ip link set da0e18277c255_c netns $PID
ip netns exec $PID ip link set dev da0e18277c255_c name port_LOND
ip netns exec $PID ip link set port_LOND up
port_id1=`ovs-vsctl get Interface 81159ed71d5d5_l ofport`
port_id2=`ovs-vsctl get Interface da0e18277c255_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 929c7decf89e5_l type veth peer name 929c7decf89e5_c
ip link set 929c7decf89e5_l up
PID=458259
create_netns_link
ip link set 929c7decf89e5_c netns $PID
ip netns exec $PID ip link set dev 929c7decf89e5_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add 9d90b60b92885_l type veth peer name 9d90b60b92885_c
ip link set 9d90b60b92885_l up
PID=458733
create_netns_link
ip link set 9d90b60b92885_c netns $PID
ip netns exec $PID ip link set dev 9d90b60b92885_c name port_GENE
ip netns exec $PID ip link set port_GENE up
port_id1=`ovs-vsctl get Interface 929c7decf89e5_l ofport`
port_id2=`ovs-vsctl get Interface 9d90b60b92885_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add cd4091f4e2f05_l type veth peer name cd4091f4e2f05_c
ip link set cd4091f4e2f05_l up
PID=458338
create_netns_link
ip link set cd4091f4e2f05_c netns $PID
ip netns exec $PID ip link set dev cd4091f4e2f05_c name port_BOST
ip netns exec $PID ip link set port_BOST up
#ip link add 0a89087aa5995_l type veth peer name 0a89087aa5995_c
ip link set 0a89087aa5995_l up
PID=458491
create_netns_link
ip link set 0a89087aa5995_c netns $PID
ip netns exec $PID ip link set dev 0a89087aa5995_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
port_id1=`ovs-vsctl get Interface cd4091f4e2f05_l ofport`
port_id2=`ovs-vsctl get Interface 0a89087aa5995_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 6cfe762b704b5_l type veth peer name 6cfe762b704b5_c
ip link set 6cfe762b704b5_l up
PID=458338
create_netns_link
ip link set 6cfe762b704b5_c netns $PID
ip netns exec $PID ip link set dev 6cfe762b704b5_c name port_ATLA
ip netns exec $PID ip link set port_ATLA up
#ip link add e060572a5a855_l type veth peer name e060572a5a855_c
ip link set e060572a5a855_l up
PID=458584
create_netns_link
ip link set e060572a5a855_c netns $PID
ip netns exec $PID ip link set dev e060572a5a855_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
port_id1=`ovs-vsctl get Interface 6cfe762b704b5_l ofport`
port_id2=`ovs-vsctl get Interface e060572a5a855_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 28d2b385a7845_l type veth peer name 28d2b385a7845_c
ip link set 28d2b385a7845_l up
PID=458338
create_netns_link
ip link set 28d2b385a7845_c netns $PID
ip netns exec $PID ip link set dev 28d2b385a7845_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add be4369d48e7e5_l type veth peer name be4369d48e7e5_c
ip link set be4369d48e7e5_l up
PID=458733
create_netns_link
ip link set be4369d48e7e5_c netns $PID
ip netns exec $PID ip link set dev be4369d48e7e5_c name port_NEWY
ip netns exec $PID ip link set port_NEWY up
port_id1=`ovs-vsctl get Interface 28d2b385a7845_l ofport`
port_id2=`ovs-vsctl get Interface be4369d48e7e5_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
#ip link add 23c22342dbd75_l type veth peer name 23c22342dbd75_c
ip link set 23c22342dbd75_l up
PID=458584
create_netns_link
ip link set 23c22342dbd75_c netns $PID
ip netns exec $PID ip link set dev 23c22342dbd75_c name port_MIAM
ip netns exec $PID ip link set port_MIAM up
#ip link add c6a1d6269eca5_l type veth peer name c6a1d6269eca5_c
ip link set c6a1d6269eca5_l up
PID=458733
create_netns_link
ip link set c6a1d6269eca5_c netns $PID
ip netns exec $PID ip link set dev c6a1d6269eca5_c name port_ATLA
ip netns exec $PID ip link set port_ATLA up
port_id1=`ovs-vsctl get Interface 23c22342dbd75_l ofport`
port_id2=`ovs-vsctl get Interface c6a1d6269eca5_l ofport`
ovs-ofctl add-flow int-2 in_port=$port_id1,actions=output:$port_id2
ovs-ofctl add-flow int-2 in_port=$port_id2,actions=output:$port_id1
echo "external links"
ip link set dev ext-0 up
#ip link add 6d0745e594805_l type veth peer name 6d0745e594805_c
ip link set 6d0745e594805_l up
PID=456456
create_netns_link
ip link set 6d0745e594805_c netns $PID
ip netns exec $PID ip link set dev 6d0745e594805_c name ext_2_ZURI
ip netns exec $PID ip link set ext_2_ZURI up
#ip link add 085cd7c001ea5_l type veth peer name 085cd7c001ea5_c
ip link set 085cd7c001ea5_l up
PID=458047
create_netns_link
ip link set 085cd7c001ea5_c netns $PID
ip netns exec $PID ip link set dev 085cd7c001ea5_c name ext_1_ZURI
ip netns exec $PID ip link set ext_1_ZURI up
echo "measurement links"
