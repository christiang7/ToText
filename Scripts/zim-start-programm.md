# zim-start-programm
Created Dienstag [Zettelkasten:2022:10:11]()

- [X] **zim-start-programm**

*run-cell.sh*
```bash
noweb.py -Rzim-start-programm.sh zim-start-programm.md > zim-start-programm.sh && echo 'fertig'
```



*zim-start-programm.sh*
```bash
#!/bin/bash
yad --title="Esecute $1 program?" --text="\n Selected program will be executed\n"
if [ ! $? -eq 1 ];
then
  konsole -e "$1"
fi
```

