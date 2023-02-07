#!/bin/bash
folder=$(date +"/home/christian/AEI/Zettelkasten/%Y/%m/%d")
cd $folder
File=$(wget --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" $1 2>&1 | grep Saving | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')
wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" -O $File $1
ttn $File $1
