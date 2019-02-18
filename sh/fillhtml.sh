#!/bin/bash

constDate="$(date +%Y)-01-01"

declare -A TaskSourceFile
declare -A TaskReplaceString

Tasks="js css"
TaskSourceFile["js"]="build/js/all.js"
TaskSourceFile["css"]="build/css/all.css"
TaskReplaceString["js"]="s#<!-- build:js -->\n?([\s\S]*?)\n?<!-- endbuild -->#<script async src='js/%s.js'></script>#"
TaskReplaceString["css"]="s#<!-- build:css -->\n?([\s\S]*?)\n?<!-- endbuild -->#<link href='css/%s.css' rel=stylesheet type='text/css'/>#"

cp index.html build/tmp.html

for task in $Tasks; do
  hash=$(sha1sum -b ${TaskSourceFile[$task]} | cut -c1-40 | base64 | cut -c3-8)
  dest="build/${task}/${hash}.${task}"
  cp ${TaskSourceFile[$task]} ${dest}
  regx=$(printf "${TaskReplaceString[$task]}" "${hash}")
  echo "${task}:" ${regx}
  perl -0777 -i -pe "${regx}" build/tmp.html
  touch --date="${constDate}" ${dest}
  zopfli --force --best --i20 --keep ${dest}
  brotli --force --quality 11 --repeat 20 --input ${dest} --output ${dest}.br
  # Zopfli does not copy last modified
  touch --date="${constDate}" ${dest}.gz
done

html-minifier -c htmlminifier.conf build/tmp.html > build/index.html
rm -rf build/tmp.html
touch --date="${constDate}" build/index.html
zopfli --force --best       --i20       --keep  build/index.html
brotli --force --quality 11 --repeat 20 --input build/index.html --output build/index.html.br
touch build/index.html
touch build/index.html.br
touch build/index.html.gz

