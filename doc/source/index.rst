===================================
High availability Ansible role
===================================

.. toctree::
   :maxdepth: 2

   configure-rings.rst
   configure-management.rst

To clone or view the source code for this repository, visit the role repository
for `ansible-ha-cluster <https://github.com/mgrzybek/ansible-ha-cluster>`_.

Default variables
~~~~~~~~~~~~~~~~~

.. literalinclude:: ../../defaults/main.yml
   :language: yaml
   :start-after: under the License.


Required variables
~~~~~~~~~~~~~~~~~~

This list is not exhaustive at present. See role internals for further
details.

.. code-block:: yaml

    # name of the corosync stack as shown using crm status
    cluster_name: my-cluster

    # network port to use for corosync communication
    cluster_ring0_port: eth0
    cluster_ring1_port: eth1

    # number of expected cluster members when the nodes are running fine
    cluster_expected_votes: 3

Example playbook
~~~~~~~~~~~~~~~~

.. literalinclude:: ../../examples/playbook.yml
   :language: yaml

External Restart Hooks
~~~~~~~~~~~~~~~~~~~~~~

None

Tags
~~~~

The ``cluster-install`` tag can be used to install corosync.

The ``cluster_mgmt_ip_addr`` tag can be used to maintain configuration of the management IP address.

The ``cluster-crm-scripts`` tag can be used to maintain nodes' attributes.

The ``cluster-mgmt-hawk`` tag can be used to install Hawk WebGUI on SUSE systems.

The ``cluster-mgmt-ip-addr`` tag can used to configure a floating management IP address.

The ``cluster-attributes`` tag can used to maintain the nodes' cluster_role attribute.

The ``cluster-corosync`` tag can used to configure corosync.

The ``cluster-crm-scripts`` tag can used to install some crm script used to manage resources.

The ``cluster-stonith`` tag can used to install and maintain STONITH devices (IPMI and SBD).
