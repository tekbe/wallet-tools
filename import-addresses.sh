#!/bin/bash

set -e

if [ "$#" -lt 3 ]; then
  echo "Usage: import-addresses.sh <rpcuser> <rpcpassword> <wallet>"
  exit 1
fi

USER=$1
PW=$2
WALLET=$3

# make sure wallet exists and is loaded
bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" createwallet "$WALLET" true true >/dev/null 2>&1 || true
bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" loadwallet "$WALLET" >/dev/null 2>&1 || true

echo "Import addresses into ${WALLET}..."

while read ADDRESS; do
  bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" -rpcwallet="$WALLET" importaddress "$ADDRESS" "" false false
done

echo "Done."
