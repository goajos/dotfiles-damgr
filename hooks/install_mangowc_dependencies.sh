#!/usr/bin/env bash

# install wlroots dependency
git clone -b 0.19.2 https://gitlab.freedesktop.org/wlroots/wlroots.git
cd wlroots
meson build -Dprefix=/usr -Dwerror=false
sudo ninja -C build install
cd ..
rm -rf wlroots

# install scenefx dependency
git clone -b 0.4.1 https://github.com/wlrfx/scenefx.git
cd scenefx
meson build -Dprefix=/usr -Dwerror=false
sudo ninja -C build install
cd ..
rm -rf scenefx
