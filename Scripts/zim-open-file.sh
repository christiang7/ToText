#!/bin/bash
file=$(readlink -f -n "$1")
Filename=$(basename $file .md)

cd $Filename
Filename="$(echo ${Filename} | sed -e 's/a\xcc\x88/ä/' | sed -e 's/o\xcc\x88/ö/' | sed -e 's/u\xcc\x88/ü/' | sed -e 's/A\xcc\x88/Ä/' | sed -e 's/O\xcc\x88/Ö/' | sed -e 's/U\xcc\x88/Ü/')"
xdg-open $Filename
