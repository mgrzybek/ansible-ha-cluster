#! /usr/bin/env bash

slice=/sys/fs/cgroup/cpuset/machine.slice

crm_cpus=$(/usr/sbin/crm node utilization $HOSTNAME show cpu|perl -ne '/value=(\d+)$/ && print $1')

server_cpus=$(grep -c ^proc /proc/cpuinfo)
server_cpus=$((server_cpus-1))

first_allowed_cpu=$(echo $server_cpus - $crm_cpus |bc)

/usr/bin/cluster_set_cpuset -p $slice -e -s "${first_allowed_cpu}-${server_cpus}"

if [ $? -eq 0 ] ; then
	echo "Set cpu_cpus and cpu_exclusive... OK"
else
	echo "Set cpu_cpus and cpu_exclusive... FAILED"
	exit 1
fi

exit 0
