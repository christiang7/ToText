# Gedankenspeicher - Focus - ToText tt

- [X] Doing Interput (2)
- [X] Doing (2)
	- [ ] template-tex
		- [ ] template for rechnung
		- [ ] template for Bewerbung
- [X] Planning (2)
	- [ ] überall yad Ersatz für zenity einfügen
- [X] Backlog
	- [ ] bei der Verschiebung und Umbenennung von zim Seiten
	die zim Funktion umschreiben, so dass auch andere Dateien
	mit verschoben werden können
	- [ ] custom tool for insert page.section in file
	- [ ] [ttam](ttam)
	- [ ] xournal Programmstarter so, dass automatisch thumbnail
	aktualisiert wird und von einer pdf als Notizen abgespeichert wird
	- [ ] alles in english schreiben
	- [ ] Programme über libraries verbinden

## Features

### 2024-02-13 Zusammenlegung der Scripte tts und ttn
Zusammenlegung von tts und ttn als Option einfügen, ob Datei geöffnet werden soll danach oder nicht
tts ist gelöscht

### ttvidc corrected to markdown
ttvidc corrected to markdown and you can choose both files

### 2023-10-30 tex support in ttn and tts

### 2023-10-29 created programms template-tex.sh and texstudio-noweb-py.sh
created program template-tex.sh like template-calculation
texstudio behavior for markdown files with noweb, compilation and so on changed with script [texstudio-noweb-py.sh]

### 2023-07-03 wayland paste in zim
custom tool for insert clipboard of wayland

### 2023-06-25 open-file template-program and template-calculation
Combination of template-program and zim-template-program.
Custom tool for open file in zim.
Creation of template-calculation and zim-template-calculation.

### 2023-06-22 Insert date later and open folder zim
Custom tool [zim-date-later]() für einsetzen von "<2277-11-11" Datum für später lesen
Custom tool for open in zim the folder of the containing file.

### 2023-06-21 Zim Quoting
The program [zim-quoting-copy]() can copy a marked line. The marked line gets an anchor. The copied text can be pasted at the desired position of pages.

### 2023-05-25 Kanboardliste Dateheadlines
[kanboardlist.md](kanboardlist.md) Programm zum Einfügen von Kanboardlisten in zim wiki
[zim-dateheadlines.md](zim-dateheadlines.md) Einfügen von Überschriften mit Datum im zim-wiki


## Description
The project called Gedankenspeicher is a collection of scripts for using an annotation system with **md** files. It builds upon the desktop wiki [GitHub - zim-desktop-wiki/zim-desktop-wiki: Main repository of the zim desktop wiki project](https://github.com/zim-desktop-wiki/zim-desktop-wiki). The **md** files are describing every given file on your file system. The created **md** file is showing up in zim. So you can search and annotate a file in zim wiki. Some scripts connect zim with the file manager perhaps [dolphin]([Dolphin - KDE Applications](https://apps.kde.org/dolphin/)) and the web browser [firefox](https://www.mozilla.org/en-US/firefox/new/). The scripts are working on Linux machines like Ubuntu, Archlinux, Fedora, Suse. The Gedankenspeicher uses the following tools:

- wget

- xidel

- scrot

- sed

- zenity and yad

- firefox addon application

- firefox addon zim clip

- noweb

- mypaint

- krita

- xournalpp

- yt-dlp

- mpv player

The scipts starts with the shortcut tt for ToText. 
