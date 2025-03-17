# texstudio-noweb-py.sh
Created [2023-10-30]()


- [x] **texstudio-noweb-py.sh** [README.md](README.md)
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

```bash
noweb.py -Rtexstudio-noweb-py.sh texstudio-noweb-py.sh.md > texstudio-noweb-py.sh && echo 'fertig' 
```

### texstudio-noweb-py.sh
*texstudio-noweb-py.sh*
```bash
#!/bin/bash
file="$1"
noweb.py -R${file}.tex ${file}.md > ${file}.tex
```
