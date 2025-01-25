# wget-download-firefox

- [X] @ArcPROJEKT **wget-download-firefox **

Created Dienstag [Zettelkasten:2021:04:20]()
Backlink [Zettelkasten:2021:04:20]()

Kommando zum Extrahieren des Scripts

``noweb.py -Rwget-dd.sh wget-download-firefox.md > wget-download-firefox/wget-dd.sh && chmod u+x wget-download-firefox/wget-dd.sh && echo 'fertig'``

hier die zim-script Datei zum Ausführen


*wget-dd.sh*
```bash
#!/bin/bash
cd ~/Downloads/
xterm -e 'wget $1'
```

Es ist möglich über wget selbst die Downloads zu machen mittels entweder dem Addon 1 oder Addon 2

mittels addon 

- [X] Download with Wget – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/download-with-gnu-wget/>

kann man in der Kommandozeile eingeben 
executable
  ``xterm``
Arguments
  ``-hold -e 'wget --output-document="[FILENAME]" --user-agent="[USERAGENT]" --referer="[REFERRER]" --no-check-certificate --continue --load-cookies=[COOKIES] "[URL]"``'


	{{wget-u.sh}}=
	#!/bin/bash
	cd ~/Downloads/
   ``wget --output-document="$1" --user-agent="$2" --referer="$3" --no-check-certificate --continue --load-cookies=$4 "$5"``
	@

Die Dateinamen für den Download herausfinden für den Download mit wget

``wget -O 'FILENAME' 'URL' ``

Für arxiv pdf Dateien zum Downloaden

``basename $(wget --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" --server-response -q -O - "https://arxiv.org/pdf/quant-ph/0507269" 2>&1 |  grep "Location:" |  tail -1 |  awk -F"Location:" '{print $2}')``

**Das vollständige Kommando dafür**

``wget -O $(basename $(wget --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" --server-response -q -O - "$1" 2>&1 |  grep "Location:" |  tail -1 |  awk -F"Location:" '{print $2}')) --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" "$1" ``



Für alle anderen
``wget --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" --server-response -q -O - "https://very.long/url/here" 2>&1 | grep "Content-Disposition:" | tail -1 | awk -F"filename=" '{print $2}' ``


- [X] wget get name of download file - Ecosia

<https://www.ecosia.org/search?tt=mzl2&q=wget+get+name+of+download+file>

- [X] How to Rename File While Downloading with Wget in Linux

<https://www.tecmint.com/rename-downloaded-file-with-wget-in-linux/>

- [X] Saving a file downloaded with wget with a different name | The Electric Toolbox Blog

<https://electrictoolbox.com/wget-save-different-filename/>

- [X] Linux - Renaming File While Downloading with Wget - GeeksforGeeks

<https://www.geeksforgeeks.org/linux-renaming-file-while-downloading-with-wget/>

- [X] linux - wget: downloaded file name - Stack Overflow

<https://stackoverflow.com/questions/8574038/wget-downloaded-file-name>

- [X] WGET- Command, Examples and Tutorial for Downloading Files & Folders!

<https://www.webservertalk.com/wget-command-examples-and-tutorial/>

- [X] Downloading Files in Python Using wget Module – Desktop of ITers

<https://www.itersdesktop.com/2020/09/06/downloading-files-in-python-using-wget-module/>

- [X] wget arxiv pdf download - Ecosia

<https://www.ecosia.org/search?tt=mzl2&q=wget+arxiv+pdf+download>

- [X] Download pdf files using wget - Unix & Linux Stack Exchange

<https://unix.stackexchange.com/questions/331751/download-pdf-files-using-wget>

- [X] How to Download Web Pages and Files Using wget

<https://www.lifewire.com/uses-of-command-wget-2201085>

- [X] cliget – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/cliget/>

- [X] Search results for "wget" – Add-ons for Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/search/?q=wget>

- [X] Download with Wget – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/download-with-gnu-wget/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search>

- [X] GitHub - belaviyo/native-client: This is a node wrapper for Native Messaging for Windows, Linux, and Mac OS.

<https://github.com/belaviyo/native-client>

- [X] Download With an External Download Manager :: add0n.com

<https://add0n.com/download-with.html?from=wget>

- [X] Download With an External Download Manager :: add0n.com

<https://add0n.com/download-with.html?from=wget&version=0.1.8&type=install>

- [X] Options Page

moz-<extension://9607b3ec-7f13-4a1a-858a-88b5d19b11a9/data/options/index.html>

- [X] Test Download With :: WebBrowserTools

<https://webbrowsertools.com/test-download-with/>

- [X] [1607.02493] The QCD equation of state at finite density from analytical continuation

<https://arxiv.org/abs/1607.02493>



- [X] Download with Wget – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/download-with-gnu-wget/>

- [X] Download With an External Download Manager :: add0n.com

<https://add0n.com/download-with.html?from=wget>

- [X] Releases · belaviyo/native-client · GitHub

<https://github.com/belaviyo/native-client/releases>

- [X] Issues · belaviyo/download-with · GitHub

<https://github.com/belaviyo/download-with/issues>

- [X] Sound Level Meter – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/sound-level-meter/>

- [X] Sound Level Meter :: add0n.com

<https://add0n.com/sound-level-meter.html?version=0.1.0&type=install>

- [X] VectorDraw - Paint on Tab – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/vectordraw-paint-on-tab/>

- [X] Live Stream Downloader – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/live-stream-downloader/>


##### wget für webseiten Download und als pdf weiterverarbeitung

``wget -P $(basename https://www.golem.de/news/schlechte-soundqualitaet-audi-will-in-seinen-autos-kein-musik-streaming-per-bluetooth-2104-156135.html .html) -nd  --no-use-server-timestamps --load-cookies=cookies.md -level=0 -pk --adjust-extension -e robots=off https://www.golem.de/news/schlechte-soundqualitaet-audi-will-in-seinen-autos-kein-musik-streaming-per-bluetooth-2104-156135.html``



- [X] Download a complete single page with wget

<https://pyronaur.com/download-a-complete-single-page-with-wget/>

- [X] Export Cookies – Get this Extension for 🦊 Firefox (en-US)

<https://addons.mozilla.org/en-US/firefox/addon/export-cookies-txt/>

- [X] How do I use Wget to download all images into a single folder, from a URL? - Stack Overflow

<https://stackoverflow.com/questions/4602153/how-do-i-use-wget-to-download-all-images-into-a-single-folder-from-a-url>

Weiterverarbeitung über das tool 
[+HTMLDOC](./wget-download-firefox/HTMLDOC.md)
aber funktioniert nicht gut

[GedankenspeicherCoding:wgett](./wgett.md)

[GedankenspeicherCoding:wgettpic](./wgettpic.md)

[GedankenspeicherCoding:wgettpdf](./wgettpdf.md)

