# ttop.desktop
Created [2025-02-05](2025-02-05)

- [x] **ttop.desktop**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*make.sh*
```bash
noweb.py -Rttop.desktop ttop.desktop.md > ttop.desktop && echo 'ttop.desktop' && date 
chmod u+x ttop.desktop && ln -sf $(pwd)/ttop.desktop ~/.local/share/kservices5/ServiceMenus/ttop.desktop && ln -sf $(pwd)/ttop.desktop ~/.local/share/kio/servicemenus/ttop.desktop && echo 'fertig'
```

### ttop.desktop

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
Exec=rm ~/.config/tt/log && ttop %f 2>&1 | tee ~/.config/tt/log
```
