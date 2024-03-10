FROM debian:stable-slim

RUN mkdir -p /tmp/install
RUN mkdir -p /tmp/download

RUN apt update && apt install -y curl git build-essential

COPY ./script/install/util.sh /tmp/install
COPY ./script/install/java.sh /tmp/install
COPY ./script/install/neovim.sh /tmp/install
COPY ./script/install/maven.sh /tmp/install

WORKDIR /tmp

RUN chmod +x ./install/*.sh

RUN for script in "./install"/*; do if [ -x "$script" ]; then "$script"; fi; done

RUN useradd -m dev && chsh -s /bin/bash dev


USER dev

WORKDIR /home/dev

RUN mkdir -p /home/dev/workspace
RUN mkdir -p /home/dev/.config/nvim
RUN mkdir -p /home/dev/.cache/nvim/

RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY init.vim /home/dev/.config/nvim

RUN /opt/nvim-linux64/bin/nvim -c 'PlugInstall' -c 'qa'