#!/bin/bash
yad --title="Esecute $1 program?" --text="\n Selected program will be executed\n"
if [ ! $? -eq 1 ];
then
  konsole -e "$1"
fi
