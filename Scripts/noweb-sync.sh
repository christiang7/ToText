#!/bin/bash
File="$(basename $1 .md)"
#echo "$File"
linenumber="$(grep -n -F -w "*$File*" $File.md | cut -d : -f 1)"
#echo $linenumber
linenumber=$((linenumber+1))
#echo $linenumber
sed -n "1,${linenumber}p" "$File".md > "$File"-.md
cat "$File"-.md "$File" > "$File"--.md
echo -e "\n\`\`\`\n" >> "$File"--.md
mv "$File"--.md "$File".md
rm "$File"-.md
touch -r "$File" "$File".md
