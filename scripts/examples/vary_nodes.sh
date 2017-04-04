#!/bin/sh

echo -e "Varying Nodes Script Begin Execution!\n\n"
#for nodes in {27..32} 
#for nodes in {30..32} 
for nodes in {27..29} 
do
  #use sed to change number of nodes in qsub arguments
  sed -i "11s/.*/#$ -pe mpi $nodes/" run_cluster.sh
  #use sed to rename the output file of the qsub job
  sed -i "13s/.*/#$ -o vary_nodes$nodes.out/" run_cluster.sh
  #use sed to change number of nodes when executing program
  echo "First sed result"
  sed -i "21s/\^/a/" run_cluster.sh
  sed -i "21s/\//FOX/" run_cluster.sh
  echo "second sed result"
  sed -i "21s/.*/mpiexec -n $nodes --mca btl \^openib \/home\/warehouse\/cabreraam\/cse566s\/hw4\/a.out 1024 200.0 1000 0/" run_cluster.sh
  #sed -e "21s/.*/asdf/" run_cluster.sh
  nodes_minus_one=$((nodes - 1))

  echo -e "****** Using $nodes nodes ******"
  cat run_cluster.sh
  for runs in {1..30}
  do
    echo -e "Run $runs\n"
    qsub run_cluster.sh
    #sleep 30
    sleep 60
  done
  echo -e "\n\n"
done
