# ttop.desktop
Created [2025-02-05](2025-02-05)

- [x] **ttop.desktop**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*run-cell.sh*
```bash
noweb.py -Rttop.desktop ttop.desktop.md > ttop.desktop && echo 'ttop.desktop' && date 
chmod u+x ttop.desktop && ln -sf $(pwd)/ttop.desktop ~/.local/share/kservices5/ServiceMenus/ttop.desktop && echo 'fertig'
```


*ttop.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=text/*;
Actions=OpenAnnotateFile;
X-KDE-Priority=TopLevel

[Desktop Action OpenAnnotateFile]
Name=ttop
Icon=audio
Terminal=true
Exec=ttop %f 2>&1 | tee ~/.config/tt/log
```
