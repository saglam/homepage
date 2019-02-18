#!/bin/bash

constDate="$(date +%Y)-01-01"

types="lt400i lt400 lt700i lt700"
forms="woff2 woff ttf"

mkdir -p build/font

for type in $types; do
  for form in $forms; do
    echo ${type}.${form}
    hash=$(sha1sum -b font/${type}.${form} | cut -c1-40 | base64 | cut -c3-8)
    cp font/${type}.${form} build/font/${hash}.${form}
    touch --date="${constDate}" build/font/${hash}.${form}
    perl -0777 -i -pe "s#${type}.${form}#${hash}.${form}#g" build/css/lato.css
  done
done

