# webpage-pdf
Text creation time: So 27. Dez 22:00:40 CET 2020 Modification time: Mi 23. Dez 15:48:55 CET 2020

 
 There is a problem with the firefox addon external application

*make.sh*
```bash
noweb.py -Rwebpage-pdf webpage-pdf.md > webpage-pdf && chmod u+x webpage-pdf && echo 'fertig'
```

*webpage-pdf*
```bash
#!/bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
source tt-lib.sh

folder=$(date +"$journalDir/%Y/%m/%d")
mkdir -p $folder

File=$(cleanName "$2")
wkhtmltoimage --enable-javascript --images "$1" $folder/"$File".png
ttpdf $folder/"$File".png "$1"

# --print-media-type
# --encoding utf8 --stop-slow-scripts --no-background --disable-forms --footer-center '[page]/[toPage]' -L 4cm -R 4cm --minimum-font-size 17
```

