# wgett
Created Donnerstag [Zettelkasten:2021:04:29]()

- [X] **wgett**


*run-cell.sh*
```bash
noweb.py -Rwgett wgett.md > wgett && chmod u+x wgett && echo 'fertig'
```

*wgett*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"

folder=$(date +"$journalDir/%Y/%m/%d")
mkdir -p $folder
cd $folder
File=$(wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" $1 2>&1 | tee /dev/tty | grep Wird | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')
#wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" -O $File $1
tt $File $1
```



