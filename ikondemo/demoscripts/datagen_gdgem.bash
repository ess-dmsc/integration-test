#!/bin/bash

throttle=${1:-10}

BASE=~/deployment/event-formation-unit

export LD_LIBRARY_PATH=$BASE/lib

while [[ 1 ]]
do
  #$BASE/bin/nmxgen_readouts -f /mnt/data/EFU_reference/gdgem/2018_11/readouts/a10000 -p 9001 -i 172.24.0.205 -t $throttle
  $BASE/bin/nmxgen_readouts -f /mnt/data/EFU_reference/gdgem/2019_09/readouts/run193_holepattern_1p0mmCd_20180705_095135-afonso.h5 -p 9001 -i 172.24.0.205 -t $throttle
  sleep 5
done
