#!/bin/bash
# Mi 5. Mär 01:34:15 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtemplate-note.sh template-note.sh.md > template-note.sh  && echo 'fertig'
