# tt-tools-text.desktop
Created [2025-02-05](2025-02-05)

- [x] **tt-tools-text.desktop**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*make.sh*
```bash
noweb.py -Rtt-tools-text.desktop tt-tools-text.desktop.md > tt-tools-text.desktop && echo 'tt-tools-text.desktop' && date 
chmod u+x tt-tools-text.desktop && ln -sf $(pwd)/tt-tools-text.desktop ~/.local/share/kservices5/ServiceMenus/tt-tools-text.desktop && ln -sf $(pwd)/tt-tools-text.desktop ~/.local/share/kio/servicemenus/tt-tools-text.desktop && echo 'fertig'
```

### tt-tools-text.desktop

*tt-tools-text.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=text/*;
Actions=MakeFolder;ChangeFormat;DeleteFile;RenameFile;MoveFile;OpenWebsession;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-tools

[Desktop Action OpenAnnotateFile]
Name=ttop
Icon=audio
Terminal=true
Exec=ttop %f 2>&1 | tee ~/.config/tt/log

[Desktop Action MakeFolder]
Name=ttf make folder for text file
Icon=video
Terminal=true
Exec=ttf %f 2>&1 | tee ~/.config/tt/log

[Desktop Action ChangeFormat]
Name=tt-change-format.sh
Icon=video
Terminal=true
#Icon=application-x-java
Exec=tt-change-format.sh %f 2>&1 | tee ~/.config/tt/log

[Desktop Action DeleteFile]
Name=ttdel
Icon=video
Terminal=true
Exec=ttdel %f 2>&1 | tee ~/.config/tt/log

[Desktop Action RenameFile]
Name=tt-change rename files and add meta data
Icon=video
Terminal=true
Exec=tt-change %f 2>&1 | tee ~/.config/tt/log

[Desktop Action MoveFile]
Name=ttm move file to today
Icon=video
Terminal=true
Exec=ttm %f 2>&1 | tee ~/.config/tt/log

[Desktop Action OpenWebsession]
Name=open-websession.sh
Icon=video
Terminal=true
Exec=open-websession.sh %f 2>&1 | tee ~/.config/tt/log

```
