# zim-script

- [x] @ArcVORLAGE @ArcPROGRAMM @SCRIPT @Zim  **zim-script**  !!

Created Samstag 17 April 2021 [17.04.2021]()



## Information

Verwendung in Zim-Wiki selbst über das Menu ``Tools>Custum tools``
dort bei einem neuen Eintrag unbedingt auf ``Command does not modify data`` anklicken, damit Zim weiter läuft, sonst bleibt es hängen und wartet auf Abschluss des Scripts
als Kommando

```bash
zim-script.sh %t
```

Mit ``%t`` wird der ausgewählte Text als Kommando ausgeführt vom Script


 terminal - Execute a command in a separate konsole then let users type commands - Unix & Linux Stack Exchange
 <https://unix.stackexchange.com/questions/613274/execute-a-command-in-a-separate-konsole-then-let-users-type-commands>

 bash - Run commands in a terminal, then let me type more commands - Unix & Linux Stack Exchange
 <https://unix.stackexchange.com/questions/234247/run-commands-in-a-terminal-then-let-me-type-more-commands>


 pass a command as an argument to bash script - Stack Overflow
 <https://stackoverflow.com/questions/15749618/pass-a-command-as-an-argument-to-bash-script>

 shell - Redirect stderr and stdout in Bash - Stack Overflow
 <https://stackoverflow.com/questions/637827/redirect-stderr-and-stdout-in-bash>


## Main program

*make.sh*
```bash
noweb.py -Rzim-script.sh zim-script.md > zim-script.sh && echo 'fertig'
```

hier die zim-script Datei zum Ausführen

*zim-script.sh*
```bash
#!/bin/bash
output="$(eval $@ 2>&1)"
yad --timeout=15 --timeout-indicator=top --form --separator="~" --item-separator="," \
	--field="Output Script:":TXT \
	"$output" --mouse
```
