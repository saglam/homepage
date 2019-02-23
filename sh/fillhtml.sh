#!/bin/bash

constDate="$(date +%Y)-01-01"

declare -A TaskSourceFile
declare -A TaskReplaceString

Tasks="js css"
TaskReplaceString["js"]="s#<!-- build:js -->\n?([\s\S]*?)\n?<!-- endbuild -->#<script async src='js/%s.js'></script>#"
TaskReplaceString["css"]="s#<!-- build:css -->\n?([\s\S]*?)\n?<!-- endbuild -->#<link href='css/%s.css' rel=stylesheet type='text/css'/>#"

for task in $Tasks; do
  source="build/${task}/all.${task}"
  hash=$(sha1sum -b ${source} | cut -c1-40 | base64 | cut -c3-8)
  dest="build/${task}/${hash}.${task}"

  cp ${source} ${dest}
  cp ${source}.gz ${dest}.gz
  cp ${source}.br ${dest}.br
  touch --date="${constDate}" ${dest} ${dest}.gz ${dest}.br

  regx=$(printf "${TaskReplaceString[$task]}" "${hash}")
  echo "${task}:" ${regx}
  perl -0777 -i -pe "${regx}" build/tmp.html
done

Fonts="400i 400 700i 700"
for font in $Fonts; do
  hash=$(sha1sum -b "font/lt${font}.woff2" | cut -c1-40 | base64 | cut -c3-8)
  perl -0777 -i -pe "s#font/lt${font}.ttf#font/${hash}.woff2#" build/tmp.html
done

