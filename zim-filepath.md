# zim-filepath
Created Sonntag [2022-11-06]()
- [X] **zim-filepath** [README](README.md)



- [X] WEB bash - Readlink - How to crop full path? - Stack Overflow

 <https://stackoverflow.com/questions/26341845/readlink-how-to-crop-full-path>

- [X] WEB readlink() — Read the value of a symbolic link - IBM Documentation

 <https://www.ibm.com/docs/en/zos/2.4.0?topic=functions-readlink-read-value-symbolic-link>

  ``noweb.py -Rzim-filepath.sh zim-filepath.md > zim-filepath.sh && echo 'fertig'``


``chmod u+x zim-filepath.sh && ln -sf /home/christian/Gedankenspeicher/Gedankenspeicherwiki/CodeFabrik/GedankenspeicherCoding/zim-filepath.sh ~/.local/bin/zim-filepath.sh && echo 'fertig'``


```bash
{{zim-filepath.sh}}=
  #!/bin/bash
  file=$(readlink -f -n "$1")
  filepath=$(echo "${file%/*}" | sed "s,/home/christian,~,")
  wikipath=$(echo $filepath | sed "s,~/Gedankenspeicher/Gedankenspeicherwiki/,," | sed "s,/,:,g")
  FullFilename=$(basename $file .md)
  echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection primary
  echo -e "[[$filepath/$FullFilename]]\n[[$wikipath:$FullFilename]]" | xclip -selection clipboard
  #echo [[$wikipath:$FullFilename]] | xclip -selection primary
  #echo [[$wikipath:$FullFilename]] | xclip -selection clipboard
@
```

