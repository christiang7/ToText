# tt-tools.desktop
Created [2025-02-05](2025-02-05)

- [x] **tt-tools.desktop**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*make.sh*
```bash
noweb.py -Rtt-tools.desktop tt-tools.desktop.md > tt-tools.desktop && echo 'tt-tools.desktop' && date 
chmod u+x tt-tools.desktop && ln -sf $(pwd)/tt-tools.desktop ~/.local/share/kservices5/ServiceMenus/tt-tools.desktop && ln -sf $(pwd)/tt-tools.desktop ~/.local/share/kio/servicemenus/tt-tools.desktop && echo 'fertig'
```

### tt-tools.desktop

*tt-tools.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=application/*;audio/*;video/*;image/*;inode/directory;message/rfc822;text/html;text/x-tex;
Actions=ttMoveFile;ttDeleteFile;Maketxt;DownloadFile;InsertWebsession;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-tools
Terminal=true

[Desktop Action maketxtnoyad]
Name=tt
Icon=video
Terminal=true
Exec=tt %f "" "" "" "no" 2>&1 | tee ~/.config/tt/log

[Desktop Action Maketxt]
Name=tt with yad
Icon=video
Terminal=true
Exec=tt %f 2>&1 | tee ~/.config/tt/log

[Desktop Action ttMoveFile]
Name=ttm
Icon=audio
Terminal=true
Exec=ttm %f 2>&1 | tee ~/.config/tt/log

[Desktop Action ttDeleteFile]
Name=ttdel
Icon=video
Terminal=true
Exec=ttdel %f 2>&1 | tee ~/.config/tt/log

[Desktop Action DownloadFile]
Name=Download-File
Icon=video
Terminal=true
Exec=wgett %f 2>&1 | tee ~/.config/tt/log

[Desktop Action InsertWebsession]
Name=Insert-Websession
Icon=video
Terminal=true
Exec=insert-websession.sh %f 2>&1 | tee ~/.config/tt/log
```


