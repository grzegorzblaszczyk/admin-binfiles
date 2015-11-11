#!/bin/bash

# DESCRIPTION
# ===========
#
# This will create private key and CSR files in the current directory
#

CHMOD=`which chmod`
OPENSSL=`which openssl`

# === DO NOT EDIT BELOW THIS LINE ===

DOMAIN=""
 
if [ "x$1" == "x" ]; then
  DOMAIN="example.com"
else
  DOMAIN="$1"
fi
     
$OPENSSL genrsa -out ${DOMAIN}.key 4096
$OPENSSL req -new -key ${DOMAIN}.key -out ${DOMAIN}.csr
$CHMOD 400 *.key
$OPENSSL req -noout -text -in ${DOMAIN}.csr
