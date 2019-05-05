# Prerequisites

## Bitcoin Explorer

Download and install [Bitcoin Explorer](https://github.com/libbitcoin/libbitcoin-explorer/wiki/Download-BX).

Make sure `bx` is in the path.

```
bx help
```
```
Usage: bx COMMAND [--help]

Version: 3.4.0

Info: The bx commands are:

address-decode
address-embed
...
```

One way of achieving this is by adding the following line to `~/.bashrc`:

```
export PATH=/path/to/bx/bin:$PATH
```

## Bitcoin Core

Download and install [Bitcoin Core](https://bitcoincore.org/en/download/).

Make sure `bitcoin-cli` is in the path.

```
bitcoin-cli -version
```
```
Bitcoin Core RPC client version v0.18.0
```

Make sure bitcoin core runs and accepts wallet API calls.
```
bitcoin-cli -rpcuser=RPCUSER -rpcpassword=RPCPASSWORD listwallets
```
```
[
  ""
]
```

One way of achieving this is by starting `bitcoin-qt` with these options:
```bash
bitcoin-qt -rpcuser=RPCUSER -rpcpassword=RPCPASSWORD -server &
```


