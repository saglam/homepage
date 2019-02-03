#!/bin/bash

declare -A PaperKeyToRepo
PaperKeyToRepo["SaglamT2019"]="protocolrecipe"
PaperKeyToRepo["Saglam2018"]="heatdiscrete"
PaperKeyToRepo["SaglamT2013"]="ssd"
PaperKeyToRepo["Saglam2011"]="mscthesis"
PaperKeyToRepo["JowhariST2011"]="lpsampler"
PaperKeyToRepo["ErgunJS2010"]="periodicity"

changelogKeys="Saglam2018 SaglamT2013"
for changelogKey in $changelogKeys; do
  changelog=$(cat papers/${PaperKeyToRepo[$changelogKey]}/changelog.txt | fold -w 80 -s | perl -pe 's#\n#\\\\n#g; s#"#\\\\"#g;')
  echo $changelog
  perl -0777 -i -pe "s#build:${changelogKey}changelog#${changelog}#" build/js/entry.js
done

bibKeys="Saglam2018 SaglamT2013 Saglam2011 JowhariST2011 ErgunJS2010"
for bibKey in $bibKeys; do
  bibEntry=$(bibtool -r references/bibtool.rsc -X $bibKey ./references/main.bib 2>/dev/null | perl -pe 's#\n#\\\\n#g; s#@#\\\@#;')
  echo $bibEntry
  perl -0777 -i -pe "s#build:${bibKey}bibtex#${bibEntry}#" build/js/entry.js
done

