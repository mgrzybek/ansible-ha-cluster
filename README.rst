******************
Ansible-HA-cluster
******************

Main goal
#########

This set of playbooks are used to create and manage corosync / pacemaker-based
clusters in a production environment. Some best practices are:

* several STONITH methods
* monitoring (service checks and metrics)
* log management
* firewall is enabled
* if a node fails during during the deployment, stop the playbook

Available roles
###############

cluster
*******

Installs the required packages and configures some base resources.

lxc_bootstrap
*************

Bootstraps a minimal environment and creates the libvirt configuration file:

* packaging
* monitoring
* network
* services

lxc_cluster
***********

* Creates a set of clustered filesystems to bootstrap the guest system.
* Creates the resources and groups.

lxc_local
*********

* Creates a set of local filesystems to bootstrap the guest system.
* Creates the resources and groups if pacemaker is used on the host or updates
the fstab.

system
******

* Some basic configuration artefacts are created.


Synopsis
########

The two-nodes mode
******************

This use-case is interesting when you want to host share-nothing services like
a cloned webserver or virtual adresses. The anti-split-brain method does not use
STONITH resources but a cloned pingd primitive.

The pingd service checks the availability of three peers. A pingd attribute is
updated in the CIB. If the scrore is less than 2, the resources are stopped.

You should use this mode with containers of virtual machines.

The three-and-more nodes
************************

The location constraints are based on attributes. Two roles are defined:

* The "compute" nodes are used to host the main resources. Moreover, STONITH
resources are created to stop these nodes.

* The "non-compute" nodes are used to create a cluster with an odd number of
nodes. They do not host anything and they cannot be STONITHed by the others.
This is very important to avoid any split-brain problem.

You should use this mode with physical servers.

Simple cluster deployment on virtual nodes
******************************************

First of all, you need to create the hosts list:

.. code-block:: bash

  vim simple_cluster.hosts

.. code-block:: ini

	[db-cluster-1]
	node-1.local
	node-2.local
	node-3.local

Then, write the following playbook:

.. code-block:: bash

  vim simple_cluster.yml

.. code-block:: yaml

  - hosts: all
    any_errors_fatal: true
    roles:
     - cluster
    vars:
     # Mandatory
     cluster_name: db-cluster-1
     cluster_expected_nodes: 3
     cluster_compute_nodes: 3

Finally, start the deployment:

.. code-block:: bash

	# Add your login options as needed
	$ export ansible_options="-u $USER -b become --become-user=root --become-method=sudo"
	$ ansible-playbook $ansible_options -i simple_cluster.hosts simple_cluster.yml

Check the deployment:

.. code-block:: bash

	$ ansible $ansible_options -i simple_cluster.hosts node-1 -m shell -a "crm_mon -Afr1"
