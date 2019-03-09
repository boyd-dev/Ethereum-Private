#!/bin/sh

DATADIR=/root/edu
NETWORKID=337
ENODE=enode://51299e41f1e1a2de21e94a2f185a1e71eabadc0b8e7a873421ddd69119d5c4e246d099f64cfee2349c1dc49ad8ba50f03f73d918dc4aa5d7e1718a5ffba6033b@172.17.0.3:30301
SEALER=a7e559e09acd301a75990e6b2942187ee660b2d3
PWDFILE=pass

geth --networkid $NETWORKID  --datadir $DATADIR --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --bootnodes $ENODE --unlock $SEALER --password $PWDFILE --mine --minerthreads=1 
