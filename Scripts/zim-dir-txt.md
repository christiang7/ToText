# zim-dir-txt
Created Mittwoch [2022-06-15]()
- [X] **zim-dir-txt**

*run-cell.sh*
```bash
noweb.py -Rzim-dir-txt.sh zim-dir-txt.md > zim-dir-txt.sh && echo 'fertig'
```

```bash
chmod u+x zim-dir-txt.sh && ln -sf $(pwd)/zim-dir-txt.sh ~/.local/bin/zim-dir-txt.sh && echo 'fertig'
```

*zim-dir-txt.sh*
```bash
#! /bin/bash
source tt-lib.sh
if zenity --question --text="Möchten Sie dieses Programm: ttd ausführen?"
then
    File=$(cleanName "$1")
    filename=${File%.*}
    mkdir -p "$filename"
    ttd "$filename"
fi
```

