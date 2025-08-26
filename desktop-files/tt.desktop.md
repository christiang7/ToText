# tt.desktop
Created [2025-02-05](2025-02-05)

- [x] **tt.desktop**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program


*make.sh*
```bash
noweb.py -Rtt.desktop tt.desktop.md > tt.desktop && echo 'tt.desktop' && date 
chmod u+x tt.desktop && ln -sf $(pwd)/tt.desktop ~/.local/share/kservices5/ServiceMenus/tt.desktop && ln -sf $(pwd)/tt.desktop ~/.local/share/kio/servicemenus/tt.desktop && echo 'fertig'
```

### tt.desktop

*tt.desktop*
```bash
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=application/*;audio/*;video/*;image/*;inode/directory;message/rfc822;text/html;text/x-tex;
Actions=maketxtnoyad;
#maketxt;
X-KDE-Priority=TopLevel
Terminal=true

[Desktop Action maketxtnoyad]
Name=tt
Icon=video
Terminal=true
Exec=tt %f "" "" "" "no" 2>&1 | tee ~/.config/tt/log

[Desktop Action maketxt]
Name=tt with yad
Icon=video
Terminal=true
Exec=tt %f 2>&1 | tee ~/.config/tt/log
```
