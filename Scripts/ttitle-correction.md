# ttitle-correction
Created [2023:04:18]

- [x] **ttitle-correction**

## Informations

command for insert headline in 3th line in file

```bash
sed -i "3 s/\[\*/===== ansansa =====\\n\[\*/" 1681834707295.avif.md
```

in all cases it has to be done in 3th and 4th line


 sed find replace or add if nothing is found

 https://code.whatever.social/questions/22796157/sed-find-replace-or-add-if-nothing-is-found

 bash - Use sed command to apply a condition to check if a pattern has been matched - Ask Ubuntu

 https://askubuntu.com/questions/635048/use-sed-command-to-apply-a-condition-to-check-if-a-pattern-has-been-matched

 Numbering lines matching the pattern using sed

 https://code.whatever.social/questions/10577256/numbering-lines-matching-the-pattern-using-sed

 How can I check the first character in a string in Bash or Unix shell?

 https://code.whatever.social/questions/18488270/how-can-i-check-the-first-character-in-a-string-in-bash-or-unix-shell

## main program

```bash
noweb.py -Rttitle-correction.sh ttitle-correction.md > ttitle-correction.sh && echo 'fertig'
```

```bash
chmod u+x ttitle-correction.sh && ln -sf $(pwd)/ttitle-correction.sh ~/.local/bin/ttitle-correction.sh && echo 'fertig'
```

### ttitle-correction.sh
*ttitle-correction.sh*
```bash
#!/bin/bash

File=$(basename "$1")
#echo "$File"

line=$(sed -n '/\[\*\]/{=;}' $File )
line=${line:0:1}
#echo $line
if [[ $line > 5 | $line == "" ]]
then
	linee=$(sed -n '/\[\ \]/{=;}' $File )
	linee=${linee:0:1}
	sed -i "$linee s/\[ \]/====== $(basename $File .md) ======\\n\[ \]/" "$File"
else
	sed -i "$line s/\[\*\]/====== $(basename $File .md) ======\\n\[\*\]/" "$File"
fi
```

