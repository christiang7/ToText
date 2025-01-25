# change-ttn-format.sh
Created [2024-10-09](2024-10-09)

- [X] **change-ttn-format.sh**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

*run-cell.sh*
```bash
noweb.py -Rchange-ttn-format.sh change-ttn-format.sh.md > change-ttn-format.sh && echo 'fertig' 
```


```bash
chmod u+x change-ttn-format.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/Gedankenspeicher-Coding/change-ttn-format.sh ~/.local/bin/change-ttn-format.sh && echo 'fertig'
 ```

*change-ttn-format.sh*
```bash
#!/bin/bash
File=$(basename "$1")
extensmd=${File##*.}
Filename=${File%.*} #here it is the original file
extens=${Filename##*.} # and the original file extension
folder=$(basename "$Filename" ."$extens")

mkdir "$folder"
mv "$Filename" "$folder"/"$Filename"
mv "$Filename.avif" "$folder"/"$Filename.avif"
mv "$Filename.png" "$folder"/"$Filename.png"
mv "${Filename%.*}" "$folder"/"$Filename"
mv "${Filename%.*}"_files "$folder"/"$Filename"_files
mv "${Filename%.*}"-Dateien "$folder"/"$Filename"-Dateien
mv "${Filename%.*}"_Dateien "$folder"/"$Filename"_Dateien
mv "$folder" "$folder.$extens"
folder="$folder.$extens"
sed -i "s/..\/$Filename/.\/$Filename/g" "$File"
```
