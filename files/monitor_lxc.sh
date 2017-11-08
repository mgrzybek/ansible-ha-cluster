#! /usr/bin/env bash

_container=$(echo $OCF_RESOURCE_INSTANCE|perl -pe 's/_lxc$//')
machinectl | grep -q $_container
