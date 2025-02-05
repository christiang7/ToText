#! /bin/bash
yad --title="Create dot diagram in zim?" --text="\n Create dot diagram in zim\n"
if [ ! $? -eq 1 ];
then
    File=$(echo "$1" | sed 's/ /_/g' | sed 's/:/;/g'| sed -e "s/'/_/g" | sed 's/\"//g')
    filename=${File%.*}
    mkdir -p "$filename"
    noweb.py -Rdiagram.dot "$File" > "$filename"/diagram.dot
    dot -Tpng "$filename"/diagram.dot -o "$filename"/diagram.png
    echo "{{./diagram.png?type=diagram}}"
    #echo "$1" "$2" "$3" > ~/log.md
fi
