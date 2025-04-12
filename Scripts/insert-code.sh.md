# insert-code.sh
Created [2025-02-13]()


## Description

## Journal
 - [x] Doing
 - [x] Backlog
    - [ ] 
 
## Main Program


procedure
- [yad] request for insert code block 
- using ``template-code`` function from [[tt-lib.sh]]


*make.sh*
```bash
noweb.py -Rinsert-code.sh insert-code.sh.md > insert-code.sh && echo 'insert-code.sh' && date 
```


```bash
chmod u+x insert-code.sh && ln -sf $(pwd)/insert-code.sh ~/.local/bin/insert-code.sh && echo 'fertig'
```
 
### insert-code.sh
*insert-code.sh*
```bash
#!/bin/bash
source tt-lib.sh
source config.sh
langName="$(config_get langName)"

txtfile=$(readlink -f -n "$1")
folder=${txtfile%.*}
txtfile=$(basename "$txtfile")
txtfilename=${txtfile%.*}
#echo $folder

abfrage=$(yad --title="Insert code?" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Filename" \
	--field="Shortname for language":CBE \
	--field="Add to existing code":CB \
	"" "$langName" ",yes")
if [ ! $? -eq 1 ];
then
	mkdir -p "$folder"
	File=$(echo $abfrage | cut -s -d "~" -f 1)
	langname=$(echo $abfrage | cut -s -d "~" -f 2)
	add=$(echo $abfrage | cut -s -d "~" -f 3)

	File=$(cleanName "$File")

	extens="$(get-extens ${langname})"

	Filename="$File"
	File="$File"."${extens}"
	
	
	template-code "." "${Filename}.${extens}" "${txtfilename}" "$add"
	
fi
```
