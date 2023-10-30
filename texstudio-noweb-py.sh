#!/bin/bash
file="$1"
noweb.py -R${file}.tex ${file}.md > ${file}.tex
