#!/bin/bash

File=$(basename "$1")
echo "$File"
#check=true
#checkk=true
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

#echo $check
#echo $checkk
#if [[ $check == true ]]
#then
    #sed -i "4 s/\[\*\]/===== $File =====\\n\[\*\]/" "$File" && exit 1
    #sed -i "4 s/\[ \]/===== $File =====\\n\[ \]/" "$File" && exit 1
#fi
#if [[ $checkk == true ]]
#then
    #sed -i "5 s/\[\*\]/===== $File =====\\n\[\*\]/" "$File"
    #sed -i "5 s/\[ \]/===== $File =====\\n\[ \]/" "$File"
#fi
