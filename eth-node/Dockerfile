# geth client 1.8.23 (Xircus) PoA(Clique)
# --datadir /root/edu
# sealer account 0xa7e559e09acd301a75990e6b2942187ee660b2d3
# password 12345678
# example: docker build -t eth-pri:1.0 .

FROM ubuntu:xenial

MAINTAINER foo <foo@foo.com>

ENV HOME /root
ENV DATADIR /root/edu

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install Geth from PPA
RUN apt-get update \ 
      && apt-get install -y software-properties-common \
      && add-apt-repository -y ppa:ethereum/ethereum \
      && apt-get update \
      && apt-get install -y ethereum

RUN apt-get install -y git curl tree vim

RUN mkdir $HOME/edu && mkdir $HOME/shared

#
# we need genesis.json, sealer account keyfile, and sealer password
# for PoA engine

# genesis.json
COPY ./genesis.json $HOME/genesis.json

RUN geth --datadir=$DATADIR init $HOME/genesis.json

COPY ./.vimrc $HOME/.vimrc
COPY ./start.sh $HOME/start.sh

# sealer password is required for signing, i.e. mining
COPY ./pass $HOME/pass

# sealer account keyfile
# we need at least one sealer in PoA
COPY ./UTC--2019-03-08T10-04-36.282685000Z--a7e559e09acd301a75990e6b2942187ee660b2d3 $DATADIR/keystore/


CMD ["/bin/bash"]
