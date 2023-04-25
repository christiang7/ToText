# tts
Created Donnerstag [Zettelkasten:2022:02:24]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

* ☑ FRAGMENT **tts**  

Anzeige von Dateien deren Text Beschreibung

Hier sind die Dolpin ServiceMenüs
[KDE-Servicemenüs › Wiki › ubuntuusers-de]()


* ☑ WEB How to get File Name and extension in bash|shell script programming <https://www.w3schools.io/terminal/bash-extract-file-extension/>
* ☑ WEB Bash Scripting - How to check If File Exists - GeeksforGeeks <https://www.geeksforgeeks.org/bash-scripting-how-to-check-if-file-exists/>
* ☑ WEB Zenity - Create GUI Dialog Boxes In Bash Scripts - OSTechNix <https://ostechnix.com/zenity-create-gui-dialog-boxes-in-bash-scripts/>
* ☑ WEB Bash Conditional Statements - OSTechNix <https://ostechnix.com/bash-conditional-statements/>



Anzeige von Dateien deren Text Beschreibung

  ``noweb.py -Rtts tts.txt > tts && chmod u+x tts && echo 'fertig``'

```ini
<<tts>>=
#!/bin/bash
f=$(basename "$1")
extens=${f##*.}
filename=${f%.*} #only the filename
File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
#f=$(basename "$1")
line=$(head -n 1 "$File".txt)
#extens=${f##*.}
#Newname=$(echo $filename)

if [[ -e "$filename".txt && ! -d "$filename" ]]; 
	then
	ttvidc "$f"
elif [[ -e "$File".txt ]] 
	then
	echo $line
	if [[ "$line" != "Content-Type: text/x-zim-wiki" ]] 
		then
		#echo falsch
		ttnc "$f"
	fi
	xdg-open "$File" &
	#echo test

else
	Newname=$(zenity --entry \
       --width 500 \
       --title "Die Datei eine Beschreibung geben?" \
       --text "Den Dateinamen dazu noch ändern?" \
       --entry-text "$filename")

	if [ ! $? -eq 1 ]; 
	then

  if [[ $extens == $f ]]
  then
  	File=$(echo "$Newname" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g')
  else
  File=$(echo "$Newname"."$extens" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/\///g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g')
  fi
  mv "$f" "$File"
	ttn "$File"
	fi

fi

if [[ $extens == tex ]] 
then
filename =$(basename "$File" .tex)
kate "$filename"-tex.txt
xdg-open "$File" &
elif [[ jpg == $extens || png == $extens || webp == $extens || jpeg == $extens || avif == $extens ]]
then
	kate "$filename".avif.txt &
	xdg-open "$filename".avif &
else
kate "$File".txt 2>/dev/null &
xdg-open "$File" &
fi


@ 
```

