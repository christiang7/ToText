# maff-md-cut.sh
Created [2024-03-15](2024-03-15)

- [X] **maff-md-cut.sh**
    - [X] Doing
    - [X] Backlog

## Features



## Informations
 Christian Gößl
## Main Program

```bash
noweb.py -Rmaff-md-cut.sh maff-md-cut.sh.md > maff-md-cut.sh && echo 'fertig' 
```


```bash
chmod u+x maff-md-cut.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/Gedankenspeicher-Coding/maff-md-cut.sh ~/.local/bin/maff-md-cut.sh && echo 'fertig'
 ```

```bash
{{maff-md-cut.sh}}=
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
    {{maff file correction}}
done
@
```

```bash
{{maff file correction}}=
head -20 "$element" > "temp-$element"
head -20 "temp-$element" > "$element"
rm "temp-$element"
@
```