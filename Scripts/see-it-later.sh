#!/bin/bash
source config.sh; # load the config library functions
wikiDir="$(config_get wikiDir)"
source tt-lib.sh;

folder=${wikiDir}/Atelier/see-it-later
mkdir -p $folder

typ=$(yad --title="Which type?"  \
	--form --width 500 --separator="" --item-separator=","  \
	--field="Source":CB \
	"Video,Music")
if [ ! $? -eq 1 ];
then
   text="$(wl-paste -n)"
   lines="$(wc --lines <<< "${text}")"

   website=""
   for (( i=1 ; i<=$lines ; i++ ));
   do
      website="$(echo "${text}" | sed "${i}q;d")"
      if [[ "${website:0:4}" == "http" ]]
      then
         echo "$website" >> "$folder"/../see-it-later.md
         case ${typ} in
         Video)
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
            #echo "## ${File}" >> "$folder"/../see-it-later.md
            echo "![](see-it-later/${File}.png)" >> "$folder"/../see-it-later.md
            #echo "$website" >> "$folder"/../see-it-later.md
            echo "$additiontext" >> "$folder"/../see-it-later.md
         ;;
         Music)

         ;;
         esac
      else
         echo "# ${website}" >> "$folder"/../see-it-later.md
      fi
   done
fi

