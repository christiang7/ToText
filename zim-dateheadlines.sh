#!/bin/bash
source config.sh; # load the config library functions
journalPage="$(config_get journalPage)"

echo -e "==== $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]") "

