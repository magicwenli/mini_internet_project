#!/bin/bash
ovs-vsctl set bridge l2-1 other-config:forward-bpdu=true
isula exec -d 1_L2_UNIV_ETHZ ovs-vsctl add-port br0 1-CERN -- set Port 1-CERN trunks=0
isula exec -d 1_L2_UNIV_CERN ovs-vsctl add-port br0 1-ETHZ -- set Port 1-ETHZ trunks=0
isula exec -d 1_L2_UNIV_ETHZ ovs-vsctl add-port br0 1-EPFL -- set Port 1-EPFL trunks=0
isula exec -d 1_L2_UNIV_EPFL ovs-vsctl add-port br0 1-ETHZ -- set Port 1-ETHZ trunks=0
isula exec -d 1_L2_UNIV_CERN ovs-vsctl add-port br0 1-EPFL -- set Port 1-EPFL trunks=0
isula exec -d 1_L2_UNIV_EPFL ovs-vsctl add-port br0 1-CERN -- set Port 1-CERN trunks=0
isula exec -d 1_L2_UNIV_CERN ovs-vsctl add-port br0 1-student-1
isula exec -d 1_L2_UNIV_CERN ovs-vsctl add-port br0 1-staff-1
isula exec -d 1_L2_UNIV_ETHZ ovs-vsctl add-port br0 1-student-2
isula exec -d 1_L2_UNIV_ETHZ ovs-vsctl add-port br0 1-staff-2
isula exec -d 1_L2_UNIV_EPFL ovs-vsctl add-port br0 1-student-3
isula exec -d 1_L2_UNIV_EPFL ovs-vsctl add-port br0 1-staff-3
isula exec -d 1_L2_UNIV_ETHZ ovs-vsctl add-port br0 ZURIrouter
isula exec -d 1_L2_UNIV_CERN ovs-vsctl add-port br0 GENErouter
ovs-vsctl set bridge l2-2 other-config:forward-bpdu=true
isula exec -d 2_L2_UNIV_ETHZ ovs-vsctl add-port br0 2-CERN -- set Port 2-CERN trunks=0
isula exec -d 2_L2_UNIV_CERN ovs-vsctl add-port br0 2-ETHZ -- set Port 2-ETHZ trunks=0
isula exec -d 2_L2_UNIV_ETHZ ovs-vsctl add-port br0 2-EPFL -- set Port 2-EPFL trunks=0
isula exec -d 2_L2_UNIV_EPFL ovs-vsctl add-port br0 2-ETHZ -- set Port 2-ETHZ trunks=0
isula exec -d 2_L2_UNIV_CERN ovs-vsctl add-port br0 2-EPFL -- set Port 2-EPFL trunks=0
isula exec -d 2_L2_UNIV_EPFL ovs-vsctl add-port br0 2-CERN -- set Port 2-CERN trunks=0
isula exec -d 2_L2_UNIV_CERN ovs-vsctl add-port br0 2-student-1
isula exec -d 2_L2_UNIV_CERN ovs-vsctl add-port br0 2-staff-1
isula exec -d 2_L2_UNIV_ETHZ ovs-vsctl add-port br0 2-student-2
isula exec -d 2_L2_UNIV_ETHZ ovs-vsctl add-port br0 2-staff-2
isula exec -d 2_L2_UNIV_EPFL ovs-vsctl add-port br0 2-student-3
isula exec -d 2_L2_UNIV_EPFL ovs-vsctl add-port br0 2-staff-3
isula exec -d 2_L2_UNIV_ETHZ ovs-vsctl add-port br0 ZURIrouter
isula exec -d 2_L2_UNIV_CERN ovs-vsctl add-port br0 GENErouter
