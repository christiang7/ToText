# Changelog-Journal

- [X] Backlog
	- [ ] rewrite [ttdm] with [ttnm]
	- [ ] custom tool for insert page.section in file
	- [ ] automatic thumbnail update for ``xournalpp`` files
	- [ ] rewrite everything in english
	- [ ] links for used tools in README file
	- [ ] make a website for ToText scripts
	- [ ] write blog post for website
	- [ ] write wiki of how to use the scripts
	- [ ] create example ``.desktop`` files in the repo and home with ``noweb.py`` file format
	- [ ] mit ``git`` bestimmte Versionen und Tags verwenden, um bestimmte Zustände von Dateien wiederzugeben und daraus einen Release machen,
	gibt es Wege diese Lokal zu speichern?
	- [ ] combine ``ttex`` function with ``template-tex`` and ``template-calculation`` scripts, using the same template in ``tt-lib.sh``
- [X] Planning (2)
	- [ ] replace ``zenity`` with ``yad``
	- [ ] rewrite ``ttdm``
- [X] Doing (2)
	- [ ] ``tt`` with real path of file not the terminal path, ``realpath`` program not working, using the real path of the ``.desktop`` file with ``tt $f``
	- [ ] integrate ``ttnc`` in ``tt`` because is just one code line
		- [ ] > rename ``ttncc`` to ``ttc``

### 2025-02-04
- [X] position of picture in ``ttpic`` above text
- [X] rewrite ``ttm`` and ``ttncc``
- [X] rewrite ``ttd`` with the ``tt`` script
- [X] logging in the ``.desktop`` files enabled, in folder ``~/.config/tt/``

### 2025-02-03
- [X] option for ``tt`` execute without ``yad`` request
- [X] all video related scripts are connected via ``ttvid`` function
- [X] move files to folder, but for pictures and music not.
	- [X] pdf files
	- [X] tex files
	- [X] video files
	- [X] other files

### 2025-02-02
- [X] connect programs with libraries
	- [X] shell library for cleaning filenames
	- [X] shell library for markdown template
	- [X] shell library for zim template
	- [X] template function for nodes for files and usable with library inclusion
	- [X] pdf function
	- [X] video function

### 2025-02-01
- [X] publish on github
- [X] moved all scripts to Scripts folder
- [X] using a config file for the path and variables
	- [X] create config dir
	- [X] set standard variables
	- [X] script for reading config file
	- [X] rewrite programs for standard variables

### 2024-08-08 template tex
- [X] ``template-tex``
	- [X] template for rechnung
	- [X] template for Bewerbung

### 2024-02-13 combined scripts tts und ttn

### ttvidc corrected to markdown
``ttvidc`` corrected to markdown and you can choose both files

### 2023-10-30 tex support in ttn and tts

### 2023-10-29 created programms template-tex.sh and texstudio-noweb-py.sh
created program ``template-tex.sh`` like ``template-calculation``
``texstudio`` behavior for markdown files with ``noweb``, compilation and so on changed with script [texstudio-noweb-py.sh](texstudio-noweb-py.sh)

### 2023-07-03 wayland paste in zim
custom tool for insert clipboard of ``wayland``

### 2023-06-25 open-file template-program and template-calculation
Combination of ``template-program`` and ``zim-template-program``.
Custom tool for open file in ``zim``.
Creation of ``template-calculation`` and ``zim-template-calculation``.

### 2023-06-22 Insert date later and open folder zim
Custom tool [zim-date-later]() for insert "<2277-11-11" date for read later function
Custom tool for open in ``zim`` the folder of the containing file.

### 2023-06-21 Zim Quoting
The program [zim-quoting-copy]() can copy a marked line. The marked line gets an anchor. The copied text can be pasted at the desired position of pages.

### 2023-05-25 Kanboardlist and Dateheadlines
[kanboardlist.md](kanboardlist.md) insert Kanboardlists in zim wiki
[zim-dateheadlines.md](zim-dateheadlines.md) insert date headlines in zim-wiki


