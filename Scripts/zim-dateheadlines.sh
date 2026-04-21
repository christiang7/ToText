#!/bin/bash
source tt-lib.sh; # load the config library functions
journalPage="$(config_get journalPage)"

#echo -e "### $(date +"[[$journalPage/%Y/%m/%d|%Y-%m-%d]]") "
echo -e "### $(date +"%Y-%m-%d") "
```

