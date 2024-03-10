#!/bin/bash

source ./install/util.sh

NEOVIM_VERSION=${1:-"v0.9.5"}

NEOVIM_FILE="nvim-linux64.tar.gz"
NEOVIM_FILE_SHA256SUM="nvim-linux64.tar.gz.sha256sum"

NEOVIM_URL="https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}"

echo "Initiating neovim $NEOVIM_VERSION installation..."

curl -L $NEOVIM_URL/$NEOVIM_FILE -o ./download/$NEOVIM_FILE

curl -L $NEOVIM_URL/$NEOVIM_FILE_SHA256SUM -o ./download/$NEOVIM_FILE_SHA256SUM

if SHA256SUM_ISVALID $NEOVIM_FILE $NEOVIM_FILE_SHA256SUM ;then
    rm -rf /opt/nvim
    
    tar -C /opt -xzf ./download/$NEOVIM_FILE
    
    echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> /etc/skel/.bashrc
    echo 'alias vim="nvim"' >> /etc/skel/.bashrc
    echo 'alias vi="nvim"' >> /etc/skel/.bashrc
    
    echo "Neovim $NEOVIM_VERSION has been successfully installed."
else
    echo "Installation of neovim $NEOVIM_VERSION has failed." >&2
    exit 1
fi