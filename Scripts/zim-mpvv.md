# zim-mpvv
Created 2021-04-24

- [x] **zim-mpvv**


Kommando zum Extrahieren des Scripts

*make.sh*
```bash
noweb.py -Rzim-mpvv zim-mpvv.md > zim-mpvv && echo 'fertig'
```

*zim-mpvv*
```bash
#!/bin/bash
#xterm -e "mpvv '$1'; bash" &
konsole --hold -e sh -c "mpvv $1 ; exec bash" &
```
