#!/bin/bash
location=$1
device=$2

if [ "${location}" == "LOND" ] && [ "${device}" == "host" ]; then
	subnet=158.2.10.2/16
	ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
	exit
fi
if [ "${location}" == "LOND" ] && [ "${device}" == "router" ]; then
  subnet=158.2.10.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "ZURI" ] && [ "${device}" == "router" ]; then
  subnet=158.2.11.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "PARI" ] && [ "${device}" == "host" ]; then
	subnet=158.2.12.2/16
	ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
	exit
fi
if [ "${location}" == "PARI" ] && [ "${device}" == "router" ]; then
  subnet=158.2.12.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "GENE" ] && [ "${device}" == "router" ]; then
  subnet=158.2.13.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "NEWY" ] && [ "${device}" == "host" ]; then
	subnet=158.2.14.2/16
	ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
	exit
fi
if [ "${location}" == "NEWY" ] && [ "${device}" == "router" ]; then
  subnet=158.2.14.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "BOST" ] && [ "${device}" == "host" ]; then
	subnet=158.2.15.2/16
	ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
	exit
fi
if [ "${location}" == "BOST" ] && [ "${device}" == "router" ]; then
  subnet=158.2.15.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "ATLA" ] && [ "${device}" == "host" ]; then
	subnet=158.2.16.2/16
	ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
	exit
fi
if [ "${location}" == "ATLA" ] && [ "${device}" == "router" ]; then
  subnet=158.2.16.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "MIAM" ] && [ "${device}" == "host" ]; then
	subnet=158.2.17.2/16
	ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
	exit
fi
if [ "${location}" == "MIAM" ] && [ "${device}" == "router" ]; then
  subnet=158.2.17.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "CERN" ]; then
  subnet=158.2.11.2/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "ETHZ" ]; then
  subnet=158.2.11.3/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "EPFL" ]; then
  subnet=158.2.11.4/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "student-1" ]; then
  subnet=158.2.11.5/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "staff-1" ]; then
  subnet=158.2.11.6/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "student-2" ]; then
  subnet=158.2.11.7/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "staff-2" ]; then
  subnet=158.2.11.8/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "student-3" ]; then
  subnet=158.2.11.9/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
if [ "${location}" == "UNIV" ] && [ "${device}" == "staff-3" ]; then
  subnet=158.2.11.10/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}"
  exit
fi
echo "invalid arguments"
echo "valid examples:"
echo "./goto.sh MIAM router"
echo "./goto.sh MIAM host"
echo "./goto.sh UNIV EPFL"
echo "./goto.sh UNIV staff-3"
