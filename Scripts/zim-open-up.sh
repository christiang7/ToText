#!/bin/bash
file=$(readlink -f -n "$1")
filepath=$(echo "${file%/*}")
xdg-open $filepath
