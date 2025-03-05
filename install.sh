#!/bin/bash
mkdir -p ~/.config/tt
cp configs/config-example ~/.config/tt/config
cp configs/config-mpv-example ~/.config/mpv/config
cp -r desktop-files/*.desktop ~/.local/share/kservices5/ServiceMenus/*.desktop
list=$(ls -1 --hide=*.md "Scripts")
cp $list .local/bin/*
