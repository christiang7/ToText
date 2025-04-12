# rss-feed-reinsert
Created [2023-06-07]()

- [x]  **rss-feed-reinsert**  [README.md](README.md)
   - [x] Doing
	  - [ ] Einen Download Stream einfügen
   - [x] Backlog

## Featuress

This program can only save web articles, not files for read it later.
There are options to choose in which place the tabs should be stored.

## Infos

## Program

*make.sh*
```bash
noweb.py -Rrss-feed-reinsert.sh rss-feed-reinsert.md > rss-feed-reinsert.sh && echo 'fertig'
```


### rss-feed-reinsert.sh

*rss-feed-reinsert.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
wikiDir="$(config_get wikiDir)"
source tt-lib.sh;
#*request}}
```

### Request

*request*
```bash
choose=$(yad --title="RSS insert" --text="Which topic?" \
		--form --width 500 --separator="" --item-separator=","  \
		--field="Show file:":CB \
		"Spass,Physik,Mathematik,Philosophie,Naturwissenschaften_und_Instrumentarien,CodeFabrik,Download" )
if [ ! $? -eq 1 ];
then
   #*insert-feeds}}
fi
```

### Choose of the files

*choose*
```bash
case ${choose} in
   Spass) rssfile=$(echo "$wikiDir/Spaß_Stream/Spass_Stream-rss.md")
	  ;;
   Assets) rssfile=$(echo "$wikiDir/Zettelkasten/Zettelkasten-rss.md")
	  ;;
   Physik) rssfile=$(echo "$wikiDir/Physik/Physik-rss.md")
	  ;;
   Mathematik) rssfile=$(echo "$wikiDir/Mathematik/Mathematik-rss.md")
	  ;;
   Philosophie) rssfile=$(echo "$wikiDir/Philosophie/Philosophie-rss.md")
	  ;;
   Naturwissenschaften_und_Instrumentarien) rssfile=$(echo "$wikiDir/Naturwissenschaften_und_Instrumentarien/Naturwissenschaften_und_Instrumentarien-rss.md")
	  ;;
   CodeFabrik) rssfile=$(echo "$wikiDir/CodeFabrik/CodeFabrik-rss.md")
	  ;;
   Download) rssfile=$(echo "$wikiDir/CodeFabrik/Download-rss.md")
	  ;;
esac
```

### Insert the feeds

*insert-feeds*
```bash
#*choose}}

sed -i "$ d" $rssfile
#tabs="$(xclip -selection clipboard -o)"
tabs="$(wl-paste -n)"
lines="$(wc --lines <<< "$tabs")"
#lines="$(echo $(($lines/2)))"
head -n -1 $rssfile > tmp.txt && mv tmp.txt $rssfile
for (( i=1 ; i<=$lines ; i=i+2 ));
do
	  title=$(sed -n "${i}p" <(echo "$tabs"))
	  title=$(cleanName "$title")
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
