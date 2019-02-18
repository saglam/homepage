#!/bin/bash

declare -A typeToName

typeToName["400"]="Lato-Regular.ttf"
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
    echo -e "${type}\n"
    cat font/specimen${type}.txt | while read -n1 c; do
      printf "U+%04X\n" \'$c
    done | sort -u | tail -n+2 > "tmp${type}.txt"

    echo "Subsetting ${type} font/${sourceDir}/${typeToName[$type]} "
    pyftsubset font/${sourceDir}/${typeToName[$type]} \
        --unicodes-file=tmp${type}.txt \
        --output-file=font/lt${type}.ttf \
        --no-recommended-glyphs \
        --hinting \
        --verbose \
        --canonical-order \
        --recalc-bounds
  done
fi

