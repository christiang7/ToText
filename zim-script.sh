#!/bin/bash
output=$(konsole --hold -e sh -c "$1 ; exec bash")
#output=$(xterm -e "$1; bash" &)
#output=$(konsole -e "$1")
#echo $output
#zenity --info --text "Prozess ausgeführt" --title "Programm ausgeführt"
#zenity --info --text "Prozess fertiggestellt, hier ist der output: $output" --title "Prozess Fertiggestellt"
