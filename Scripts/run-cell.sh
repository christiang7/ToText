#!/bin/bash
# So 16. Feb 17:29:30 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtt tt.md > tt && chmod u+x tt && echo 'tt' && date
