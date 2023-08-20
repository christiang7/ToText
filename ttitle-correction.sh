#!/bin/bash

File=$(basename "$1")
#echo "$File"

line=$(sed -n '/\[\*\]/{=;}' $File )
line=${line:0:1}
#echo $line
if [[ $line > 5 || $line == "" ]]
then
    linee=$(sed -n '/\[\ \]/{=;}' $File )
    linee=${linee:0:1}
    sed -i "$linee s/\[ \]/====== $(basename $File .md) ======\\n\[ \]/" "$File"
else
    sed -i "$line s/\[\*\]/====== $(basename $File .md) ======\\n\[\*\]/" "$File"
fi

