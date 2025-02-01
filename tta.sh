#!/usr/bin/env bash
source config.sh; # load the config library functions
GedankenspeicherwikiDir="$(config_get GedankenspeicherwikiDir)"

#wikipath=$(xclip -selection clipboard -o)
wikipath="$(wl-paste -n)"
#filepath=$(xclip -selection clipboard -o | sed "s,:,/,g" | sed "s, ,_,g")
filepath="$(wl-paste -n | sed "s,:,/,g" | sed "s, ,_,g")"
filepath=$(echo $GedankenspeicherwikiDir/$filepath)

destinationfolder=$(readlink -f -n "$1")
destinationfolder="${destinationfolder%.*}"

file=$(basename "$filepath")

mkdir -p $destinationfolder

ln -s "$filepath" "$destinationfolder"/"$file"
if [[ -e "$file".png ]]
then
    ln -s "$filepath".png "$destinationfolder"/"$file".png
fi
if [[ -e "$file".avif ]]
then
    ln -s "$filepath".avif "$destinationfolder"/"$file".avif
fi

ln -s "$filepath".md "$destinationfolder"/"$file".md

