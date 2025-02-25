# tt-tools-template.desktop
Created [2025-02-05](2025-02-05)

- [x] **tt-tools-template.desktop**
    - [x] Doing
    - [x] Backlog

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
Actions=template_note;template_tex;template_calc;
X-KDE-Priority=TopLevel
X-KDE-Submenu=tt-template

[Desktop Action template_note]
Name=template-note.sh create note with folder
Name[de]=template-note.sh erstelle Notiz mit Ordner
Icon=audio
Exec=template-note.sh %n

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
