# zim-filepath
Created Sonntag [2022-11-06]()
- [X] **zim-filepath** [README](README.md)


## Information

- [X] WEB bash - Readlink - How to crop full path? - Stack Overflow

 <https://stackoverflow.com/questions/26341845/readlink-how-to-crop-full-path>

- [X] WEB readlink() — Read the value of a symbolic link - IBM Documentation

 <https://www.ibm.com/docs/en/zos/2.4.0?topic=functions-readlink-read-value-symbolic-link>


## Program

*run-cell.sh*
```bash
noweb.py -Rzim-filepath.sh zim-filepath.md > zim-filepath.sh && echo 'fertig'
```


```bash
chmod u+x zim-filepath.sh && ln -sf $(pwd)/zim-filepath.sh ~/.local/bin/zim-filepath.sh && echo 'fertig'
```

## Main Program

*zim-filepath.sh*
```bash
#!/bin/bash
source config.sh; # load the config library functions
homeDir="$(config_get homeDir)"
wikiDir="$(config_get wikiDir)"

file=$(readlink -f -n "$1")
filepath=$(echo "${file%/*}" | sed "s,$homeDir,~,")
wikipath=$(echo $filepath | sed "s,$wikiDir,," | sed "s,/,:,g")
FullFilename=$(basename $file .md)
outputText="[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]"
#echo -e $outputText
echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection primary
echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection clipboard
wlexecution=$(echo -e $outputText | wl-copy -n &)
sleep 1
killall wl-copy
exit
  #echo [[$wikipath:$FullFilename]] | xclip -selection primary
  #echo [[$wikipath:$FullFilename]] | xclip -selection clipboard
```

