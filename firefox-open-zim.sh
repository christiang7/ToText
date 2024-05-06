url=$(echo "$1" | sed "s,http://localhost:8080/,," | sed "s,.html,,"  | sed "s,/,:,g")
cd ~
./Programme/zim/zim.py --gui Gedankenspeicherwiki "$url"
