#!/bin/bash
# Sa 5. Apr 21:18:31 CEST 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rinsert-websession.sh insert-websession.sh.md > insert-websession.sh && echo 'insert-websession.sh' && date
