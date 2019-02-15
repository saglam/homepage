#!/bin/bash

declare -A TaskSourceFile
declare -A TaskReplaceString1
declare -A TaskReplaceString2

Tasks="js css"
TaskSourceFile["js"]="build/js/all.js"
TaskSourceFile["css"]="build/css/all.css"
TaskReplaceString1["js"]="s#<!-- build:js -->\n?([\s\S]*?)\n?<!-- endbuild -->#<script async src='js/"
TaskReplaceString2["js"]=".js'></script>#"
TaskReplaceString1["css"]="s#<!-- build:css -->\n?([\s\S]*?)\n?<!-- endbuild -->#<link href='css/"
TaskReplaceString2["css"]=".css' rel=stylesheet type='text/css'/>#"

cp index.html build/tmp.html

for task in $Tasks; do
  hash=$(sha1sum -b ${TaskSourceFile[$task]} | cut -c1-40 | base64 | cut -c3-8)
  dest="build/${task}/${hash}.${task}"
  cp ${TaskSourceFile[$task]} ${dest}
  echo ${TaskReplaceString1[$task]}${hash}${TaskReplaceString2[$task]}
  perl -0777 -i -pe "${TaskReplaceString1[$task]}${hash}${TaskReplaceString2[$task]}" build/tmp.html
	touch --date="2019-01-01" ${dest}
	zopfli --force --best --i20 --keep ${dest}
	brotli --force --quality 11 --repeat 20 --input ${dest} --output ${dest}.br
	touch --date="2019-01-01" ${dest}.gz
done

html-minifier -c htmlminifier.conf build/tmp.html > build/index.html
rm -rf build/tmp.html
touch --date="2019-01-01" build/index.html
zopfli --force --best       --i20       --keep  build/index.html
brotli --force --quality 11 --repeat 20 --input build/index.html --output build/index.html.br
touch build/index.html
touch build/index.html.br
touch build/index.html.gz

