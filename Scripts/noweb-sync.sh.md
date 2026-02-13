===== noweb-sync.sh =====
# noweb-sync.sh
Created 2026-01-09


## Description

## Journal
 - [x] Backlog
    - [ ] 
 - [x] Doing
 
bash - How can I split a large text file into smaller files with an equal number of lines? - Stack Overflow I've got a large (by number of lines) plain text file that I'd like to split into smaller files, also by number of lines.  So if my file has around 2M lines, I'd like to split it up into 10 files t...  
https://stackoverflow.com/questions/2016894/how-can-i-split-a-large-text-file-into-smaller-files-with-an-equal-number-of-lin  
shell script - I want to find lines where a specific word appears in a file along with line number and take the line numbers in an array .How to do that in bash? - Unix & Linux Stack Exchange This returns line numbers but they are in a string:
grep -n -F -w $word $file | cut -d : -f 1  
https://unix.stackexchange.com/questions/754798/i-want-to-find-lines-where-a-specific-word-appears-in-a-file-along-with-line-num  
Bash Math Operations (Bash Arithmetic) Explained {+11 Examples} Learn how to solve math from the Bash terminal directly to automate calculations in your Bash scripts in this easy tutorial.  
https://phoenixnap.com/kb/bash-math  

## sh code


*make.sh*
```bash
noweb.py -Rnoweb-sync.sh noweb-sync.sh.md > noweb-sync.sh && echo 'noweb-sync.sh' && notify-send -a "Compilation of noweb-sync.sh" "" "$(date +"%Y-%m-%d") fertig" 
```


```bash
chmod u+x noweb-sync.sh && ln -sf $(pwd)/noweb-sync.sh ~/.local/bin/noweb-sync.sh && echo 'fertig'
```


```bash
sed -n '1,100p' Video-list.md 
grep -n -F -w "*Download-File.sh*" Download-File.md | cut -d : -f 1
```



*noweb-sync.sh*
```bash
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
```

