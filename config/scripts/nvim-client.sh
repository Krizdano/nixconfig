#!/usr/bin/env sh
 
nvim --server /tmp/neovim.pipe --remote-silent $(realpath ${1:-.}) & nvim --server /tmp/neovim.pipe --remote-ui;
clear


