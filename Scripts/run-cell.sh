#!/bin/bash
# Mo 17. Feb 01:42:09 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rrss-feed-reinsert.sh rss-feed-reinsert.md > rss-feed-reinsert.sh && echo 'fertig'
