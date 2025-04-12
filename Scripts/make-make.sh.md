# make-make.sh
Created [2024-10-09](2024-10-09)

- [x] **make-make.sh**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

*make.sh*
```bash
noweb.py -Rmake-make.sh make-make.sh.md > temp-make-make.sh && cp make-make.sh old-make-make.sh && mv temp-make-make.sh make-make.sh && chmod u+x make-make.sh && echo 'make-make.sh' && date
```

*make-make.sh*
```bash
#!/bin/bash
echo "#!/bin/bash" > make.sh
echo "# $(date)" >> make.sh
echo "export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox" >> make.sh
#echo "eval "$(/home/christian/Gedankenspeicher/Programme/miniforge3/bin/conda shell.bash hook)"" >> make.sh
noweb.py -Rmake.sh "$1" >> make.sh && chmod u+x make.sh && ./make.sh
```
