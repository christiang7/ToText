#!/bin/bash

File=$(basename "$1")
echo "$File"

line=$(sed -n '/\[\*\]/{=;}' $File )
line=${line:0:1}
if [[ $line > 5 ]]
then
    linee=$(sed -n '/\[\ \]/{=;}' $File )
    linee=${linee:0:1}
    sed -i "$linee s/\[ \]/===== $File =====\\n\[ \]/" "$File"
else
    sed -i "$line s/\[\*\]/===== $File =====\\n\[\*\]/" "$File"
fi

