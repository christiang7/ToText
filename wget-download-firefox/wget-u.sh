#!/bin/bash
cd ~/Downloads/
wget --output-document="$1" --user-agent="$2" --referer="$3" --no-check-certificate --continue --load-cookies=$4 "$5" 
