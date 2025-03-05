#!/bin/bash
# Mi 5. Mär 15:42:17 CET 2025
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
noweb.py -Rtemplate-apply.sh template-apply.sh.md > template-apply.sh && echo 'template-apply.sh' && date
