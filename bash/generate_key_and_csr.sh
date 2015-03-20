#!/bin/bash
DOMAIN=""
 
if [ "x$1" == "x" ]; then
  DOMAIN="example.com"
else
  DOMAIN="$1"
fi
     
cd $HOME
mkdir -p $HOME/ssl
cd ssl
openssl genrsa -out ${DOMAIN}.key 4096
openssl req -new -key ${DOMAIN}.key -out ${DOMAIN}.csr
chmod 400 *.key
openssl req -noout -text -in ${DOMAIN}.csr
