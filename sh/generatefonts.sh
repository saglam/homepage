#!/bin/bash

declare -A typeToName

typeToName["400"]="Lato-Regular3.ttf"
typeToName["400i"]="Lato-Italic.ttf"
typeToName["700"]="Lato-Bold.ttf"
typeToName["700i"]="Lato-BoldItalic.ttf"
types="400i 400 700i 700"

sourceDir="Lato2OFL"

mkdir -p font

if [[ "$1" = *"--nocompile"* ]]
then
  for type in $types; do
    cp font/${sourceDir}/${typeToName[$type]} font/lt${type}.ttf
  done  
else
  for type in $types; do
    echo "Subsetting ${type} font/${sourceDir}/${typeToName[$type]} "
    pyftsubset font/${sourceDir}/${typeToName[$type]} \
        --text-file=font/specimen${type}.txt \
        --output-file=font/lt${type}.ttf \
        --no-recommended-glyphs \
        --hinting \
        --canonical-order \
        --recalc-bounds
  done
fi

