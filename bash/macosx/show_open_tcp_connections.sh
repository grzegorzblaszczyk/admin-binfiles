#!/bin/bash

GREP=`which grep`
NETSTAT=`which netstat`
SLEEP=`which sleep`

function print_usage() {
  echo ""
  echo "Usage:"
  echo "$0 [interval_in_seconds]"
  exit 1;
}

# Input params:
#   WAIT_INTERVAL 
#   grep executable
#   netstat executable
#   sleep executable

function show_tcp_connections() {
  WAIT_INTERVAL=$1
  GREP=$2
  NETSTAT=$3
  SLEEP=$4

  while [ 1==1 ]; do 
    $NETSTAT -n -p tcp | $GREP -v "localhost\|127\.0\.0\.1"; 
    $SLEEP $WAIT_INTERVAL; 
  done
}

if [ "$1x" == "x" ]; then
  print_usage;
  exit 1;
fi

WAIT=$1

show_tcp_connections $WAIT $GREP $NETSTAT $SLEEP

