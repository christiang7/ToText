#!/bin/bash
echo "#!/bin/bash" > make.sh
echo "# $(date)" >> make.sh
echo "export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox" >> make.sh
#echo "eval "$(/home/christian/Gedankenspeicher/Programme/miniforge3/bin/conda shell.bash hook)"" >> make.sh
noweb.py -Rmake.sh "$1" >> make.sh && chmod u+x make.sh && ./make.sh
