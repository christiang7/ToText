#!/bin/bash
htmlfolder="$1"
list=$(ls -1 "$htmlfolder" | grep .md)
echo $list
lines="$(wc --lines <<< "$list")"
cd $htmlfolder
for (( i=$lines ; i>=1 ; i-- ));
do
	element=$(sed -n "${i}p" <(echo "$list"))
	#echo "$element"
    head -20 "$element" > "temp-$element"
    head -20 "temp-$element" > "$element"
    rm "temp-$element"
done
