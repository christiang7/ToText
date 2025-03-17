# ToText - tt

## Description
ToText is a collection of bash scripts for using an annotation system with **md** files. It builds upon the [zim desktop wiki](https://github.com/zim-desktop-wiki/zim-desktop-wiki). The **md** files are describing every given file on your file system. The created **md** file is showing up in [zim](https://github.com/zim-desktop-wiki/zim-desktop-wiki). So you can search and annotate a file in [zim wiki](https://github.com/zim-desktop-wiki/zim-desktop-wiki). Some scripts connect [zim](https://github.com/zim-desktop-wiki/zim-desktop-wiki) with the file manager [dolphin](https://apps.kde.org/dolphin/) and the web browser [firefox](https://www.mozilla.org/en-US/firefox/new/). The scripts are working on [Linux]() machines like [Ubuntu](), [Archlinux](), [Fedora](), [Suse]().  
The [scipts](Scripts.md) begin with the shortcut **tt** for ToText.  
For updates see [CHANGELOG-JOURNAL.md](CHANGELOG-JOURNAL.md).  
The ToText uses the following tools:

- [wget]()
- [xidel]()
- [scrot]()
- [sed]()
- [yad]()
- [firefox addon external application]()
- [firefox addon zim clip]()
- [noweb]() - noweb.py repository
- [mypaint]()
- [krita]()
- [xournalpp]()
- [yt-dlp]()
- [mpv player]()
- [zim]() - desktop wiki

## Installation

You can install the script by the `install.sh` script by simply execute the script or go to the **Execute installation steps** section and run the commands by your self, additionally it explains the `install.sh` scripts steps.


### Run install script

```bash
chmod u+x install.sh && ./install.sh
```

### Execute installation steps

Download the repository with 

*Download repository*
```bash
git clone https://github.com/christiang7/ToText.git
cd ToText
```

Create a folder under the `.config` folder in your home `/home/username/`

*create tt config folder*
```bash
mkdir -p ~/.config/tt
```

Copy the `config-example` file to your `.config` folder

*copy tt config*
```bash
cp configs/config-example ~/.config/tt/config
```

and fill in your path you need. 

Copy the `config-mpv-example` to your `mpv` config folder

*copy mpv config*
```bash
cp configs/config-mpv-example ~/.config/mpv/config
```

Copy all [.desktop] files to the dolphin service folder

*copy .desktop files*
```bash
cp -r desktop-files/*.desktop ~/.local/share/kservices5/ServiceMenus/*.desktop
```

Copy all scripts to the local [bin] folder

*copy script files*
```bash
list=$(ls -1 --hide=*.md "Scripts")
cp $list .local/bin/*
```

Install all listed programs from the section [Description](#description) above.

Finished.

## Install script

The script file of the used installation steps. 

*install.sh*
```bash
#!/bin/bash
#*create tt config folder}}
#*copy tt config}}
#*copy mpv config}}
#*copy .desktop files}}
#*copy script files}}
```

You can find the used code and documentation in the previous section [Execute installation steps](#execute-installation-steps)

*run-cell.sh*
```bash
noweb.py -Rinstall.sh README.md > install.sh && echo 'install.sh' && date 
```
