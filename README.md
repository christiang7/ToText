# ToText tt

## Description
ToText is a collection of bash scripts for using an annotation system with **md** files. It builds upon the desktop wiki [GitHub - zim-desktop-wiki/zim-desktop-wiki: Main repository of the zim desktop wiki project](https://github.com/zim-desktop-wiki/zim-desktop-wiki). The **md** files are describing every given file on your file system. The created **md** file is showing up in zim. So you can search and annotate a file in zim wiki. Some scripts connect zim with the file manager [dolphin]([Dolphin - KDE Applications](https://apps.kde.org/dolphin/)) and the web browser [firefox](https://www.mozilla.org/en-US/firefox/new/). The scripts are working on Linux machines like Ubuntu, Archlinux, Fedora, Suse. 
The scipts begin with the shortcut tt for ToText. 
For updates see the [CHANGELOG-JOURNAL.md](CHANGELOG-JOURNAL.md) file.
The ToText uses the following tools:

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

- zim - desktop wiki

## Install

Download the repository with 

```bash
git clone https://github.com/christiang7/ToText.git
cd ToText
```

Create a folder under the ``.config`` folder in your home ``/home/username/``

```bash
mkdir -p ~/.config/tt
```

Copy the ``config-example`` file to your ``.config`` folder

```bash
cp configs/config-example ~/.config/tt/config
```

and fill in your path you need. 

Copy the ``config-mpv-example`` to your ``mpv`` config folder

```bash
cp configs/config-mpv-example ~/.config/mpv/config
```

Copy all [.desktop] files to the dolphin service folder

```bash
cp -r desktop-files/*.desktop ~/.local/share/kservices5/ServiceMenus/*.desktop
```

Copy all scripts to the local [bin] folder

```bash
list=$(ls -1 --hide=*.md "Scripts")
cp $list .local/bin/*
```

Install all listed programs from the section ``Description`` above.

Finished.