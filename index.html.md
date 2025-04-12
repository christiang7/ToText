# index.html
Created [2025-03-17]()


## Description

## Journal
 - [x] Backlog
    - [ ] 
 - [x] Doing
 
### website preview
*website preview*
```bash
python3 -m http.server 3000
```


## html code


*make.sh*
```bash
noweb.py -Rindex.html index.html.md > index.html && echo 'index.html' && date 
```


```bash
chmod u+x index.html && ln -sf $(pwd)/index.html ~/.local/bin/index.html && echo 'fertig'
```


### index.html
*index.html*
```html
<!-- index.html -->

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta charset="UTF-8" />
    <link
      rel="stylesheet"
      href="//cdn.jsdelivr.net/npm/docsify@4/themes/vue.css"
    />
    <!--
    <link rel="stylesheet" href="dark.css" />
    <link
      rel="stylesheet"
      href="//cdn.jsdelivr.net/npm/docsify@4/themes/dark.css"
    />
    -->
  </head>
  <body>
    <!-- load docsify script -->
    <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
    <div id="app"></div>

    <script>
        window.$docsify = {
            loadNavbar: true,
            latex: {
                inlineMath   : [['%%', '%%'],['\\(', '\\)']], // default ['$', '$'],
                displayMath  : [['$$', '$$']],               // default
            },
            coverpage: true
        }
    </script>
    
     <!-- load latex engine -->
    
    <script src="//cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
    
    <!-- load latex docsify script -->
    
    <script src="//cdn.jsdelivr.net/npm/docsify-latex@0"></script>
    
    <script src="//cdn.jsdelivr.net/npm/prismjs@1/components/prism-bash.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/prismjs@1/components/prism-php.min.js"></script>
    
    <nav>
        <a href="#/">EN</a>
    </nav>
    
  </body>
</html>
```
