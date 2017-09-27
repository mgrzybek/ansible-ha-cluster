#! /usr/bin/env bash

_status=$(systemctl status pacemaker_remote.service |grep Loaded:)

if [[ $(echo $_status | fgrep -c enabled) -ne 1 ]] ; then
	echo "$_status"
	exit 0
fi

_status=$(systemctl status pacemaker_remote.service |grep Active:)

if [[ $(echo $_status | fgrep -c running) -ne 1 ]] ; then
	echo "$_status"
	exit 1
fi

exit $?
