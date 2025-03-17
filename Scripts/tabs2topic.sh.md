# tabs2topic
Created Dienstag [2022:10:25]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [x] **tabs2topic**
	- [x] Doing
	- [x] Backlog

## Features

Combination with the program [tabs2today](tabs2today.md).
You can add tabs from browser in a specific page you choose.


## Infos

WEB keyboard shortcuts - How do I cut a line in KDE Kate? - Super User  
https://superuser.com/questions/1080876/how-do-i-cut-a-line-in-kde-kate  
WEB How to Safely Exit from Bash Scripts | Baeldung on Linux  
https://www.baeldung.com/linux/safely-exit-scripts  


WEB sed Substitution With Variables | Baeldung on Linux

https://www.baeldung.com/linux/sed-substitution-variables  

WEB Using sed With a Literal String Instead of an Input File | Baeldung on Linux  
https://www.baeldung.com/linux/sed-with-string  

WEB 12 Useful 'sed' Commands In Linux | LinuxTeck  

https://www.linuxteck.com/sed-commands-in-linux/  

## Program

*run-cell.sh*
```bash
noweb.py -Rtabs2topic.sh tabs2topic.sh.md > tabs2topic.sh && echo 'tabs2topic.sh' && date
```

### tabs2topic.sh

*tabs2topic.sh*
```bash
#! /bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
journalPage="$(config_get journalPage)"
wikiDir="$(config_get wikiDir)"
author="$(config_get author)"
source tt-lib.sh
#*request}}

```

### Request

*request*
```bash

request=$(yad --title="Notes or archiv" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Quelle:":CB \
	--field="Weiteres":TXT \
	"Spass,NeuNotiz,Heute,Physik,Mathematik,Blogging,Philosophie,Naturwissenschaften_und_Instrumentarien,CodeFabrik,Zettelkasten" "")
choose=$(echo $request | cut -s -d "~" -f 1)
additiontext=$(echo $request | cut -s -d "~" -f 2)
if [ ! $? -eq 1 ]; 
then
	#tabs="$(xclip -selection clipboard -o)"
	l="" # lineposition of the desired file
	tabs="$(wl-paste -n)"
	case ${choose} in
	NeuNotiz)
		#*new note}}
		;;
	*)
		######*tabs to topics}}
		
		#*tabsession to topics}}
		
		;;
	esac
fi
```

### new note creation


*new note*
```bash
request=$(yad --title="Which topic" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Where:":CB \
	--field="Topic:" \
	--field="Source:":CBE \
	--field="Tags:" \
	--field="Something else":TXT \
	"Spass,Physik,Mathematik,Blogging,Philosophie,CodeFabrik,Zettelkasten" "Topicname" "Internet,$author," "" "$additiontext")

if [ ! $? -eq 1 ];
then
	chooseWhere=$(echo $request | cut -s -d "~" -f 1)
	topic="2»$(echo $request | cut -s -d "~" -f 2)"
	source=$(echo $request | cut -s -d "~" -f 3)
	tags=$(echo $request | cut -s -d "~" -f 4)
	additiontext=$(echo $request | cut -s -d "~" -f 5)
	case ${chooseWhere} in
		Spass) folder=$(echo "$wikiDir/Spaß_Stream")
			l=37;;
		Physik) folder=$(echo "$wikiDir/Physik")
			l=37;;
		Mathematik) folder=$(echo "$wikiDir/Mathematik")
			l=37;;
		Blogging) folder=$(echo "$wikiDir/Blogging")
			l=37;;
		Philosophie) folder=$(echo "$wikiDir/Philosophie")
			l=37;;
		Naturwissenschaften_und_Instrumentarien) folder=$(echo "$wikiDir/Naturwissenschaften_und_Instrumentarien")
			l=37;;
		CodeFabrik) folder=$(echo "$wikiDir/CodeFabrik")
			l=37;;
		Zettelkasten) folder=$(echo "$wikiDir/Zettelkasten")
			l=37;;
	esac

	if [[ ! "$topic" = "" ]];
	then
		topicfilename=$(cleanName "${topic}")
		topicfile="${topicfilename}.md"
		touch "${folder}"/"${topicfile}"
		mkdir -p "${folder}"/"${topicfilename}"
		
		
		##### additiontext="$additiontext\n${tabs}"
				
		create-note "$folder" "${topicfilename}" "$tags" "$source" "$additiontext" >> "$folder"/"${topicfile}"
		
		#*tabsession to note}}
		
		echo -e "	[*] $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")" >> "${folder}".md
		echo -e "		[*] [[+$(basename ${topicfile} .md)|${topic}]]" >> "${folder}".md
	fi
fi
```

