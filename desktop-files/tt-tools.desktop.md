# tt-tools.desktop
Created [2025-02-05](2025-02-05)

- [x] **tt-tools.desktop**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*run-cell.sh*
```bash
noweb.py -Rtt-tools.desktop tt-tools.desktop.md > tt-tools.desktop && echo 'tt-tools.desktop' && date 
chmod u+x tt-tools.desktop && ln -sf $(pwd)/tt-tools.desktop ~/.local/share/kservices5/ServiceMenus/tt-tools.desktop && echo 'fertig'
```


*tt-tools.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=application/*;audio/*;video/*;image/*;inode/directory;message/rfc822;text/html;text/x-tex;
Actions=ttMoveFile;ttDeleteFile;Maketxt;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-tools
Terminal=true

[Desktop Action maketxtnoyad]
Name=tt
Icon=video
Terminal=true
#Icon=application-x-java
Exec=tt %f "" "" "" "no" 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action Maketxt]
Name=tt with yad
Icon=video
Terminal=true
#Icon=application-x-java
Exec=tt %f 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action ttMoveFile]
Name=ttm
Icon=audio
Terminal=true
Exec=ttm %f 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action ttDeleteFile]
Name=ttdel
Icon=video
Terminal=true
#Icon=application-x-java
Exec=ttdel %f 2>&1 | tee /home/christian/.config/tt/log



```
