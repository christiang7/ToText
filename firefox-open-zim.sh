#!/bin/sh
source config.sh; # load the config library functions
zimWikiName="$(config_get zimWikiName)"
zimDir="$(config_get zimDir)"

url=$(echo "$1" | sed "s,http://localhost:8080/,," | sed "s,.html,,"  | sed "s,/,:,g")
cd ~
$zimDir/zim.py --gui $zimWikiName "$url"
