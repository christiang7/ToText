#!/bin/bash
if zenity --question --text="Möchten Sie dieses Programm: $1 : öffnen?"
then
konsole -e "$1"
fi
}}}
