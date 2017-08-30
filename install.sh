#!/bin/bash

#This will do a few things:
#1. create 3 users, fuzz1-3.
#2. create job directories in the 3 fuzzers' homedirs.
#3. compile hpl in /usr/local/bin/

# I am assuming that wget and gcc are installed!
# would this be better as an ansible playbook?

for user in "fuzz1 fuzz2 fuzz3"
do
 if [[ -z $(getent passwd $user) ]]; then
   useradd $user
 fi
 if [[ ! -d /home/$user/jobs ]]; then
   mkdir /home/$user/jobs
 fi
done

wget http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz /tmp/

tar xfz /tmp/hpl-2.2.tar.gz 

cp slurm_fuzz.job /usr/local/share/

#insert config file
#make
#cp hpl /usr/local/bin
