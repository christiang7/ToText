# ttdel
Created Dienstag [2022:06:14]()

- [x] **ttdel**



## Features

*make.sh*
```bash
noweb.py -Rttdel ttdel.md > ttdel && echo 'fertig'
```


*ttdel*
```bash
#!/bin/bash
source config.sh; # load the config library functions
source tt-lib.sh;

yad --title="Delete files?" --text="\n Delete description file and original file \n"
if [ ! $? -eq 1 ];
then 
	File=$(basename "$1")
	
	File=$(cleanName "$File")

	File2=$(basename "$1")
	extens2=${File2##*.}
	filename2=${File2%.*} #only the filename, here the filename of the original file

	if [[ $extens2 == md ]]
	then
		rm -r "$filename2"
		rm "$filename2".avif
		rm "$filename2".png
		rm "$filename2".pdf
		rm "$filename2".pdf.png
		rm "$filename2".pdf.avif
		rm "$1"
	else
		rm -r "$1"
		rm "$File".md
		rm "$File".avif
		rm "$File".png
		rm "$File".pdf
		rm "$File".pdf.avif
		rm "$File".pdf.png
	fi
fi
```

