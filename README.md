# Wallet Tools

Bash scripts for creating a Bitcoin Core wallet from a mnemonic.

This allows you to use a mnemonic as wallet backup for Bitcoin Core wallets.

## Prerequisites

These scripts require Bitcoin Core >= v0.18.0 and Bitcoin Explorer >= 3.4.0. See [here](REQUIREMENTS.md) for more details.

## How it works

- Bitcoin Core allows you to create a [deterministic wallet](https://en.bitcoinwiki.org/wiki/Deterministic_wallet) from a seed
- Bitcoin Explorer allows you create such seed from a word list

This can be done with only two lines in the terminal:
```
$ echo "secret word list" | bx mnemonic-to-seed | bx hd-new | bx hd-to-ec | bx ec-to-wif
L1C5z47WPpAsckaWpiGyiM6y62UBZfu5S8imRSnAJbXib39tCKHC
$ bitcoin-cli sethdseed true "L1C5z47WPpAsckaWpiGyiM6y62UBZfu5S8imRSnAJbXib39tCKHC"
```
The scripts provide some additional convenience, but I encourage you to make yourself familiar with these commands until you feel confident enough to use them.

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
wget https://raw.githubusercontent.com/tekbe/wallet-tools/master/import-addresses.sh
chmod +x create-wallet.sh create-addresses.sh import-addresses.sh
```

## Usage

### Mnemonic

First you need to have a random list of words, a mnemonic. It's important to use a word list that is actually random in contrast to a phrase
taken from a song or out of a book, because those can be brute-forced easily. 

Here's how to create a word list with Bitcoin Explorer:
```
bx seed | bx mnemonic-new
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

#### Create and Export

In order to receive funds into this wallet you need to have btc addresses for it. 

After selecting the new wallet in bitcoin-qt you can create btc addresses there. Alternatively use this script to create as much addresses as you need.

```
create-addresses.sh <rpcuser> <rpcpassword> <wallet> 250 > btc-addresses.txt
```
This creates 250 new btc addresses for the wallet and writes them into the file `btc-addresses.txt`. 

With every run of this command new (different) addresses will be created for the given wallet.

#### Import

In order to conveniently and safely track incoming transactions for these addresses you may want to keep them without their corresponding private keys in a separate wallet. 

To do so you can import addresses from a file.
```
import-addresses.sh <rpcuser> <rpcpassword> <wallet> < btc-addresses.txt
```
If the given wallet does not exist then it will be created: a wallet without private key support that only contains the imported btc addresses. 

Select the wallet in bitcoin-qt. If incoming transactions don't show up, restart bitcoin-qt with the `-rescan` option.

### Backup

You can choose to keep the memnonic (and, if used, the seed passphrase) as the only wallet backup: Keep the sheet of paper with the mnemonic, close the wallet in bitcoin-qt and remove the wallet file with the private keys from disk. To physically delete the wallet file and preclude restoration from disk use `shred -u wallet.dat`.

With the btc addresses you generated before you are able to receive funds into this cold (paper) wallet. 

To access the funds at a later time simply re-create the wallet from the mnemonic and select it in bitcoin-qt.
If you don't see any balance after re-creating the wallet restart bitcoin-qt with the `-rescan` and `-reindex` option (this takes *a lot* of time).
Also make sure the re-created wallet is loaded on startup: by using it as default `wallet.dat` in the bitcoin core data directory or by putting the wallet file
in a subfolder and adding the option `-wallet=<subfolder>` when running bitcoin-qt.

## Disclaimer

These scripts come with absolutely no warranty whatsoever. *Use them at your own risk. You may lose all your funds*.

## License

These scripts are public domain. Use them as you see fit.

## Donations

`bc1qdlllwwv05yg242z7zft5wcr7xa778zu20k0few`
