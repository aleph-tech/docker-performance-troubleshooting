#!/bin/bash

#
# cst.sh	get packet statistics for a docker container.
# 		requires root or sudo to run nsenter.
# parameters:	container name, sleep time in secs.
# Notes:	leverages the ss command.
#		may be interesting to add -r to resolve IP's


if [ ! $# -eq 2 ]
then
  echo "Usage: cst.sh <container name> <delay in seconds>"
  exit
fi
cname=`docker ps -f "name=$1" --format "{{.Names}}"`
cpid=`docker inspect --format '{{.State.Pid}}' "$cname"`
while :
do
  nsenter -t $cpid -n ss -tan
  sleep $2
done


