#!/bin/bash
# Mo 24. Feb 00:23:19 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtt-lib.sh tt-lib.sh.md > tt-lib.sh && echo 'tt-lib.sh' && date

