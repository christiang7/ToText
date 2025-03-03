#!/bin/bash
# Fr 28. Feb 22:22:26 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rmpvv mpvv.md > mpvv && echo 'mpvv' && date
