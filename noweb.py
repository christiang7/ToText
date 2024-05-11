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

for line in expand(outputChunkName, ""):
    print(line.rstrip(), file=outfile)
if opts.out and opts.executable:
    os.system("chmod +x " + opts.out)
