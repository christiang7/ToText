# config.sh
Created [2025-02-01](2025-02-01)

- [x] **config.sh**
    - [x] Doing
    - [x] Backlog

## Features



## Informations
 Christian Gößl

script from one of the answers
Use config file for my shell script | AnonymousOverflow
https://overflow.adminforge.de/exchange/unix/questions/175648/use-config-file-for-my-shell-script#331965

## Main Program


*make.sh*
```bash
noweb.py -Rconfig.sh config.sh.md > config.sh && echo 'config.sh' && date && notify-send -a "Compilation of config.sh" "" "$(date +"%Y-%m-%d") fertig"
```


```bash
chmod u+x config.sh && ln -sf $(pwd)/config.sh ~/.local/bin/config.sh && echo 'fertig'
```
 

### config.sh

*config.sh*
```bash
#!/bin/bash
config_read_file() {
    (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-;
}

config_get() {
    val="$(config_read_file ~/.config/tt/config "${1}")";
    if [ "${val}" = "__UNDEFINED__" ]; then
        val="$(config_read_file ~/.config/tt/config-defaults "${1}")";
    fi
    printf -- "%s" "${val}";
}

```
