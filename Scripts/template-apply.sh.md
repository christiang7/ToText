# template-apply.sh
Created [2025-02-12]()


## Description

## Journal
 - [x] Doing
 - [x] Backlog
    - [ ] 
 
## Main Program


Creation of Bewerbung template

procedure
- create note and folder
- create letter template
- copy CV
- copy research statement
- link Attachments


*run-cell.sh*
```bash
noweb.py -Rtemplate-apply.sh template-apply.sh.md > template-apply.sh && echo 'template-apply.sh' && date 
```


```bash
chmod u+x template-apply.sh && ln -sf $(pwd)/template-apply.sh ~/.local/bin/template-apply.sh && echo 'fertig'
 ```

*template-apply.sh*
```bash
#!/bin/bash

#*preamble}}

#*check files}}

#*request}}

```

### Preamble

Load configuration files

*preamble*
```bash
#!/bin/bash
source config.sh; # load the config library functions
templateDir="$(config_get templateDir)"
author="$(config_get author)"
source tt-lib.sh
```

### Check files

Create folder and checking the path.

*check files*
```bash
if [[ -e "$1" ]]
then
    filetxt=$(readlink -f -n "$1")
    folder=${filetxt%.*}
    #Project=$(basename $folder)
else
    #Project="Projectname"
    folder=$(pwd)
fi
Apply=
```

### Request and main program

*request*
```bash
abfrage=$(yad --title="New Apply" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Applyname" \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="Git init?":CB \
	--field="Description":TXT \
	"$Apply" "$author,Internet" ",physic,math" "Yes,No" "$additiontext")
if [ ! $? -eq 1 ];
then
	Applyname=2»$(echo $abfrage | cut -s -d "~" -f 1)
	langname=$(echo $abfrage | cut -s -d "~" -f 2)
	source=$(echo $abfrage | cut -s -d "~" -f 3)
	tags=$(echo $abfrage | cut -s -d "~" -f 4)
	gitinit=$(echo $abfrage | cut -s -d "~" -f 5)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 6)

    Apply=$(cleanName "$Applyname")

	mkdir -p "$Apply"

    create-note "$folder" "$Apply" "$tags" "$source" "$additiontext" >> "$folder"/"$Apply".md

    markdown-description-program "README" >> "$folder/$Apply"/"README".md

    template-tex.sh "$folder/$Apply" "no" "cover-letter" "Schreiben"

    cp "$templateDir"/Research_Statement_tex/general-preamble.tex "$folder"/"$Apply"/Research_Statement_tex/general-preamble.tex
    
    cp "$templateDir"/Research_Statement_tex/color-style.tex "$folder"/"$Apply"/Research_Statement_tex/color-style.tex
    
    cp -r "$templateDir"/Bewerbungen/CV_tex "$folder"/"$Apply"/CV_tex

    cp -r "$templateDir"/Bewerbungen/Research_Statement_tex "$folder"/"$Apply"/Research_Statement_tex

    ln  -sf "$templateDir"/Bewerbungen/Attachments "$folder"/"$Apply"/Attachments

    if [[ $gitinit == "Yes" ]];
	then
		#*git init}}
	fi
fi
```

### git versioning

*git init*
```bash
cd "$folder/$Apply"
git init
git add *
git commit -a -m "init git"
```



