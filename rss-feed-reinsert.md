# rss-feed-reinsert
Created [2023-06-07]()

- [X]  **rss-feed-reinsert**  [README.md](README.md)
   - [X] Doing
	  - [ ] Einen Download Stream einfügen
   - [X] Backlog

## Featuress

This program can only save web articles not files for read it later.
There exist options to choose in which place the tabs should be stored.

## Infos

## Program

*run-cell.sh*
```bash
noweb.py -Rrss-feed-reinsert.sh rss-feed-reinsert.md > rss-feed-reinsert.sh && echo 'fertig'
```


### Main program

*rss-feed-reinsert.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
GedankenspeicherwikiDir="$(config_get GedankenspeicherwikiDir)"

#*request}}
```

### Request

*request*
```bash
choose=$(zenity --height 350 --list --radiolist --print-column ALL --hide-header --column "Checkbox" --column "What" True Spass FALSE Assets FALSE Physik FALSE Mathematik FALSE Philosophie FALSE Naturwissenschaften_und_Instrumentarien FALSE CodeFabrik FALSE Download)
if [ ! $? -eq 1 ];
then
   #*insert-feeds}}
fi
```

### Choose of the files

*choose*
```bash
case ${choose} in
   Spass) rssfile=$(echo "$GedankenspeicherwikiDir/Spaß_Stream/Spass_Stream-rss.md")
	  ;;
   Assets) rssfile=$(echo "$GedankenspeicherwikiDir/Zettelkasten/Zettelkasten-rss.md")
	  ;;
   Physik) rssfile=$(echo "$GedankenspeicherwikiDir/Physik/Physik-rss.md")
	  ;;
   Mathematik) rssfile=$(echo "$GedankenspeicherwikiDir/Mathematik/Mathematik-rss.md")
	  ;;
   Philosophie) rssfile=$(echo "$GedankenspeicherwikiDir/Philosophie/Philosophie-rss.md")
	  ;;
   Naturwissenschaften_und_Instrumentarien) rssfile=$(echo "$GedankenspeicherwikiDir/Naturwissenschaften_und_Instrumentarien/Naturwissenschaften_und_Instrumentarien-rss.md")
	  ;;
   CodeFabrik) rssfile=$(echo "$GedankenspeicherwikiDir/CodeFabrik/CodeFabrik-rss.md")
	  ;;
   Download) rssfile=$(echo "$GedankenspeicherwikiDir/CodeFabrik/Download-rss.md")
	  ;;
esac
```

### Insert the feeds

*insert-feeds*
```bash
#*choose}}

#rssfile=$(echo "$GedankenspeicherwikiDir/CodeFabrik/rss-source.rss")
sed -i "$ d" $rssfile
#tabs="$(xclip -selection clipboard -o)"
tabs="$(wl-paste -n)"
#today=$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")
lines="$(wc --lines <<< "$tabs")"
#lines="$(echo $(($lines/2)))"
head -n -1 $rssfile > tmp.txt && mv tmp.txt $rssfile
for (( i=1 ; i<=$lines ; i=i+2 ));
do
	  title=$(sed -n "${i}p" <(echo "$tabs"))
	  title=$(echo "$title" | sed 's/\//-/g' | sed 's/:/;/g' | sed 's/&/;/g' | sed "s/|/;/g" | sed "s/·/;/g" | sed "s/💤/;/g")
	  l="$( echo $(($i+1)) )"
	  element=$(sed -n "${l}p" <(echo "$tabs"))
	  echo "<item>" >> $rssfile
	  echo "<title> $title </title>" >> $rssfile
	  echo "<link> $element </link>" >> $rssfile
	  #<pubDate>Di, 26. Nov. 2013, 12:15:12 GMT</pubDate> >> $rssfile
	  echo "<description> $title </description>" >> $rssfile
	  echo "</item>" >> $rssfile
done
echo "</channel>" >> $rssfile
echo "</rss>" >> $rssfile
```
