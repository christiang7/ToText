# ttop
Created Dienstag [2022:03:15]()

- [x] **ttop**


Open annotated file

### make.sh
*make.sh*
```bash
noweb.py -Rttop ttop.md > ttop && chmod u+x ttop && echo 'fertig'
````

### ttop
*ttop*
```bash
#!/bin/bash
f=$(basename "$1")
extens=${f##*.} #only the extension of the file
filename=${f%.*} #only the filename
xdg-open "$filename"/"$filename" # 2>/dev/null &
```

