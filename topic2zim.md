# topic2zim
Created Dienstag [Zettelkasten:2022:10:25]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

- [X] **topic2zim**
	- [X] Doing
	- [X] Backlog

## Features

Combination with the program [tabs2zim](tabs2zim.md).
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
noweb.py -Rtopic2zim.sh topic2zim.md > topic2zim.sh && echo 'topic2zim.sh' && date
```

```bash
chmod u+x topic2zim.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/ZetteL/CodeFabrik/GedankenspeicherCoding/topic2zim.sh ~/.local/bin/topic2zim.sh && echo 'fertig'
```


### Main program

*topic2zim.sh*
```bash
#! /bin/bash

#*request}}

@
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
		#*tabs to topics}}
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
	"Spass,Physik,Mathematik,Blogging,Philosophie,CodeFabrik,Zettelkasten" "Topicname" "Internet,Christian Gößl," "" "$additiontext")

if [ ! $? -eq 1 ];
then
	chooseWhere=$(echo $request | cut -s -d "~" -f 1)
	topic="2»$(echo $request | cut -s -d "~" -f 2)"
	source=$(echo $request | cut -s -d "~" -f 3)
	tags=$(echo $request | cut -s -d "~" -f 4)
	additiontext=$(echo $request | cut -s -d "~" -f 5)
	case ${chooseWhere} in
		Spass) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Spaß_Stream")
			l=37;;
		Physik) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Physik")
			l=37;;
		Mathematik) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Mathematik")
			l=37;;
		Blogging) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Blogging")
			l=37;;
		Philosophie) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Philosophie")
			l=37;;
		Naturwissenschaften_und_Instrumentarien) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Naturwissenschaften_und_Instrumentarien")
			l=37;;
		CodeFabrik) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik")
			l=37;;
		Zettelkasten) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten")
			l=37;;
	esac

	if [[ ! "$topic" = "" ]];
	then
		topicfile="$(echo "${topic}" | sed 's/ /_/g' | sed 's/:/;/g' | sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/¦//g' | sed 's/?/.ß/g').md"
		topicfilename=$(basename "$topicfile" .md)
		touch "${folder}"/"${topicfile}"
		mkdir -p "${folder}"/"${topicfilename}"
		#*zim template}}
	fi
fi
```


#### zim template


*zim template*
```bash
echo "Content-Type: text/x-zim-wiki" > "${folder}"/"${topicfile}"
echo "Wiki-Format: zim 0.6" >> "${folder}"/"${topicfile}"
echo -e "====== ${topic} ======" >> "${folder}"/"${topicfile}"
echo -e "Created $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> "${folder}"/"${topicfile}"
#echo -e "" >> "${folder}"/"${topicfile}"
echo -e "[*] ${tags} ** ${topic} ** [[$(basename ${folder})]] " >> "${folder}"/"${topicfile}"
echo -e "\n${additiontext}" >> "${folder}"/"${topicfile}"
echo -e "\n${tabs}" >> "${folder}"/"${topicfile}"
echo -e "		[*] $(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")" >> "${folder}".md
echo -e "			[*] [[+$(basename ${topicfile} .md)|${topic}]]" >> "$folder".md
```


#### markdown template


*markdown template*
```bash
echo -e "# ${topic}" >> "${folder}"/"${topicfile}"
echo -e "Created $(date +"[[Zettelkasten/%Y/%m/%d|%Y-%m-%d]]")" >> "${folder}"/"${topicfile}"
#echo -e "" >> "${folder}"/"${topicfile}"
echo -e "- [X] ${tags} ** ${topic} ** [[$(basename ${folder})]] " >> "${folder}"/"${topicfile}"
echo -e "\n${additiontext}" >> "${folder}"/"${topicfile}"
echo -e "\n${tabs}" >> "${folder}"/"${topicfile}"
echo -e "		- [X] $(date +"[[Zettelkasten/%Y/%m/%d|%Y-%m-%d]]")" >> "${folder}".md
echo -e "			- [X] [[/$(basename ${topicfile} .md)|${topic}]]" >> "$folder".md
```

### Tabs to topics

*tabs to topics*
```bash
case ${choose} in
	Spass) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Spaß_Stream/0»Journal_1_Spaß_Stream.md")
		l=5;;
	Zettelkasten) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/0»Journal_Zettelkasten.md")
		l=5;;
	Heute) tabs2zim.sh $additiontext
		exit
		;;
	Physik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Physik/0»Journal_Physik.md")
		l=5;;
	Mathematik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Mathematik/0»Journal_Mathematik.md")
		l=5;;
	Blogging) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Blogging/0»Journal_Blogging.md")
		l=5;;
	Philosophie) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Philosophie/0»Journal_Philosophie.md")
		l=5;;
	Naturwissenschaften_und_Instrumentarien) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Naturwissenschaften_und_Instrumentarien/0»Journal_Naturwissenschaften_und_Instrumentarien.md")
		l=5;;
	CodeFabrik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/0»Journal_1_CodeFabrik.md")
		l=5;;
esac
#echo $tabs
today=$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")

## today=$(date +"[[Zettelkasten/%Y/%m/%d|%Y-%m-%d]]")

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
		element=$(echo "${element}" | sed 's/\//-/g' | sed 's/:/;/g' | sed 's/:/;/g' | sed "s/|/;/g" | sed "s/·/;/g" | sed "s/💤/;/g")
		#title=$(echo "${title}" | sed 's/\//-/g' | sed 's/:/;/g' | sed "s/|/;/g" | sed "s/·/;/g" | sed "s/💤/;/g")
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
