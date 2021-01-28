#!/bin/bash
tc qdisc add dev 8b47f22f749e5_l root netem delay 1000 
echo -n " -- set interface 8b47f22f749e5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 34747abce97c5_l root netem delay 1000 
echo -n " -- set interface 34747abce97c5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev b4669d5438e45_l root netem delay 1000 
echo -n " -- set interface b4669d5438e45_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev c573b88be4855_l root netem delay 1000 
echo -n " -- set interface c573b88be4855_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 9dfea811e72a5_l root netem delay 1000 
echo -n " -- set interface 9dfea811e72a5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 1f336da0e4e95_l root netem delay 1000 
echo -n " -- set interface 1f336da0e4e95_l ingress_policing_rate=10000 " >> groups/throughput.sh 
echo -n " -- set interface tap_g1_vpn-1 ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev tap_g1_vpn-1 root netem delay 1000 
tc qdisc add dev 678412fc9c435_l root netem delay 1000 
echo -n " -- set interface 678412fc9c435_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev cd24433aea185_l root netem delay 1000 
echo -n " -- set interface cd24433aea185_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 54e1a20a25295_l root netem delay 1000 
echo -n " -- set interface 54e1a20a25295_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev f034ca4802985_l root netem delay 1000 
echo -n " -- set interface f034ca4802985_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 7d4d0b12ef895_l root netem delay 1000 
echo -n " -- set interface 7d4d0b12ef895_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 54cd9a328f405_l root netem delay 1000 
echo -n " -- set interface 54cd9a328f405_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev e4f4630af3725_l root netem delay 1000 
echo -n " -- set interface e4f4630af3725_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 90251347b18b5_l root netem delay 1000 
echo -n " -- set interface 90251347b18b5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 403bd02b92005_l root netem delay 1000 
echo -n " -- set interface 403bd02b92005_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 392c9e7407f85_l root netem delay 1000 
echo -n " -- set interface 392c9e7407f85_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 9106141effe15_l root netem delay 1000 
echo -n " -- set interface 9106141effe15_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev ebff9b083bbd5_l root netem delay 1000 
echo -n " -- set interface ebff9b083bbd5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
echo -n " -- set interface tap_g1_vpn-3 ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev tap_g1_vpn-3 root netem delay 1000 
tc qdisc add dev cc21683f7e265_l root netem delay 1000 
echo -n " -- set interface cc21683f7e265_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev c1b2bc185ac15_l root netem delay 1000 
echo -n " -- set interface c1b2bc185ac15_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 3fca714f72cf5_l root netem delay 1000 
echo -n " -- set interface 3fca714f72cf5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev e1837048f81f5_l root netem delay 1000 
echo -n " -- set interface e1837048f81f5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev e882d64b2a6e5_l root netem delay 1000 
echo -n " -- set interface e882d64b2a6e5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 815c35d2df415_l root netem delay 1000 
echo -n " -- set interface 815c35d2df415_l ingress_policing_rate=10000 " >> groups/throughput.sh 
echo -n " -- set interface tap_g2_vpn-1 ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev tap_g2_vpn-1 root netem delay 1000 
tc qdisc add dev 112b35cd3c3a5_l root netem delay 1000 
echo -n " -- set interface 112b35cd3c3a5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 3fa562e686e45_l root netem delay 1000 
echo -n " -- set interface 3fa562e686e45_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev de3d6e5bb8ae5_l root netem delay 1000 
echo -n " -- set interface de3d6e5bb8ae5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev cb5fff76ff925_l root netem delay 1000 
echo -n " -- set interface cb5fff76ff925_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev a7f5ad2b16eb5_l root netem delay 1000 
echo -n " -- set interface a7f5ad2b16eb5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 484efdf909e45_l root netem delay 1000 
echo -n " -- set interface 484efdf909e45_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev e7e2185aa5345_l root netem delay 1000 
echo -n " -- set interface e7e2185aa5345_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 5273a31aff8a5_l root netem delay 1000 
echo -n " -- set interface 5273a31aff8a5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 221d3acdcd3c5_l root netem delay 1000 
echo -n " -- set interface 221d3acdcd3c5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 26b86114725d5_l root netem delay 1000 
echo -n " -- set interface 26b86114725d5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 180143d5a1a05_l root netem delay 1000 
echo -n " -- set interface 180143d5a1a05_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev cb59f97af79e5_l root netem delay 1000 
echo -n " -- set interface cb59f97af79e5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
echo -n " -- set interface tap_g2_vpn-3 ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev tap_g2_vpn-3 root netem delay 1000 
tc qdisc add dev 57f7628155a65_l root netem delay 100 
echo -n " -- set interface 57f7628155a65_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 2d0661670ed85_l root netem delay 100 
echo -n " -- set interface 2d0661670ed85_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev d8b4f41fd1045_l root netem delay 1000 
echo -n " -- set interface d8b4f41fd1045_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev c62bc80903ee5_l root netem delay 1000 
echo -n " -- set interface c62bc80903ee5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 3692691c63395_l root netem delay 20 
echo -n " -- set interface 3692691c63395_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev cb26dd7d45a35_l root netem delay 20 
echo -n " -- set interface cb26dd7d45a35_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev f82e2fadd1a45_l root netem delay 20 
echo -n " -- set interface f82e2fadd1a45_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev ac50c6e5f3245_l root netem delay 20 
echo -n " -- set interface ac50c6e5f3245_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 50df403685995_l root netem delay 1000 
echo -n " -- set interface 50df403685995_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 4fc4efe9fc665_l root netem delay 1000 
echo -n " -- set interface 4fc4efe9fc665_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev ad3f31b490fa5_l root netem delay 50 
echo -n " -- set interface ad3f31b490fa5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 4f7e8d7f5ccc5_l root netem delay 50 
echo -n " -- set interface 4f7e8d7f5ccc5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev cd7ebf6ece3d5_l root netem delay 10000 
echo -n " -- set interface cd7ebf6ece3d5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 119ded19b4de5_l root netem delay 10000 
echo -n " -- set interface 119ded19b4de5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 3891ca77504b5_l root netem delay 100 
echo -n " -- set interface 3891ca77504b5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev db797f923d8c5_l root netem delay 100 
echo -n " -- set interface db797f923d8c5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 0ed10f73231e5_l root netem delay 100 
echo -n " -- set interface 0ed10f73231e5_l ingress_policing_rate=1000 " >> groups/throughput.sh 
tc qdisc add dev fab839ff790f5_l root netem delay 100 
echo -n " -- set interface fab839ff790f5_l ingress_policing_rate=1000 " >> groups/throughput.sh 
tc qdisc add dev 8a2ab342b0485_l root netem delay 10 
echo -n " -- set interface 8a2ab342b0485_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev c70b35236ac55_l root netem delay 10 
echo -n " -- set interface c70b35236ac55_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 3a81517af39d5_l root netem delay 100 
echo -n " -- set interface 3a81517af39d5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev f0dfc83646755_l root netem delay 100 
echo -n " -- set interface f0dfc83646755_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 89ac4c17b95c5_l root netem delay 10 
echo -n " -- set interface 89ac4c17b95c5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 695b257b5db65_l root netem delay 10 
echo -n " -- set interface 695b257b5db65_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 1f14aa3219f45_l root netem delay 100 
echo -n " -- set interface 1f14aa3219f45_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 47d7221f8c905_l root netem delay 100 
echo -n " -- set interface 47d7221f8c905_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 346917b814d35_l root netem delay 100 
echo -n " -- set interface 346917b814d35_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 95519b49b05c5_l root netem delay 100 
echo -n " -- set interface 95519b49b05c5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 7c453dae95265_l root netem delay 1000 
echo -n " -- set interface 7c453dae95265_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 48c3c0893c095_l root netem delay 1000 
echo -n " -- set interface 48c3c0893c095_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev b9ca6db45e665_l root netem delay 20 
echo -n " -- set interface b9ca6db45e665_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev c762cdaef08b5_l root netem delay 20 
echo -n " -- set interface c762cdaef08b5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 1c96a4bfc8705_l root netem delay 20 
echo -n " -- set interface 1c96a4bfc8705_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 04b6d15310a35_l root netem delay 20 
echo -n " -- set interface 04b6d15310a35_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 12a0559b28be5_l root netem delay 1000 
echo -n " -- set interface 12a0559b28be5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 7daed37f1a945_l root netem delay 1000 
echo -n " -- set interface 7daed37f1a945_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 60b09a5226ff5_l root netem delay 50 
echo -n " -- set interface 60b09a5226ff5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 807c0a3dae345_l root netem delay 50 
echo -n " -- set interface 807c0a3dae345_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev a0660d49486e5_l root netem delay 10000 
echo -n " -- set interface a0660d49486e5_l ingress_policing_rate=1000 " >> groups/throughput.sh 
tc qdisc add dev 8d2b92ab3fcf5_l root netem delay 10000 
echo -n " -- set interface 8d2b92ab3fcf5_l ingress_policing_rate=1000 " >> groups/throughput.sh 
tc qdisc add dev 81159ed71d5d5_l root netem delay 100 
echo -n " -- set interface 81159ed71d5d5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev da0e18277c255_l root netem delay 100 
echo -n " -- set interface da0e18277c255_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 929c7decf89e5_l root netem delay 100 
echo -n " -- set interface 929c7decf89e5_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev 9d90b60b92885_l root netem delay 100 
echo -n " -- set interface 9d90b60b92885_l ingress_policing_rate=10000 " >> groups/throughput.sh 
tc qdisc add dev cd4091f4e2f05_l root netem delay 10 
echo -n " -- set interface cd4091f4e2f05_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 0a89087aa5995_l root netem delay 10 
echo -n " -- set interface 0a89087aa5995_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 6cfe762b704b5_l root netem delay 100 
echo -n " -- set interface 6cfe762b704b5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev e060572a5a855_l root netem delay 100 
echo -n " -- set interface e060572a5a855_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 28d2b385a7845_l root netem delay 10 
echo -n " -- set interface 28d2b385a7845_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev be4369d48e7e5_l root netem delay 10 
echo -n " -- set interface be4369d48e7e5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 23c22342dbd75_l root netem delay 100 
echo -n " -- set interface 23c22342dbd75_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev c6a1d6269eca5_l root netem delay 100 
echo -n " -- set interface c6a1d6269eca5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 6d0745e594805_l root netem delay 1000 
echo -n " -- set interface 6d0745e594805_l ingress_policing_rate=100000 " >> groups/throughput.sh 
tc qdisc add dev 085cd7c001ea5_l root netem delay 1000 
echo -n " -- set interface 085cd7c001ea5_l ingress_policing_rate=100000 " >> groups/throughput.sh 
