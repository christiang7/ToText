#!/bin/bash
# Mo 17. Feb 00:01:33 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtemplate-note.sh template-note.sh.md > template-note.sh  && echo 'fertig'
