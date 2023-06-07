rssfile=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/rss-source.rss")
sed -i "$ d" $rssfile
tabs="$(xclip -selection clipboard -o)"
#today=$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")
lines="$(wc --lines <<< "$tabs")"
lines="$(echo $(($lines/2)))"
head -n -1 $rssfile > tmp.txt && mv tmp.txt $rssfile
for (( i=1 ; i<=$lines ; i++ ));
do
      title=$(sed -n "${i}p" <(echo "$tabs"))
      l="$( echo $(($i+1)) )"
      element=$(sed -r -n "${l}p" <(echo "$tabs"))
      echo "<item>" >> $rssfile
      echo "<title> $title </title>" >> $rssfile
      echo "<link> $element </link>" >> $rssfile
      #<pubDate>Di, 26. Nov. 2013, 12:15:12 GMT</pubDate> >> $rssfile
      echo "<description> $title </description>" >> $rssfile
      echo "</item>" >> $rssfile
done
echo "</channel>" >> $rssfile
echo "</rss>" >> $rssfile
