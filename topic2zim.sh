#! /bin/bash

request=$(yad --title="Notes or archiv" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Quelle:":CB \
	--field="Weiteres":TXT \
	"Spass,NeuNotiz,Assets,Heute,Physik,Mathematik,Philosophie,Naturwissenschaften_und_Instrumentarien,CodeFabrik" "")
choose=$(echo $request | cut -s -d "~" -f 1)
additiontext=$(echo $request | cut -s -d "~" -f 2)
if [ ! $? -eq 1 ];
then
	tabs="$(xclip -selection clipboard -o)"
	l="" # lineposition of the desired file

	case ${choose} in
	NeuNotiz)
		request=$(yad --title="Which topic" --text="Something to add?" \
			--form --width 500 --separator="~" --item-separator=","  \
			--field="Where:":CB \
			--field="Topic:" \
			--field="Source:":CBE \
			--field="Tags:" \
			--field="Something else":TXT \
			"Spass,Assets,Physik,Mathematik,Philosophie,Naturwissenschaften_und_Instrumentarien,CodeFabrik,Zettelkasten" "Topicname" "Internet,Christian Gößl," "" "$additiontext")

		if [ ! $? -eq 1 ];
		then
		    chooseWhere=$(echo $request | cut -s -d "~" -f 1)
		    topic=$(echo $request | cut -s -d "~" -f 2)
		    source=$(echo $request | cut -s -d "~" -f 3)
		    tags=$(echo $request | cut -s -d "~" -f 4)
		    additiontext=$(echo $request | cut -s -d "~" -f 5)
		    case ${chooseWhere} in
		        Spass) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Spaß_Stream")
		            l=37;;
		        Assets) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Assets")
		            l=37;;
		        Physik) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Physik")
		            l=37;;
		        Mathematik) folder=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Mathematik")
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
				topicfile=$(echo "${topic}" | sed 's/ /_/g' | sed 's/:/;/g' | sed -e "s/'/_/g" | sed 's/\"//g'|  sed 's/&/n/g' | sed 's/|//g' | sed 's/\[/(/g' | sed 's/\]/)/g' | sed 's/@/at/g' | sed 's/¦//g' | sed 's/?/.ß/g').md
				topicfilename=$(basename "$topicfile" .md)
				touch "${folder}"/"${topicfile}"
				mkdir -p "${folder}"/"${topicfilename}"
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
			fi
		fi
		;;
	*)
		case ${choose} in
		    Spass) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Spaß_Stream/Spaß_Stream_Archiv.md")
		        l=5;;
		    Assets) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Assets/Assets_Archiv.md")
		        l=5;;
		    Heute) tabs2zim.sh
		        exit
		        ;;
		    Physik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Physik/Physik_Archiv.md")
		        l=5;;
		    Mathematik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Mathematik/Mathematik_Archiv.md")
		        l=5;;
		    Philosophie) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Philosophie/Philosophie_Archiv.md")
		        l=5;;
		    Naturwissenschaften_und_Instrumentarien) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Naturwissenschaften_und_Instrumentarien/Naturwissenschaften_und_Instrumentarien_Archiv.md")
		        l=5;;
		    CodeFabrik) file=$(echo "/home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/CodeFabrik_Archiv.md")
		        l=5;;
		esac
		#echo $tabs
		today=$(date +"[[Zettelkasten:%Y:%m:%d|%Y-%m-%d]]")
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
		;;
	esac
fi
