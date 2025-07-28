# see-it-later.sh
Created [2025-03-11]()


## Description

## Journal
 - [x] Backlog
    - [ ] 
 - [x] Doing
 
## sh code

procedure

- request music or videos
- copy all wanted sites
- download description 
- download thumbnail
- insert information in see it later file


*make.sh*
```bash
noweb.py -Rsee-it-later.sh see-it-later.sh.md > see-it-later.sh && echo 'see-it-later.sh' && date
```


```bash
chmod u+x see-it-later.sh && ln -sf $(pwd)/see-it-later.sh ~/.local/bin/see-it-later.sh && echo 'fertig'
```

### see-it-later.sh

*see-it-later.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
wikiDir="$(config_get wikiDir)"
source tt-lib.sh;

typ=$(yad --title="Which type?"  \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Source":CB \
	"Video,Music")
if [ ! $? -eq 1 ];
then
   case ${typ} in
   Video)
      file="2»ws-2019-01-01-Video-Stream.md"
   ;;
   Music)
      file="2»ws-2019-01-01-Musik-Stream.md"
   ;;
   esac
   filename=$(basename $file .md)
   folder=${wikiDir}/Atelier/"$filename"
   mkdir -p $folder
   
   text="$(wl-paste -n)"
   lines="$(wc --lines <<< "${text}")"

   website=""
   for (( i=1 ; i<=$lines ; i++ ));
   do
      website="$(echo "${text}" | sed "${i}q;d")"
      if [[ "${website:0:4}" == "http" ]]
      then
         echo "$website" >> "$folder"/../"$file"
         case ${typ} in
         Video)
            ###*Video list}}
         ;;
         Music)
            ###*Video list}}
            ###*Music list}}
         ;;
         esac
      else
         echo "## ${website}- $(date +"%Y-%m-%d")" >> "$folder"/../"$file"
      fi
   done
fi

```

### Video list

*Video list*
```bash
echo $website
yt="$(echo "$website" | grep youtube)"
twitch="$(echo "$website" | grep twitch)"
alttwitch="$(echo "$website" | grep safetwitch)"
invidious="$(echo "$website" | grep invidious)"
aeon="$(echo "$website" | grep aeon)"
vimeo="$(echo "$website" | grep vimeo)"
if [[ ! $yt == "" ]];
then
   additiontext=$(yt-dlp --get-description "$website")
elif [[ ! $alttwitch == "" ]];
then
   videoid=$(basename $website)
   website="https://www.twitch.tv/videos/${videoid}"
   #additiontext=$(links2 -dump ${website})
   additiontext=$(yt-dlp --get-description "$website")
elif [[ ! $twitch == "" ]];
then
   #additiontext=$(links2 -dump ${website})
   additiontext=$(yt-dlp --get-description "$website")
elif [[ ! $invidious == "" ]];
then
   #additiontext=$(links2 -dump ${website})
   additiontext=$(yt-dlp --get-description "$website")
elif [[ ! $aeon == "" || ! "$vimeo" = "" ]];
then
   #additiontext=$(links2 -dump ${website})
   additiontext=$(yt-dlp --get-description "$website")
else
   #additiontext=$(links2 -dump ${website})
   additiontext=$(yt-dlp --get-description "$website")
fi
###*pictures}}

echo "$additiontext" >> "$folder"/../"$file"
notify-send -a "see-it-later.sh finished" "$file"
```

*Music list*
```bash

```

*pictures*
```bash
ofile=$(yt-dlp --print filename -s "${website}" -o '%(title)s').mp4
oname=${ofile%.*}
yt-dlp -q --write-thumbnail --skip-download -i ${website} -o "$folder/%(title)s"
File=$(cleanName "$oname")
echo ${File}
convert "$folder"/"$oname".jpg "$folder"/"$File".png
convert "$folder"/"$oname".jpeg "$folder"/"$File".png
convert "$folder"/"$oname".webp "$folder"/"$File".png
#convert "$folder"/"$oname".png "$folder"/"$File".jpg
rm "$folder"/"$oname".webp
rm "$folder"/"$oname".jpg
rm "$folder"/"$oname".jpeg
#rm "$folder"/"$oname".png
#echo "## ${File}" >> "$folder"/../"$filename"
echo "![](see-it-later/${File}.png)" >> "$folder"/../"$filename"
#echo "$website" >> "$folder"/../"$filename"
```


