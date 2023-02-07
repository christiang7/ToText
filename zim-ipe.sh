#!/bin/bash
mkdir -p "$1"
ipe "$1/$2".ipe
iperender -png "$1/$2".ipe "$1/$2".png
echo {{"$2".png}}
