# wgettwpdf

* ☑ >2277-11-11 @AkPROGRAMM **wgettwpdf**  

Angelegt Donnerstag [Zettelkasten:2021:05:20]()
Backlink [GedankenspeicherCoding](../GedankenspeicherCoding.md)

Projekt ist erfüllt durch die wgett Programme
ist das Testprojekt dafür



``noweb.py -Rwgettwpdf wgettwpdf.md > wgettwpdf && chmod u+x wgettwpdf && echo 'fertig'``

```bash
#<<wgettwpdf>>=
#!/bin/bash
folder=$(date +"/home/christian/Gedankenspeicher/Gedankenspeicherwiki/Zettelkasten/%Y/%m/%d")
mkdir -p $folder
cd $folder
7z a www.plasma-mobile.org www.plasma-mobile.org/
wget -P $(basename $1) --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" -nd  --no-use-server-timestamps --load-cookies=cookies.txt -level=0 -pk --adjust-extension -e robots=off $1
File=$(wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" $1 2>&1 | grep Wird | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')
#wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" -O $File $1
ttpdf $File $1
@
```




