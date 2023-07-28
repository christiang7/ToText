# zim-open-file
Created [2023-06-25]()
- [X]  **zim-open-file**  [README.md](README.md)
    - [X] Doing
    - [X] Backlog


## Features


## Program

```bash
 noweb.py -Rzim-open-file.sh zim-open-file.md > zim-open-file.sh && echo 'fertig'
```


```bash
 chmod u+x zim-open-file.sh && ln -sf /home/christian/Gedankenspeicher/KanDo/GedankenspeicherEinrichtung/GedankenspeicherCoding/zim-open-file.sh ~/.local/bin/zim-open-file.sh && echo 'fertig'
 ```

### Main Program

```bash
{{zim-open-file.sh}}=
#!/bin/bash
file=$(readlink -f -n "$1")
Filename=$(basename $file .md)
xdg-open $Filename
@

```
