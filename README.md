# ToText tt

## Description
The project called ToText is a collection of bash scripts for using an annotation system with **md** files. It builds upon the desktop wiki [GitHub - zim-desktop-wiki/zim-desktop-wiki: Main repository of the zim desktop wiki project](https://github.com/zim-desktop-wiki/zim-desktop-wiki). The **md** files are describing every given file on your file system. The created **md** file is showing up in zim. So you can search and annotate a file in zim wiki. Some scripts connect zim with the file manager [dolphin]([Dolphin - KDE Applications](https://apps.kde.org/dolphin/)) and the web browser [firefox](https://www.mozilla.org/en-US/firefox/new/). The scripts are working on Linux machines like Ubuntu, Archlinux, Fedora, Suse. The ToText uses the following tools:

- wget

- xidel

- scrot

- sed

- zenity and yad

- firefox addon external application

- firefox addon zim clip

- noweb - noweb.py repository

- mypaint

- krita

- xournalpp

- yt-dlp

- mpv player

The scipts starts with the shortcut tt for ToText. 

## Journal

- [X] Backlog
	- [ ] rewrite [ttdm] with [ttnm]
	- [ ] custom tool for insert page.section in file
	- [ ] [ttam](ttam)
	- [ ] xournal Programmstarter so, dass automatisch thumbnail
	aktualisiert wird und von einer pdf als Notizen abgespeichert wird
	- [ ] rewrite everything in english
	- [ ] links for used tools in README file
	- [ ] make a website for tt
	- [ ] write blog post for website
- [X] Planning (2)
	- [ ] replace zenity with yad
- [X] Doing (2)
	- [ ] connect programs with libraries
		- [X] shell library for cleaning filenames
		- [X] shell library for markdown template
		- [X] shell library for zim template
		- [X] template function for nodes for files and usable with library inclusion
		- [ ] pdf function
		- [ ] video function
		- [ ] rewrite them

### 2025-02-01
- [X] publish on github
- [X] using a config file for the path and variables
	- [X] create config dir
	- [X] set standard variables
	- [X] script for reading config file
	- [X] rewrite programs for standard variables

### 2024-08-08 template tex
- [X] template-tex
	- [X] template for rechnung
	- [X] template for Bewerbung

### 2024-02-13 combined scripts tts und ttn

### ttvidc corrected to markdown
ttvidc corrected to markdown and you can choose both files

### 2023-10-30 tex support in ttn and tts

### 2023-10-29 created programms template-tex.sh and texstudio-noweb-py.sh
created program template-tex.sh like template-calculation
texstudio behavior for markdown files with noweb, compilation and so on changed with script [texstudio-noweb-py.sh](texstudio-noweb-py.sh)

### 2023-07-03 wayland paste in zim
custom tool for insert clipboard of wayland

### 2023-06-25 open-file template-program and template-calculation
Combination of template-program and zim-template-program.
Custom tool for open file in zim.
Creation of template-calculation and zim-template-calculation.

### 2023-06-22 Insert date later and open folder zim
Custom tool [zim-date-later]() for insert "<2277-11-11" date for read later function
Custom tool for open in zim the folder of the containing file.

### 2023-06-21 Zim Quoting
The program [zim-quoting-copy]() can copy a marked line. The marked line gets an anchor. The copied text can be pasted at the desired position of pages.

### 2023-05-25 Kanboardlist and Dateheadlines
[kanboardlist.md](kanboardlist.md) insert Kanboardlists in zim wiki
[zim-dateheadlines.md](zim-dateheadlines.md) insert date headlines in zim-wiki

