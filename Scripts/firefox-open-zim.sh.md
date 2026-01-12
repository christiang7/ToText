# firefox-open-zim
Created Montag [2022:12:19]()

- [x] @Firefox @Zim @Wiki  **firefox-open-zim**



``echo http://localhost:8080/Zettelkasten/Gedankenwanderung/Zim-Arbeitsflaeche.html | sed "s,http://localhost:8080/,," | sed "s,.html,,"  | sed "s,/,:,g"``

*make.sh*
```bash
noweb.py -Rfirefox-open-zim.sh firefox-open-zim.md > firefox-open-zim.sh && echo 'fertig'
```

### firefox-open-zim.sh

*firefox-open-zim.sh*
```bash
#!/bin/sh
source config.sh; # load the config library functions
zimWikiName="$(config_get zimWikiName)"
zimDir="$(config_get zimDir)"

url=$(echo "$1" | sed "s,http://localhost:8080/,," | sed "s,.html,,"  | sed "s,/,:,g")
cd ~
$zimDir/zim.py --gui $zimWikiName "$url"
```

