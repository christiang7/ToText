#!/bin/bash
File="$(basename $1 .md)"
#makeFile="$File-make.sh"
makeFile="make.sh"
echo "#!/bin/bash" > "${makeFile}"
echo "# $(date)" >> "${makeFile}"
echo "export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox" >> "${makeFile}"
#echo "eval "$(~/Programme/miniforge3/bin/conda shell.bash hook)"" >> make.sh
noweb.py -R${makeFile} "$File".md >> "${makeFile}" && chmod u+x "${makeFile}" && ./"${makeFile}" && rm "${makeFile}"
