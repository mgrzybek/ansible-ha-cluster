****************
LXD cluster role
****************

This role creates one or several LXD share-nothing containers. For each given
node, a container is created from the local storage pool.

Depending on the configuration, the containers can be:

* cloned: they run everywhere

.. code-block:: ini

  lxd_failover_mode: false

* active/passive: only one node run the container

.. code-block:: ini

  lxd_failover_mode: true
