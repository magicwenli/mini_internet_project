#!/bin/bash

dirname=configs_$(date +%m-%d-%Y_%H-%M-%S)
mkdir $dirname
  subnet=158.2.10.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/LOND.txt
  subnet=158.2.11.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/ZURI.txt
  subnet=158.2.12.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/PARI.txt
  subnet=158.2.13.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/GENE.txt
  subnet=158.2.14.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/NEWY.txt
  subnet=158.2.15.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/BOST.txt
  subnet=158.2.16.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/ATLA.txt
  subnet=158.2.17.1/16
  ssh -t -o StrictHostKeyChecking=no root@"${subnet%???}" -- -c 'sh run' >> $dirname/MIAM.txt
  subnet=158.2.11.2/16
  ssh -t -o StrictHostKeyChecking=no root@${subnet%???} "ovsdb-client dump" >> $dirname/CERN.txt
  subnet=158.2.11.3/16
  ssh -t -o StrictHostKeyChecking=no root@${subnet%???} "ovsdb-client dump" >> $dirname/ETHZ.txt
  subnet=158.2.11.4/16
  ssh -t -o StrictHostKeyChecking=no root@${subnet%???} "ovsdb-client dump" >> $dirname/EPFL.txt
zip ${dirname}.zip ${dirname}/*