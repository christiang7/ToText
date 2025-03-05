# ttf
Created Freitag [2022:05:20]()
Backlink [CodeFabrik]()

- [x] **ttf**

Create folder for txt file

*run-cell.sh*
```bash
noweb.py -Rttf ttf.md > ttf && chmod u+x ttf && echo 'fertig'
```

*ttf*
```bash
#!/bin/bash
f=$(basename "$1" .md)
#extens=${f##*.} #only the extension of the file
filename=${f%.*} #only the filename
mkdir -p "$filename"
```

