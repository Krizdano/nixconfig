#!/usr/bin/env sh
nvim --server /tmp/neovim.pipe --remote-silent $1 & nvim --server /tmp/neovim.pipe --remote-ui;
clear
