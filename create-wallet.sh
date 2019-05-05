#!/bin/bash

set -e

if [ "$#" -ne 3 ]; then
  echo "Usage: create-wallet.sh <rpcuser> <rpcpassword> <wallet>"
  exit 1
fi

USER=$1
PW=$2
WALLET=$3

echo "Enter mnemonic (number of words must be divisible by 3):"
read MNEMONIC

read -n1 -p "Use additional passphrase for creating the seed? [y/N]" response
echo

SEEDPW=""
SEEDPW2="X"
case $response in [yY][eE][sS]|[yY]|[jJ])
  while [ "$SEEDPW" != "$SEEDPW2" -o -z "$SEEDPW" ]; do
    read -p "Enter seed passphrase: " -s SEEDPW
    echo
    read -p "Re-enter seed passphrase: " -s SEEDPW2
    echo
  done
esac

echo "Create hd seed..."
HDSEED=$(echo $MNEMONIC | bx mnemonic-to-seed -p "$SEEDPW" | bx hd-new | bx hd-to-ec | bx ec-to-wif)

WALLETPW=""
WALLETPW2="X"
while [ "$WALLETPW" != "$WALLETPW2" -o -z "$WALLETPW" ]; do
  read -p "Enter wallet passphrase: " -s WALLETPW
  echo
  read -p "Re-enter wallet passphrase: " -s WALLETPW2
  echo
done

echo "Create wallet $WALLET..."
bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" createwallet "$WALLET" false true > /dev/null
echo "Encrypt wallet..."
bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" -rpcwallet="$WALLET" encryptwallet "$WALLETPW" > /dev/null
echo "Unlock wallet..."
bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" -rpcwallet="$WALLET" walletpassphrase "$WALLETPW" 120
echo "Set hd seed..."
bitcoin-cli -rpcuser=$USER -rpcpassword=$PW -rpcwallet="$WALLET" sethdseed true "$HDSEED"
echo "Lock wallet..."
bitcoin-cli -rpcuser="$USER" -rpcpassword="$PW" -rpcwallet="$WALLET" walletlock

echo "Done."
