#!/bin/bash

set -e

if [ "$#" -lt 3 ]; then
  echo "Usage: create-addresses.sh <rpcuser> <rpcpassword> <wallet> <number> (optional, default: 100)"
  exit 1
fi

USER=$1
PW=$2
WALLET=$3

# make sure wallet is loaded
bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" loadwallet "$WALLET" >/dev/null 2>&1 || true

if [ "$#" -ge 4 ]; then
  ADDRCNT="$4"
else
  ADDRCNT=100
fi

for (( i = 0; i < ADDRCNT; i++ )); do
  bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" -rpcwallet="$WALLET" getnewaddress "" bech32
done
