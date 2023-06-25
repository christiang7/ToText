#!/bin/bash
file=$(readlink -f -n "$1")
Filename=$(basename $file .md)
xdg-open $Filename
