#!/bin/bash
# So 16. Feb 18:10:45 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtabs2today.sh tabs2today.sh.md > tabs2today.sh && echo 'fertig'
