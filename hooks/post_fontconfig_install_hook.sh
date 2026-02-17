#!/usr/bin/env bash
mkdir -p /usr/local/share/fonts/ttf/JetBrainsMono
cp -r -u /home/jappe/.config/damgr/files/fonts/JetBrainsMono/* /usr/local/share/fonts/ttf/JetBrainsMono/
mkdir -p /usr/local/share/fonts/ttf/Noto
cp -r -u /home/jappe/.config/damgr/files/fonts/Noto/* /usr/local/share/fonts/ttf/Noto/

fc-cache -fv
