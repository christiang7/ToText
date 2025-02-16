#!/bin/bash
# So 16. Feb 18:25:09 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -RDownload-Video.sh Download-Video.md > Download-Video.sh && echo "Download-Video.sh" && date
