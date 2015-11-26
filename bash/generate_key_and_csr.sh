#!/bin/bash

# DESCRIPTION
# ===========
#
# This will create private key and CSR files in the current directory
#

CHMOD=`which chmod`
OPENSSL=`which openssl`
WGET=`which wget`

INTERMEDIATE_CERT_URL="https://www.startssl.com/certs/sub.class1.server.ca.pem"
ROOT_CERT_URL="https://www.startssl.com/certs/ca.pem"

INTERMEDIATE_CERT_FILE="startssl_intermediate.crt"
ROOT_CA_CERT_FILE="startssl_root_ca.crt"

# === DO NOT EDIT BELOW THIS LINE ===

DOMAIN=""
 
if [ "x$1" == "x" ]; then
  echo ""
  echo "Usage:"
  echo "$0 [domain.com]"
  echo ""
  exit 1
  #DOMAIN="example.com"
else
  DOMAIN="$1"
fi
     
$OPENSSL genrsa -out ${DOMAIN}.key 4096
$OPENSSL req -new -key ${DOMAIN}.key -out ${DOMAIN}.csr
$CHMOD 400 *.key
$OPENSSL req -noout -text -in ${DOMAIN}.csr

echo ""
echo "============================================================================================================================================================================================================="
echo "    Fetching Intermediate certificate and Root CA from ${INTERMEDIATE_CERT_URL} , ${ROOT_CERT_URL} ..."
echo "============================================================================================================================================================================================================="
echo ""

$WGET -O ${INTERMEDIATE_CERT_FILE} ${INTERMEDIATE_CERT_URL}
$WGET -O ${ROOT_CA_CERT_FILE} ${ROOT_CERT_URL}

echo ""
echo "   Hint: "
echo ""
echo "Now you have to concatenate the certificate with intermediate certificate and Root CA:"
echo ""
echo "cat ${DOMAIN}-vanilla.crt >> $DOMAIN.crt"
echo "cat ${INTERMEDIATE_CERT_FILE} >> $DOMAIN.crt"
echo "cat ${ROOT_CA_CERT_FILE} >> $DOMAIN.crt"
echo ""
