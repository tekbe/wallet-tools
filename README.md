# Wallet Tools

Bash scripts for creating a Bitcoin Core wallet from a mnemonic.

This allows you to use a mnemonic as wallet backup for Bitcoin Core wallets.

## Prerequisites

These scripts require Bitcoin Core >= v0.18.0 and Bitcoin Explorer >= 3.4.0. See [here](REQUIREMENTS.md) for more details.

## Install

Make sure you've got a local `bin` folder for executables.

```
mkdir ~/bin 2> /dev/null && bash -l
```

Download the scripts into the `bin` folder and make them executable.

```
cd ~/bin
wget https://raw.githubusercontent.com/tekbe/wallet-tools/master/create-wallet.sh
wget https://raw.githubusercontent.com/tekbe/wallet-tools/master/create-addresses.sh
chmod +x create-wallet.sh create-addresses.sh
```

## Usage

### Mnemonic

First you need to have a random list of words, a mnemonic. It's important to use a word list that is actually random in contrast to a phrase
taken from a song or out of a book, because those can be brute-forced easily. 

Tools to create random word lists are for example Bitcoin Explorer or Diceware (install with `sudo apt install diceware` on Ubuntu).
```
bx seed | bx mnemonic-new
```
```
diceware -n 18 -d " " --no-caps
```
The number of words should be 12 or more and must be divisible by 3. The words are case sensitive (best to use strictly lower case for simplicity) and their order is significant.

Once you have created your own secret list of words, write them down on paper (not on your computer) and keep them safe. 

### Wallet

Use this script to create a Bitcoin Core wallet from a mnemonic.

```
create-wallet.sh <rpcuser> <rpcpassword> <wallet>
```

You will be asked to enter the mnemonic.

```
Enter mnemonic (number of words must be divisible by 3):
```

And you can choose if you want to use a seed passphrase as a second factor to create the Bitcoin Core wallet (the first factor is the mnemonic that you can write down, the second factor is the passphrase that you must remember).
```
Use additional passphrase for creating the seed? [y/N]
```

Finally you will be asked to specify the passphrase to encrypt the wallet.
```
Enter wallet passphrase:
```
```
Create wallet <wallet>...
Encrypt wallet...
Unlock wallet...
Set hd seed...
Lock wallet...
Done.
```
The new wallet is now created, encrypted and set up with the hd seed derived from the mnemonic.

### Addresses

In order to receive funds into this wallet you need to have btc addresses for it. 

After selecting the new wallet in bitcoin-qt you can create btc addresses there. Alternatively use this script to create as much addresses as you need.

```
create-addresses.sh <rpcuser> <rpcpassword> <wallet> 250 > btc-addresses.txt
```
This creates 250 new btc addresses for the given wallet and writes them into the file `btc-addresses.txt`.

### Backup

You can choose to keep the memnonic (and, if used, the seed passphrase) as the only wallet backup: Keep the sheet of paper with the mnemonic,
close the wallet in bitcoin-qt and remove the wallet file with the private keys from disk.

With the addresses you generated before you are be able to receive funds into this cold (paper) wallet.

To access the funds at a later time
simply re-create the wallet with the mnemonic and select it in bitcoin-qt.

## Disclaimer

These scripts come with absolutely no warranty whatsoever. *Use them at your own risk. You may lose all your funds*.

## License

These scripts are public domain. Use them as you see fit.

## TODO

- Provide/extend script to import addresses into a readonly wallet (without private keys) in order to be able to track incoming funds.

