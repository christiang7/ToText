# wgett

* ☑ **wgett**  

Created Donnerstag [Zettelkasten:2021:04:29]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)
 [wget-download-firefox](./wget-download-firefox.md)


``noweb.py -Rwgett wgett.txt > wgett && chmod u+x wgett && echo 'fertig``'

```awk
<<wgett>>=
#!/bin/bash
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
mkdir -p $folder
cd $folder
File=$(wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" $1 2>&1 | tee /dev/tty | grep Wird | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')
#wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" -O $File $1
tts $File $1

```



