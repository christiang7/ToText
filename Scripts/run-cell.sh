#!/bin/bash
# Mo 10. Mär 16:18:56 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Ropen-websession.sh open-websession.sh.md > open-websession.sh && date
