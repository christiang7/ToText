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


*make.sh*
```bash
noweb.py -Rtemplate-apply.sh template-apply.sh.md > template-apply.sh && echo 'template-apply.sh' && date && notify-send -a "Compilation of template-apply.sh" "" "$(date +"%Y-%m-%d") fertig"
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
#Apply=
```

### Request and main program

*request*
```bash
abfrage=$(yad --title="New Apply" --text="Necessary Informations:" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Applyname" \
	--field="Author":CBE \
	--field="Tags":CBE \
	--field="- Research Statement":CHK \
	--field="- Git init?":CHK \
	--field="Description":TXT \
	"" "$author,Internet" ",physic,math" "FALSE" "TRUE" "$additiontext")
if [ ! $? -eq 1 ];
then
	Applyname=$(echo $abfrage | cut -s -d "~" -f 1)
	source=$(echo $abfrage | cut -s -d "~" -f 2)
	tags=$(echo $abfrage | cut -s -d "~" -f 3)
	researchstat=$(echo $abfrage | cut -s -d "~" -f 4)
	gitinit=$(echo $abfrage | cut -s -d "~" -f 5)
	additiontext=$(echo $abfrage | cut -s -d "~" -f 6)

    Apply=$(cleanName "$Applyname")

	mkdir -p "$folder"/"$Apply"

    create-note "$folder" "$Apply" "$tags" "$source" "$additiontext" >> "$folder"/"$Apply".md

    markdown-description-program "README" >> "$folder/$Apply"/"README".md

    #template-tex.sh "$folder/$Apply" "no" "cover-letter" "Schreiben"

    cp -r "$templateDir"/1»Bewerbungen/cover-letter_tex "$folder"/"$Apply"/cover-letter_tex
    cp -r "$templateDir"/1»Bewerbungen/cover-letter_tex.md "$folder"/"$Apply"/cover-letter_tex.md
    
    cp -r "$templateDir"/1»Bewerbungen/CV_tex "$folder"/"$Apply"/CV_tex
    cp -r "$templateDir"/1»Bewerbungen/CV_tex.md "$folder"/"$Apply"/CV_tex.md
    
    cp -r "$templateDir"/1»Bewerbungen/Lebenslauf_tex "$folder"/"$Apply"/Lebenslauf_tex
    cp -r "$templateDir"/1»Bewerbungen/Lebenslauf_tex.md "$folder"/"$Apply"/Lebenslauf_tex.md
    
    cp -r "$templateDir"/1»Bewerbungen/Media "$folder"/"$Apply"/Media
    
    if [[ $researchstat == TRUE ]];
	then
        cp -r "$templateDir"/1»Bewerbungen/Research_Statement_tex "$folder"/"$Apply"/Research_Statement_tex
        cp -r "$templateDir"/1»Bewerbungen/Research_Statement_tex.md "$folder"/"$Apply"/Research_Statement_tex.md
	fi

    #ln  -sf "$templateDir"/1»Bewerbungen/Attachments "$folder"/"$Apply"/Attachments

    if [[ $gitinit == TRUE ]];
	then
		#*git init}}
	fi
	notify-send -a "Created apply template $Apply" "" "$(date +"%Y-%m-%d") fertig"
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



