# zim-wl-past
Created [2023-07-03]()

- [X]  **zim-wl-past** Christian Gößl [README.md](README.md)
    - [X] Doing
    - [X] Backlog

## Features

Insert clipboard from wayland composite

## Informations

## Main Program

```bash
noweb.py -Rzim-wl-past.sh zim-wl-past.md > zim-wl-past.sh && echo 'fertig'
```


```bash
chmod u+x zim-wl-past.sh && ln -sf $(pwd)/zim-wl-past.sh ~/.local/bin/zim-wl-past.sh && echo 'fertig'
 ```

*zim-wl-past.sh*
```bash
#!/bin/bash
wl-paste -n
sleep 0.5
killall wl-paste 2> /dev/null
exit
```
