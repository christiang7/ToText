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

*make-run-cell.sh*
```bash
#!/bin/bash
echo "#!/bin/bash" > run-cell.sh
echo "# $(date)" >> run-cell.sh
echo "export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox" >> run-cell.sh
#echo "eval "$(/home/christian/Gedankenspeicher/Programme/miniforge3/bin/conda shell.bash hook)"" >> run-cell.sh
noweb.py -Rrun-cell.sh "$1" >> run-cell.sh && chmod u+x run-cell.sh && ./run-cell.sh
```
