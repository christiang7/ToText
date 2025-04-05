#! /bin/bash
source config.sh; # load the config library functions
journalDir="$(config_get journalDir)"
journalPage="$(config_get journalPage)"
wikiDir="$(config_get wikiDir)"
author="$(config_get author)"
source tt-lib.sh

request=$(yad --title="Notes or archiv" --text="Something to add?" \
	--form --width 500 --separator="~" --item-separator=","  \
	--field="Quelle:":CB \
	--field="Weiteres":TXT \
	"Spass,NeuNotiz,Heute,Physik,Mathematik,Blogging,Philosophie,Naturwissenschaften_und_Instrumentarien,CodeFabrik,Zettelkasten" "")
choose=$(echo $request | cut -s -d "~" -f 1)
additiontext=$(echo $request | cut -s -d "~" -f 2)
if [ ! $? -eq 1 ];
then
	#tabs="$(xclip -selection clipboard -o)"
	l="" # lineposition of the desired file
	tabs="$(wl-paste -n)"
	case ${choose} in
	NeuNotiz)
		request=$(yad --title="Which topic" --text="Something to add?" \
			--form --width 500 --separator="~" --item-separator=","  \
			--field="Where:":CB \
			--field="Topic:" \
			--field="Source:":CBE \
			--field="Tags:" \
			--field="Something else":TXT \
			"Spass,Physik,Mathematik,Blogging,Philosophie,CodeFabrik,Zettelkasten" "Topicname" "Internet,$author," "" "$additiontext")

		if [ ! $? -eq 1 ];
		then
			chooseWhere=$(echo $request | cut -s -d "~" -f 1)
			topic="2»$(echo $request | cut -s -d "~" -f 2)"
			source=$(echo $request | cut -s -d "~" -f 3)
			tags=$(echo $request | cut -s -d "~" -f 4)
			additiontext=$(echo $request | cut -s -d "~" -f 5)
			case ${chooseWhere} in
				Spass) folder=$(echo "$wikiDir/Spaß_Stream")
					l=37;;
				Physik) folder=$(echo "$wikiDir/Physik")
					l=37;;
				Mathematik) folder=$(echo "$wikiDir/Mathematik")
					l=37;;
				Blogging) folder=$(echo "$wikiDir/Blogging")
					l=37;;
				Philosophie) folder=$(echo "$wikiDir/Philosophie")
					l=37;;
				Naturwissenschaften_und_Instrumentarien) folder=$(echo "$wikiDir/Naturwissenschaften_und_Instrumentarien")
					l=37;;
				CodeFabrik) folder=$(echo "$wikiDir/CodeFabrik")
					l=37;;
				Zettelkasten) folder=$(echo "$wikiDir/Zettelkasten")
					l=37;;
			esac

			if [[ ! "$topic" = "" ]];
			then
				topicfilename=$(cleanName "${topic}")
				topicfile="${topicfilename}.md"
				touch "${folder}"/"${topicfile}"
				mkdir -p "${folder}"/"${topicfilename}"


				##### additiontext="$additiontext\n${tabs}"

				create-note "$folder" "${topicfilename}" "$tags" "$source" "$additiontext" >> "$folder"/"${topicfile}"

				tabSessionName="2»websession_$(date +"%Y-%m-%d")"
				if [[ ! -e "$folder"/"${topicfilename}"/"$tabSessionName.md" ]]
				then
					#additiontext="$additiontext\n[[+$tabSessionName]]"
					echo "[[+$tabSessionName]]" >> "$folder"/"${topicfile}"
				fi
				echo "$tabs" >> "$folder"/"${topicfilename}"/"$tabSessionName.md"

				echo -e "	[*] $(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")" >> "${folder}".md
				echo -e "		[*] [[+$(basename ${topicfile} .md)|${topic}]]" >> "${folder}".md
			fi
		fi
		;;
	*)
		######*tabs to topics}}

		case ${choose} in
			Spass) folder=$(echo "$wikiDir/Spaß_Stream/0»Journal_1_Spaß_Stream")
				l=5;;
			Zettelkasten) folder=$(echo "$wikiDir/Zettelkasten/0»Journal_Zettelkasten")
				l=5;;
			Heute) tabs2today.sh $additiontext
				exit
				;;
			Physik) folder=$(echo "$wikiDir/Physik/0»Journal_Physik")
				l=5;;
			Mathematik) folder=$(echo "$wikiDir/Mathematik/0»Journal_Mathematik")
				l=5;;
			Blogging) folder=$(echo "$wikiDir/Blogging/0»Journal_Blogging")
				l=5;;
			Philosophie) folder=$(echo "$wikiDir/Philosophie/0»Journal_Philosophie")
				l=5;;
			Naturwissenschaften_und_Instrumentarien) folder=$(echo "$wikiDir/Naturwissenschaften_und_Instrumentarien/0»Journal_Naturwissenschaften_und_Instrumentarien")
				l=5;;
			CodeFabrik) folder=$(echo "$wikiDir/CodeFabrik/0»Journal_1_CodeFabrik")
				l=5;;
		esac
		today=$(date +"[[$journalPage:%Y:%m:%d|%Y-%m-%d]]")

		tabSessionName="2»websession_$(date +"%Y-%m-%d")"
		if [[ ! -e "$folder"/"$tabSessionName.md" ]]
		then
			mkdir -p "$folder"
			file="$folder.md"
			sed -i "${l}i
			" "$file"
			element=""
			sed -i "${l}i $additiontext[[+$tabSessionName]]" "$file"
			sed -i "${l}i
			" "$file"
			sed -i "${l}s/^/==== $today ====/g" "$file"
			sed -i "${l}i
			" "$file"
		fi
		echo "$tabs" >> "$folder"/"$tabSessionName.md"

		;;
	esac
	notify-send -a "tabs2topic finished" "tabs2topic" "$(cat ~/.config/tt/log)"
fi

