#! /bin/bash
source tt-lib.sh
if zenity --question --text="Möchten Sie dieses Programm: ttd ausführen?"
then
    File=$(cleanName "$1")
    filename=${File%.*}
    mkdir -p "$filename"
    ttd "$filename"
fi
