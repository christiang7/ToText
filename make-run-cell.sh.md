# make-run-cell.sh
Created [2024-10-09](2024-10-09)

- [X] **make-run-cell.sh**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

```bash
{{run-cell.sh}}=
noweb.py -Rmake-run-cell.sh make-run-cell.sh.md > make-run-cell.sh && echo 'fertig'
@
```


```bash
chmod u+x make-run-cell.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/Gedankenspeicher-Coding/make-run-cell.sh ~/.local/bin/make-run-cell.sh && echo 'fertig'
 ```

```bash
{{make-run-cell.sh}}=
#!/bin/bash
noweb.py -Rrun-cell.sh "$1" > run-cell.sh && chmod u+x run-cell.sh && ./run-cell.sh
@
```
