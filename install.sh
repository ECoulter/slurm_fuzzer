#!/bin/bash

#This will do a few things:
#1. create 3 users, fuzz1-3.
#2. create job directories in the 3 fuzzers' homedirs.
#3. compile hpl in /usr/local/bin/

# I am assuming that wget and gcc are installed!
# would this be better as an ansible playbook?

declare -i user_count=1

for user in fuzz{1..3}
do
 if [[ -z $(getent passwd $user) ]]; then
   echo "CREATING $user!"
   adduser $user
   su - $user -c "sleep 0" #to trigger the cluster_env script
   min=$((5 + $user_count))
   echo "*/$min * * * * $user /usr/local/sbin/slurm_fuzz_cron.sh" >> /etc/crontab
   user_count=$(($user_count+1))
 fi
done

wwsh file sync # sync passwd file for compute nodes! (If not using Warewulf, modify this!)

if [[ ! -e /tmp/hpl-2.2.tar.gz ]]; then
  wget -P /tmp http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz 
  tar xfz /tmp/hpl-2.2.tar.gz 
fi

if [[ ! -e /usr/local/sbin/slurm_fuzz_cron.sh ]]; then
  cp ./slurm_fuzz_cron.sh /usr/local/sbin/slurm_fuzz_cron.sh
fi

#insert config file
#make
#cp hpl /usr/local/bin
