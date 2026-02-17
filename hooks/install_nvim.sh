#!/usr/bin/env bash
git clone https://github.com/neovim/neovim
cd neovim
sudo make install
cd ..
rm -rf neovim
