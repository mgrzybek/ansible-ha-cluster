***********
System role
***********

This role is used to manage the hosting servers before installing corosync /
pacemaker.

Packaging
#########

Deals with apt / zypper / pkg.

Metrics
#######

Configuration for telegraf:

* system
* network
* cgroups
* sensors / IPMI (physical node only)

Monitoring
##########

Configuration of Consul:

* TODO

Configuration of NRPE:

* running sshd
* running auditd
* check available updates

Networking
##########

Configuration of OVS and interfaces:

* bondings
* VLANS
