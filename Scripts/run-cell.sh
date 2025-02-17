#!/bin/bash
# Mo 17. Feb 01:03:38 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rttd ttd.md > ttd && chmod u+x ttd && echo 'fertig'
