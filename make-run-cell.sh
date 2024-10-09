#!/bin/bash
noweb.py -Rrun-cell.sh "$1" > run-cell.sh && chmod u+x run-cell.sh && ./run-cell.sh
