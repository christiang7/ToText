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


```bash
 ```

*tt-tools-text.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=text/*;
Actions=CorrectTxtFile;MakeFolder;ChangeFormat;DeleteFile;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-tools

[Desktop Action OpenAnnotateFile]
Name=ttop
Icon=audio
Terminal=true
Exec=ttop %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action CorrectTxtFile]
Name=ttnc only for folders
Icon=video
Terminal=true
Exec=ttnc %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action MakeFolder]
Name=ttf
Icon=video
Terminal=true
Exec=ttf %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action InsertFile]
Name=tti
Icon=video
Terminal=true
#Icon=application-x-java
Exec=tti %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action ChangeFormat]
Name=change-ttn-format.sh
Icon=video
Terminal=true
#Icon=application-x-java
Exec=change-ttn-format.sh %n 2>&1 | tee /home/christian/.config/tt/log

[Desktop Action DeleteFile]
Name=ttdel
Icon=video
Terminal=true
#Icon=application-x-java
Exec=ttdel %n 2>&1 | tee /home/christian/.config/tt/log

```
