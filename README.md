ansible-ha-cluster
==================

This role is used to create and manage corosync / pacemaker-based clusters.

Requirements
------------

When SLES is used, the sle-ha extension repository is needed.
Centos/Redhat support is in progress:
* the stonith devices are not integrated yet.

When using IPMI STONITH, BMC IP address and credentials are needed. Each host needs these values in ```host_vars/my-node.yml```:

    ---

    ilo:
      address: x.x.x.x
      login: admin
      password: secret

Role Variables
--------------

By default, the role configures corosync to use the main network device of the
server. This can be changed using ```cluster_ring0_port``` and ```cluster_ring1_port```.

Dependencies
------------

This is a standalone role.

Example Playbook
----------------

This is a simple example, the only mandatory variable is ```cluster_expected_votes``` (making this value dynamic can be dangerous).

    - name: Installation and setup of corosync / pacemaker
      hosts: all
      user: root
      roles:
        - { role: "ansible-ha-cluster" }
      vars:
        # Mandatory
        cluster_expected_votes: 5

Openstack-Ansible use case:

* the group inventory is persisent, that is why we can set ```cluster_expected_votes``` to a dynamic value ;

* the cluster's name is set thanks to ```cluster_name``` ;

* we deploy the cluster on the physical nodes hosting the control plane and we set the group's name using ```cluster_role``` ;

* the ethernet adapters to use with corosync are set by ```cluster_ring0_port``` and ```cluster_ring1_port```.

The playbok looks like:

    - name: Installation and setup of corosync / pacemaker
      hosts: compute-infra_hosts
      user: root
      roles:
        - { role: "ansible-ha-cluster" }
      vars:
        # Mandatory
        cluster_expected_votes: "{{ groups['compute-infra_hosts'] | length }}"
        # Optionnal
        cluster_name: openstack
        cluster_node_attribute_key: cluster_role
        cluster_node_attribute_value: infra_hosts
        cluster_ring0_port: br-mgmt
        cluster_ring1_port: br-vxlan

License
-------

GPL-3+

Author Information
------------------

Mathieu GRZYBEK
