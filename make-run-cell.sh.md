# make-run-cell.sh
Created [2024-10-09](2024-10-09)

- [X] **make-run-cell.sh**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

*run-cell.sh*
```bash
noweb.py -Rmake-run-cell.sh make-run-cell.sh.md > temp-make-run-cell.sh && cp make-run-cell.sh old-make-run-cell.sh && mv temp-make-run-cell.sh make-run-cell.sh && chmod u+x make-run-cell.sh && echo 'make-run-cell.sh' && date
```


```bash
chmod u+x make-run-cell.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/Gedankenspeicher-Coding/make-run-cell.sh ~/.local/bin/make-run-cell.sh && echo 'fertig'
 ```

*make-run-cell.sh*
```bash
#!/bin/bash
echo "#!/bin/bash" > run-cell.sh
echo "# $(date)" >> run-cell.sh
noweb.py -Rrun-cell.sh "$1" >> run-cell.sh && chmod u+x run-cell.sh && ./run-cell.sh
```
