#!/bin/bash
# Fr 14. Feb 15:50:20 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rmake-run-cell.sh make-run-cell.sh.md > temp-make-run-cell.sh && cp make-run-cell.sh old-make-run-cell.sh && mv temp-make-run-cell.sh make-run-cell.sh && chmod u+x make-run-cell.sh && echo 'make-run-cell.sh' && date
