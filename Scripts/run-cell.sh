#!/bin/bash
# Di 25. Feb 12:26:20 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rzim-insert-sketch.sh zim-insert-sketch.md > zim-insert-sketch.sh && echo 'fertig'
