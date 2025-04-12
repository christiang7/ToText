# instadown
Created Samstag [2022:04:09]()

- [x] **instadown**

*make.sh*
```bash
noweb.py -Rinstadown instadown.md > instadown && chmod u+x instadown && echo 'fertig'
```



*instadown*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
folder=$(date +"$journalDir/%Y/%m/%d")
mkdir -p $folder
cd $folder
gallery-dl --no-mtime --exec "tt {} '$1' " -D "$folder" "$1"
```

