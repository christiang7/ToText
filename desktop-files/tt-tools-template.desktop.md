# tt-tools-template.desktop
Created [2025-02-05](2025-02-05)

- [X] **tt-tools-template.desktop**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*run-cell.sh*
```bash
noweb.py -Rtt-tools-template.desktop tt-tools-template.desktop.md > tt-tools-template.desktop && echo 'tt-tools-template.desktop' && date 
chmod u+x tt-tools-template.desktop && ln -sf $(pwd)/tt-tools-template.desktop ~/.local/share/kservices5/ServiceMenus/tt-tools-template.desktop && echo 'fertig'
```


*tt-tools-template.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=inode/directory;
Actions=CreateFoldertxt;template_tex;template_calc;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-template

[Desktop Action CreateFoldertxt]
Name=ttnf.sh create folder txt
Name[de]=ttnf.sh Ordner mit txt Datei erzeugen
Icon=audio
Exec=ttnf.sh %n

[Desktop Action template_tex]
Name=template-tex.sh
Icon=video
Terminal=true
#Icon=application-x-java
Exec=template-tex.sh

[Desktop Action template_calc]
Name=template-calc or program
Icon=video
Terminal=true
#Icon=application-x-java
Exec=template-calculation.sh

```
