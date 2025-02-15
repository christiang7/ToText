# insert-plot.sh
Created [2025-02-13]()


## Description

## Journal
 - [X] Doing
 - [X] Backlog
    - [ ] 
 
## Main Program


procedure
- [yad] request for insert code block or new program 
- using ``program-template`` function from [[tt-lib.sh]]
    - insert in text file [noweb] execution
    - insert in text file [gnuplot] code block
        - maybe using a template
- copy template to text file folder
- insert plot picture


*run-cell.sh*
```bash
noweb.py -Rinsert-plot.sh insert-plot.sh.md > insert-plot.sh && echo 'insert-plot.sh' && date 
```


```bash
chmod u+x insert-plot.sh && ln -sf $(pwd)/insert-plot.sh ~/.local/bin/insert-plot.sh && echo 'fertig'
 ```

*insert-plot.sh*
```bash
#!/bin/bash


```
