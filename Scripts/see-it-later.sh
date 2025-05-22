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
         echo "## ${website}" >> "$folder"/../"$file"
      fi
   done
fi

