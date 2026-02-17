#!/usr/bin/env bash
git clone https://github.com/DreamMaoMao/mangowc.git
cd mangowc
meson build -Dprefix=/usr
sudo ninja -C build install
cd ..
rm -rf mangowc
