#!/bin/bash
echo "#!/bin/bash" > run-cell.sh
echo "# $(date)" >> run-cell.sh
echo "export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox" >> run-cell.sh
#echo "eval "$(/home/christian/Gedankenspeicher/Programme/miniforge3/bin/conda shell.bash hook)"" >> run-cell.sh
noweb.py -Rrun-cell.sh "$1" >> run-cell.sh && chmod u+x run-cell.sh && ./run-cell.sh
