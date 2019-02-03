#!/bin/sh

Saglam2018changelog=$(cat ../papers/heatdiscrete/changelog.txt | fold -w 80 -s | perl -pe 's#\n#\\\\n#')
perl -0777 -i -pe "s#build:Saglam2018changelog#$Saglam2018changelog#" build/js/entry.js
echo $Saglam2018changelog
SaglamT2013changelog=$(cat ../papers/ssd/changelog.txt | fold -w 80 -s | perl -pe 's#\n#\\\\n#g; s#"#\\\\"#g;')
echo $SaglamT2013changelog
perl -0777 -i -pe "s#build:SaglamT2013changelog#$SaglamT2013changelog#" build/js/entry.js

bibKeys="Saglam2018 SaglamT2013 Saglam2011 JowhariST2011 ErgunJS2010"
for bibKey in $bibKeys; do
  bibEntry=$(bibtool -r references/bibtool.rsc -X $bibKey ./references/main.bib 2>/dev/null | perl -pe 's#\n#\\\\n#g; s#@#\\\@#;')
  echo $bibEntry
  perl -0777 -i -pe "s#build:${bibKey}bibtex#$bibEntry#" build/js/entry.js
done

