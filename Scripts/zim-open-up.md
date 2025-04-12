# zim-open-up
Created 2023-06-22

- [x]  **zim-open-up**  [README.md](README.md)
	- [x] Doing
	- [x] Backlog

## Features

Open in zim the folder of the containing file.

*make.sh*
```bash
 noweb.py -Rzim-open-up.sh zim-open-up.md > zim-open-up.sh && echo 'fertig' 
```


```bash
 chmod u+x zim-open-up.sh && ln -sf $(pwd)/zim-open-up.sh ~/.local/bin/zim-open-up.sh && echo 'fertig'
 ```


## Main program

*zim-open-up.sh*
```bash
#!/bin/bash
file=$(readlink -f -n "$1")
filepath=$(echo "${file%/*}")
xdg-open $filepath
```
