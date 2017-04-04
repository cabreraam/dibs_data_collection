#!/bin/bash

module add cse566

#EULERRUN

for p_size in {8..11} 
do
  #change the line 444 in modeldata.cpp using sed
  p_size_curr=$(echo 2 $p_size | awk '{printf "%d\n",$1^$2}')
  #change output filename
  sed -i "13s/.*/#$ -o optimize$p_size_curr.out/" run_cluster.sh
  echo $p_size_curr

  sed -i "21s/.*/mpiexec -n 8 --mca btl \^openib \/home\/warehouse\/cabreraam\/cse566s\/hw4_clean\/hw4\/a.out $p_size_curr 200.0 1000 0/" run_cluster.sh

  #sed -i "444s/.*/return $s_rad_curr * pow ( gmin,0.333 ) *pow ( tstep,0.667 ) ;/" modeldata.cpp
  make
  #for 10 runs
  for run in {1..10}
  do
    echo "run $run"
    #submit job
    qsub run_cluster.sh
    #sleep
    sleep 15 
  done

  rm cabrera*

done

mkdir outputs_euler
mv optimize*.out ./outputs_euler/
