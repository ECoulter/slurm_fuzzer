# SLURM Fuzzer

Simple set of scripts to generate job data on a slurm scheduler.
Could possibly be used to 'stress test' a cluster, if given a
sufficiently high number of jobs. (In a somewhat more interesting
way than just HPL.)

# Basic Assumptions

1. That three different users submitting jobs will be sufficiently useful
2. That you will have three users: fuzz1,fuzz2.fuzz3. 
3. For *now*, this only deals in a single queue. 
4. Max walltime, Number of Nodes, etc. will be retrieved from /etc/slurm/slurm.conf
5. Options for job types:
 - time-wasting (sleep $rand)
 - resource-wasting (hpl!) 
 -- hpl parameters are not yet fuzzed. This *might* be interesting, though.
