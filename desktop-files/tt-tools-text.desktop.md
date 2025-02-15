# tt-tools-text.desktop
Created [2025-02-05](2025-02-05)

- [X] **tt-tools-text.desktop**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*run-cell.sh*
```bash
noweb.py -Rtt-tools-text.desktop tt-tools-text.desktop.md > tt-tools-text.desktop && echo 'tt-tools-text.desktop' && date 
chmod u+x tt-tools-text.desktop && ln -sf $(pwd)/tt-tools-text.desktop ~/.local/share/kservices5/ServiceMenus/tt-tools-text.desktop && echo 'fertig'
```



*tt-tools-text.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=text/*;
Actions=MakeFolder;ChangeFormat;DeleteFile;RenameFile;MoveFile;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-tools

[Desktop Action OpenAnnotateFile]
Name=ttop
Icon=audio
Terminal=true
Exec=ttop %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action MakeFolder]
Name=ttf make folder for text file
Icon=video
Terminal=true
Exec=ttf %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action ChangeFormat]
Name=tt-change-format.sh
Icon=video
Terminal=true
#Icon=application-x-java
Exec=tt-change-format.sh %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action DeleteFile]
Name=ttdel
Icon=video
Terminal=true
#Icon=application-x-java
Exec=ttdel %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action RenameFile]
Name=tt-change rename files and add meta data
Icon=video
Terminal=true
#Icon=application-x-java
Exec=tt-change %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action MoveFile]
Name=ttm move file to today
Icon=video
Terminal=true
#Icon=application-x-java
Exec=ttm %n 2>&1 | tee /home/christian/.config/tt/log


```
