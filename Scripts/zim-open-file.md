# zim-open-file
Created [2023-06-25]()
- [X]  **zim-open-file**  [README.md](README.md)
    - [X] Doing
        - [ ] Problem with files in zim with german Umlaute
    - [X] Backlog


## Features


## Program

*run-cell.sh*
```bash
noweb.py -Rzim-open-file.sh zim-open-file.md > zim-open-file.sh && echo 'fertig'
```


```bash
 chmod u+x zim-open-file.sh && ln -sf $(pwd)/zim-open-file.sh ~/.local/bin/zim-open-file.sh && echo 'fertig'
 ```

### Main Program

*zim-open-file.sh*
```bash
#!/bin/bash
file=$(readlink -f -n "$1")
Filename=$(basename $file .md)

#*With folder}}
```

### With folder

*With folder*
```bash
cd $Filename
Filename="$(echo ${Filename} | sed -e 's/a\xcc\x88/ä/' | sed -e 's/o\xcc\x88/ö/' | sed -e 's/u\xcc\x88/ü/' | sed -e 's/A\xcc\x88/Ä/' | sed -e 's/O\xcc\x88/Ö/' | sed -e 's/U\xcc\x88/Ü/')"
xdg-open $Filename
```

*Without folder*
```bash
xdg-open $Filename
```
