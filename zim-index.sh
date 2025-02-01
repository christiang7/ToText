#!/bin/bash
source config.sh; # load the config library functions
zimWikiName="$(config_get zimWikiName)"
zimDir="$(config_get zimDir)"

sleep 20 && $zimDir/zim.py --index $zimWikiName
