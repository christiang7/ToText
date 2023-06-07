# rss-feed-reinsert
Created 2023-06-07
- [X]  **rss-feed-reinsert**  [README.md](README.md)
   - [X] Doing
   - [X] Backlog
      - [ ] Option einrichten in welche rss Datei wird der Artikel gespeichert, dafür nachschauen bei [[topic2zim]]
         - [ ] die rss Dateien für die verschiedenen Bereiche anlegen siehe [[topic2zim]]

## Featuress

This program can only save web articles not files for read it later.


`` noweb.py -Rrss-feed-reinsert.sh rss-feed-reinsert.md > rss-feed-reinsert.sh && echo 'fertig' ``


`` chmod u+x rss-feed-reinsert.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/rss-feed-reinsert.sh ~/.local/bin/rss-feed-reinsert.sh && echo 'fertig' ``

```bash
{{rss-feed-reinsert.sh}}=
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
@

```
