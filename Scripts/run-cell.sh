#!/bin/bash
# Mo 17. Feb 17:40:06 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtabs2topic.sh tabs2topic.sh.md > tabs2topic.sh && echo 'tabs2topic.sh' && date
