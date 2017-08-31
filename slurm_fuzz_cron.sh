#!/bin/bash

# example rand int 00-99
declare -i myrand=$(cat /dev/urandom | tr -dc '0-9' | fold -w 2 | head -n 1 | sed 's/^0//')
# (how does the shell handle catting only a certain amount from
#  /dev/urandom?) - 
#  echo '#!/bin/bash \n cat /dev/urandom | tr -dc '0-9' | fold -w 2 | head -n 1' > run_rand.sh 
#  chmod u+x run_rand.sh 
#  strace -f -o rand_out.txt ./run_rand.sh 

declare -i job_probability=50
declare -i max_nodes=2

num_nodes=$((1 + $RANDOM % $max_nodes))
sleep_num=$((1 + $RANDOM % 3600))

if [[ $myrand < $job_probability ]]; then
 #DO run a job this time
 echo -e "#!bin/bash \n#SBATCH -N $num_nodes \n#SBATCH -o fuzz.out \nsrun -l hostname \nsrun sleep $sleep_num" > /tmp/slurm_fuzz.job
 sbatch /tmp/slurm_fuzz.job 
# rm /tmp/slurm_fuzz.job
 exit
fi 
