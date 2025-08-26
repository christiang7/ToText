# tt-tools-folder.desktop
Created [2025-02-05](2025-02-05)

- [x] **tt-tools-folder.desktop**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*make.sh*
```bash
noweb.py -Rtt-tools-folder.desktop tt-tools-folder.desktop.md > tt-tools-folder.desktop && echo 'tt-tools-folder.desktop' && date 
chmod u+x tt-tools-folder.desktop && ln -sf $(pwd)/tt-tools-folder.desktop ~/.local/share/kservices5/ServiceMenus/tt-tools-folder.desktop && ln -sf $(pwd)/tt-tools-folder.desktop ~/.local/share/kio/servicemenus/tt-tools-folder.desktop && echo 'fertig'
```

### tt-tools-folder.desktop
*tt-tools-folder.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=inode/directory;
Actions=AnnotateAllFolder;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-folder

[Desktop Action AnnotateAllFolder]
Name=ttd
Name[de]=ttd
Icon=audio
Exec=ttd %f 2>&1 | tee ~/.config/tt/log
```
