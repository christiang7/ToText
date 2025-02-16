# Changelog-Journal

- [X] Backlog
	- [ ] [tt] with real path of file not the terminal path, ``realpath`` program not working, using the real path of the [.desktop] file with ``tt $f``
	- [ ] rewrite everything in english
	- [ ] make a website for [ToTexT] scripts
	- [ ] write blog post for [website]
	- [ ] rewrite [tt-lib.sh] with [subshell]
		- [ ] use output formats in the external tools
	- [ ] make [website] with [wiki] of how to use the scripts
		- [ ] links for used tools in [README] file
- [X] Doing (2)



### 2025-02-16
	- [X] integrate plotting in [zim] and or [markdown] with [noweb.py], maybe [python], [gnuplot] (very easy) or [sage]
	- [X] integrate mermaid diagrams
	- [X] combine [zim-insert-plantuml.sh] with [insert-code.sh]

Plotting - Tutorial
https://doc.sagemath.org/html/en/tutorial/tour_plotting.html
SageMath: saving picture of graph to a file | AnonymousOverflow
https://overflow.adminforge.de/questions/70979154/sagemath-saving-picture-of-graph-to-a-file
Coding in Python for Sage - Developer Guide
https://doc.sagemath.org/html/en/developer/coding_in_python.html
Tutorial: Programming in Python and Sage - Thematic Tutorials
https://doc.sagemath.org/html/en/thematic_tutorials/tutorial-programming-python.html

### 2025-02-12
- [X] no rewrite of [ttdm], deleted
- [X] remake latex template for Apply in [template-apply.sh]
- [X] rewrite [zim-template-calculation.sh] with [tt-lib.sh]
- [X] combined request of language name of [template-tex.sh], [template-calculation.sh] and [zim-template-calculation.sh]
- [X] [template-tex.sh] and [template-calculation.sh] using the same functions of [tt-lib.sh]
- [X] combine ``ttex`` function with [template-tex.sh] script, using the same template in [tt-lib.sh]
- [X] integrate markdown template in [template-calculation.sh] script

### 2025-02-09 Draft of html to markdown

Procedure
- using a [download tool] for saving a website in a [zip] file
- then extract
- then convert [html] to [markdown]
- then have a folder with the original version and a annotated version of the website

GitHub - opengovsg/pdf2md: A PDF to Markdown converter
https://github.com/opengovsg/pdf2md
GitHub - suntong/html2md: HTML to Markdown converter
https://github.com/suntong/html2md
GitHub - opendatalab/MinerU: A high-quality tool for convert PDF to Markdown and JSON.一站式开源高质量数据提取工具，将PDF转换成Markdown和JSON格式。
https://github.com/opendatalab/MinerU


### 2025-02-08
- [X] combine [tt-change] with [ttc]
	- [X] also change video files with subtitles

GitHub - Osndok/zim-plugin-append: Makes adding text to Zim pages from the command line (or another unix process) possible without further user interaction.
https://github.com/Osndok/zim-plugin-append

### 2025-02-07
- [X] [Download-Video.sh] make possible for downloading from other websites then [youtube], but sites like arte tv not working correctly, using mediatekview
- [X] change variables name to more understandable names in config file
- [X] rename [Download-Video-Select.sh] to [Download-Video.sh]

### 2025-02-06
- [X] [ttvidc] deleted, not used

### 2025-02-05
- [X] rename [ttrename] in [tt-change] and working with folders
- [X] combine [ttrename] with [tti] and renamed to [tt-change]
- [X] replace ``zenity`` with ``yad``
- [X] create example [.desktop] files in the [repo] and home with [noweb.py] file format
	- [X] new folder
	- [X] all used [.desktop] files in [repo] with link to service folder
- [X] deleted [ttnc] not used
	- [X] > rename [ttncc] to [ttc]
	- [X] > insert [ttc] in [ttrename]

### 2025-02-04
- [X] position of picture in ``ttpic`` above text
- [X] rewrite [ttm] and [ttncc]
- [X] rewrite [ttd] with the [tt] script
- [X] logging in the [.desktop] files enabled, in folder ``~/.config/tt/``

Writing errors and output to a text file and Console | AnonymousOverflow
https://overflow.adminforge.de/questions/3008545/writing-errors-and-output-to-a-text-file-and-console

### 2025-02-03
- [X] option for [tt] execute without ``yad`` request
- [X] all ``video`` related scripts are connected via ``ttvid`` function
- [X] move files to folder, but for ``pictures`` and ``music`` not.
	- [X] ``pdf`` files
	- [X] ``tex`` files
	- [X] ``video`` files
	- [X] other files

### 2025-02-02 tt-lib.sh
- [X] connect programs with [libraries], [tt-lib.sh]
	- [X] shell library for cleaning filenames
	- [X] shell library for markdown template
	- [X] shell library for [zim] template
	- [X] template function for nodes for files and usable with [library] inclusion
	- [X] pdf function
	- [X] video function

Use config file for my shell script | AnonymousOverflow
https://overflow.adminforge.de/exchange/unix/questions/175648/use-config-file-for-my-shell-script#331965
### 2025-02-01
- [X] publish on [github]
- [X] moved all [scripts] to [Scripts] folder
- [X] using a [config file] for the path and variables
	- [X] create config dir
	- [X] set ``standard variables``
	- [X] script for reading config file
	- [X] rewrite programs for ``standard variables``

### 2024-08-08 template tex
- [X] [template-tex]
	- [X] template for [Rechnung]
	- [X] template for [Bewerbung]

### 2024-02-13 combined scripts tts und ttn

### ttvidc corrected to markdown
[ttvidc] corrected to markdown and you can choose both files

### 2023-10-30 tex support in ttn and tts

### 2023-10-29 created programms ``template-tex.sh`` and ``texstudio-noweb-py.sh``
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
[kanboardlist.md](kanboardlist.md) insert Kanboardlists in ``zim-wiki``
[zim-dateheadlines.md](zim-dateheadlines.md) insert date headlines in ``zim-wiki``


