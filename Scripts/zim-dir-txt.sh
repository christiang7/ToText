#! /bin/bash
source tt-lib.sh
yad --title="Execute ttd?" --text="\n All files in folder will get description files\n"
if [ ! $? -eq 1 ];
then
    File=$(cleanName "$1")
    filename=${File%.*}
    mkdir -p "$filename"
    ttd "$filename"
fi
