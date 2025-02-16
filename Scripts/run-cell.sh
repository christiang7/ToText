#!/bin/bash
# So 16. Feb 18:54:01 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtt-lib.sh tt-lib.sh.md > tt-lib.sh && echo 'tt-lib.sh' && date

