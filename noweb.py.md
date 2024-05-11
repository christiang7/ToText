# noweb
Text creation time: [Zettelkasten:2021:10:23]() Modification time: [Zettelkasten:2021:10:23]()

GitHub - wware/noweb.py: A python script that extracts code from a literate programming document in "noweb" format.

<https://github.com/wware/noweb.py>

Using noweb for literate programming.

You can generate noweb.py from README.md as follows:

```bash
noweb.py -Rnoweb.py noweb.py.md > noweb.py
```

# SUMMARY OF THE PROGRAM

Here's how the pieces we have discussed fit together:

```python
{{noweb.py}}=
#! /usr/bin/env python3

"""
noweb.py
By Jonathan Aquino (jonathan.aquino@gmail.com)

This program extracts code from a literate programming document in "noweb" format.
It was generated from noweb.py.md, itself a literate programming document.
For more information, including the original source code and documentation,
see http://jonaquino.blogspot.com/2010/04/nowebpy-or-worlds-first-executable-blog.html
"""

import os, sys, re, argparse
{{Parsing the command-line arguments}}
{{Reading in the file}}

{{Recursively expanding the output chunk}}

{{Outputting the chunks}}
@
```

# BETTER PARSING OF COMMAND-LINE ARGUMENTS

Now that we have a map of chunk names to the lines of each chunk, we need to know
which chunk name the user has asked to extract. In other words, we need to parse
the command-line arguments given to the script:

```bash
noweb.py -R hello.php hello.noweb
```

```bash
usage: nmoweb.py [-h] --ref REF [--out OUT] filename

positional arguments:
  filename           the source file from which to extract

optional arguments:
  -h, --help         show this help message and exit
  --ref REF, -R REF  the root chunk to be extracted
  --out OUT, -o OUT  specify an output file
  -x                 chmod +x that file
```

This shows our command-line arguments. So let's grab those.

```python
{{Parsing the command-line arguments}}=
parser = argparse.ArgumentParser(
    prog=os.path.basename(__file__),
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description=__doc__
)
parser.add_argument(
    'filename', metavar='filename', nargs=1,
    help='the source file from which to extract')
parser.add_argument(
    '--ref', '-R',
    required=True,
    help='the root chunk to be extracted',
)
parser.add_argument(
    '--out', '-o',
    help='specify an output file',
)
parser.add_argument(
    '--exectuable', '-x',
    help='if an output file was specified, chmod +x that file',
)
opts = parser.parse_args()
outputChunkName = opts.ref
filename = opts.filename[0]
outfile = open(opts.out, 'w') if opts.out else sys.stdout
@
```

# ORIGINAL TEXT

This executable document first appeared as a blog post on
http://jonaquino.blogspot.com/2010/04/nowebpy-or-worlds-first-executable-blog.html



I have recently been interested in the old idea of
[literate programming](http://en.wikipedia.org/wiki/Literate_programming).
Basically, you have a document that describes in detail how a program works, and
it has embedded chunks of code. It allows you to see the thoughts of the programmer
as he explains how he writes the program using prose. A tool is provided that you
can use to extract the working program from chunks of code in the document.

Here's the thing: *what you are reading right now is a literate program*.

Yes, you can copy this blog post into a file and feed it into the tool, and it
will spit out a program. Q: Where do I get the tool? A: That's the program that
this document spits out. This document will produce a script that you can use to
extract code from [noweb](http://en.wikipedia.org/wiki/Noweb)-format literate programs.

Why do we need to make a new tool if the [noweb](http://en.wikipedia.org/wiki/Noweb)
tool already exists? Because the noweb tool is hard to install. It's not super-hard,
but most people don't want to spend time trying to compile it from source. There
are Windows binaries but you have to [get](http://web.archive.org/web/*/http://www.literateprogramming.com/noweb/nowebinstall.html)
them from the Wayback Machine.

Anyway, the noweb tool doesn't seem to do very much, so why not write a little
script to emulate it?

And that is what we will do now.

## DOWNLOAD

If you are just interested in the noweb.py script produced by this document,
you can [download](http://github.com/JonathanAquino/noweb.py/raw/master/noweb.py) it from GitHub.

## USAGE

The end goal is to produce a Python script that will take a literate program
as input (noweb format) and extract code from it as output. For example,

```bash
noweb.py -Rhello.php hello.noweb > hello.php
```

This will read in a file called hello.noweb and extract the code labelled "hello.php".
We redirect the output into a hello.php file.

## READING IN THE FILE

In a literate program, there are named chunks of code interspersed throughout
the document. Take the chunk of code below. The name of it is "Reading in the file".
The chunk ends with an @ sign.

Let's start by reading in the file given on the command line. We'll build up
a map called "chunks", which will contain the chunk names and the lines of each chunk.

```python
{{Reading in the file}}=
file = open(filename)
chunkName = None
chunks = {}
# Regexes
OPEN = "{{"
CLOSE = "}}"
TAGNAME = "([A-Za-z][-_\.: A-Za-z0-9]+)"
for line in file:
    match = re.match(OPEN + TAGNAME + CLOSE + "=", line)
    if match:
        chunkName = match.group(1)
        if not chunkName in chunks:
            chunks[chunkName] = []
    else:
        match = re.match("@", line)
        if match:
            chunkName = None
        elif chunkName:
            chunks[chunkName].append(line)
@
```

## PARSING THE COMMAND-LINE ARGUMENTS

Now that we have a map of chunk names to the lines of each chunk, we need to know
which chunk name the user has asked to extract. In other words, we need to parse
the command-line arguments given to the script:

```bash
noweb.py -Rhello.php hello.noweb
```

For simplicity, we'll assume that there are always two command-line arguments:
in this example, "-Rhello.php" and "hello.noweb". So let's grab those.

```python
{{BOGUS Parsing the command-line arguments}}=
filename = sys.argv[-1]
outputChunkName = sys.argv[-2][2:]
@
```

## RECURSIVELY EXPANDING THE OUTPUT CHUNK

So far, so good. Now we need a recursive function to expand any chunks found
in the output chunk requested by the user. Expansion of the program preserves
indentation at each level.

```python
{{Recursively expanding the output chunk}}=
def expand(chunkName, indent):
    chunkLines = chunks[chunkName]
    expandedChunkLines = []
    for line in chunkLines:
        match = re.match("(\s*)" + OPEN + TAGNAME + CLOSE + "\s*$", line)
        if match:
            expandedChunkLines.extend(expand(match.group(2), indent + match.group(1)))
        else:
            expandedChunkLines.append(indent + line)
    return expandedChunkLines
@
```

## OUTPUTTING THE CHUNKS

The last step is easy. We just call the recursive function and output the result.

```python
{{Outputting the chunks}}=
for line in expand(outputChunkName, ""):
    print(line.rstrip(), file=outfile)
if opts.out and opts.executable:
    os.system("chmod +x " + opts.out)
@
```

And we're done. We now have a tool to extract code from a literate programming document.
Try it on this blog post!



# APPENDIX I: GENERATING THE SCRIPT

To generate noweb.py from this document, you first need a tool to extract the
code from it. You can use the original [noweb](http://www.cs.tufts.edu/~nr/noweb/)
tool, but that's a bit cumbersome to install, so it's easier to use the
Python script [noweb.py](http://github.com/JonathanAquino/noweb.py/raw/master/noweb.py).

Then you can generate noweb.py from noweb.py.md as follows:

```bash
./noweb.py -Rnoweb.py noweb.py.md > noweb.py
```

