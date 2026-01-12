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
File="$(basename $1 .md)"
#makeFile="$File-make.sh"
makeFile="make.sh"
echo "#!/bin/bash" > "${makeFile}"
echo "# $(date)" >> "${makeFile}"
echo "export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox" >> "${makeFile}"
#echo "eval "$(~/Programme/miniforge3/bin/conda shell.bash hook)"" >> make.sh
noweb.py -R${makeFile} "$File".md >> "${makeFile}" && chmod u+x "${makeFile}" && ./"${makeFile}" && rm "${makeFile}"
```
