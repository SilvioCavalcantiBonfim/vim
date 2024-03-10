#!/bin/bash

mkdir -p /home/dev/.config/nvim
mkdir -p /home/dev/.cache/nvim/

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'