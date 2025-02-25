# maff-md-cut.sh
Created [2024-03-15](2024-03-15)

- [x] **maff-md-cut.sh**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

```bash
noweb.py -Rmaff-md-cut.sh maff-md-cut.sh.md > maff-md-cut.sh && echo 'fertig' 
```


*maff-md-cut.sh*
```bash
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
	
    #*maff file correction}}
    
done
```

*maff file correction*
```bash
head -20 "$element" > "temp-$element"
head -20 "temp-$element" > "$element"
rm "temp-$element"
```