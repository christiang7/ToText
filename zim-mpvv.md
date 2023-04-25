# zim-mpvv

* ☑ @ArcPROGRAMM @Zim @VIDEO **zim-mpvv**  

Created Samstag [Zettelkasten:2021:04:24]()
Backlink [Zettelkasten:2021:04:24]()

Kommando zum Extrahieren des Scripts

``noweb.py -Rzim-mpvv zim-mpvv.md > zim-mpvv && echo 'fertig'``

hier die zim-script Datei zum Ausführen

~~~bash
	<<zim-mpvv>>=
	#!/bin/bash
	#xterm -e "mpvv '$1'; bash" &
	konsole --hold -e sh -c "mpvv $1 ; exec bash" &
	@
~~~