### Tabs in sessions to note

*tabsession to note*
```bash
tabSessionName="2»websession_$(date +"%Y-%m-%d")"
if [[ ! -e "$folder"/"${topicfilename}"/"$tabSessionName.md" ]]
then
	#additiontext="$additiontext\n[[+$tabSessionName]]"
	echo "[[+$tabSessionName]]" >> "$folder"/"${topicfile}"
fi
echo "$tabs" >> "$folder"/"${topicfilename}"/"$tabSessionName.md"
```


### Tabs in sessions to topics

*tabsession to topics*
```bash
case ${choose} in
	Spass) folder=$(echo "$wikiDir/Spaß_Stream/0»Journal_1_Spaß_Stream")
		l=5;;
	Zettelkasten) folder=$(echo "$wikiDir/Zettelkasten/0»Journal_Zettelkasten")
		l=5;;
	Heute) tabs2today.sh $additiontext
		exit
		;;
	Physik) folder=$(echo "$wikiDir/Physik/0»Journal_Physik")
		l=5;;
	Mathematik) folder=$(echo "$wikiDir/Mathematik/0»Journal_Mathematik")
		l=5;;
	Blogging) folder=$(echo "$wikiDir/Blogging/0»Journal_Blogging")
		l=5;;
	Philosophie) folder=$(echo "$wikiDir/Philosophie/0»Journal_Philosophie")
		l=5;;
	Naturwissenschaften_und_Instrumentarien) folder=$(echo "$wikiDir/Naturwissenschaften_und_Instrumentarien/0»Journal_Naturwissenschaften_und_Instrumentarien")
		l=5;;
	CodeFabrik) folder=$(echo "$wikiDir/CodeFabrik/0»Journal_1_CodeFabrik")
		l=5;;
esac
today=$(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")

tabSessionName="2»websession_$(date +"%Y-%m-%d")"
if [[ ! -e "$folder"/"$tabSessionName.md" ]]
then
	mkdir -p "$folder"
	file="$folder.md"
	sed -i "${l}i
	" "$file"
	element=""
	sed -i "${l}i $additiontext[[+$tabSessionName]]" "$file"
	sed -i "${l}i
	" "$file"
	sed -i "${l}s/^/==== $today ====/g" "$file"
	sed -i "${l}i
	" "$file"
fi
echo "$tabs" >> "$folder"/"$tabSessionName.md"
```





### Tabs to topics

*tabs to topics*
```bash
case ${choose} in
	Spass) file=$(echo "$wikiDir/Spaß_Stream/0»Journal_1_Spaß_Stream.md")
		l=5;;
	Zettelkasten) file=$(echo "$wikiDir/Zettelkasten/0»Journal_Zettelkasten.md")
		l=5;;
	Heute) tabs2today.sh $additiontext
		exit
		;;
	Physik) file=$(echo "$wikiDir/Physik/0»Journal_Physik.md")
		l=5;;
	Mathematik) file=$(echo "$wikiDir/Mathematik/0»Journal_Mathematik.md")
		l=5;;
	Blogging) file=$(echo "$wikiDir/Blogging/0»Journal_Blogging.md")
		l=5;;
	Philosophie) file=$(echo "$wikiDir/Philosophie/0»Journal_Philosophie.md")
		l=5;;
	Naturwissenschaften_und_Instrumentarien) file=$(echo "$wikiDir/Naturwissenschaften_und_Instrumentarien/0»Journal_Naturwissenschaften_und_Instrumentarien.md")
		l=5;;
	CodeFabrik) file=$(echo "$wikiDir/CodeFabrik/0»Journal_1_CodeFabrik.md")
		l=5;;
esac
#echo $tabs
today=$(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")

sed -i "${l}i
" "$file"
element=""
lines="$(wc --lines <<< "$tabs")"
for (( i=$lines ; i>=1 ; i-- ));
do
	element=$(sed -n "${i}p" <(echo "$tabs"))
	echo "$element"
	if (($i % 2 != 0));
	then
		element=$(cleanName "${element}")
		#title=$(cleanName "${title}")
		echo "$element"
	fi
	#echo ${i}
	sed -i "${l} s,^,$element," "$file"
	if [[ $i > 1 ]]
	then
		sed -i "${l}i
		" "$file"
	fi
done
sed -i "${l}i $additiontext" "$file"
sed -i "${l}i
" "$file"
sed -i "${l}s/^/==== $today ====/g" "$file"
sed -i "${l}i
" "$file"
```
