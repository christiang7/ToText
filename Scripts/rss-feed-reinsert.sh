#!/bin/bash
source config.sh; # load the config library functions
GedankenspeicherwikiDir="$(config_get GedankenspeicherwikiDir)"
source tt-lib.sh;
choose=$(zenity --height 350 --list --radiolist --print-column ALL --hide-header --column "Checkbox" --column "What" True Spass FALSE Assets FALSE Physik FALSE Mathematik FALSE Philosophie FALSE Naturwissenschaften_und_Instrumentarien FALSE CodeFabrik FALSE Download)
if [ ! $? -eq 1 ];
then
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
fi
