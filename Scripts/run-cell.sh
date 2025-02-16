#!/bin/bash
# So 16. Feb 18:18:19 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtabs2topic.sh tabs2topic.sh.md > tabs2topic.sh && echo 'tabs2topic.sh' && date
