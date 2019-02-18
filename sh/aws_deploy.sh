#!/bin/bash

fontForms="woff2 woff ttf"
for fontForm in $fontForms; do
  aws s3 sync --metadata-directive REPLACE \
              --expires 2034-01-01T00:00:00Z \
              --acl public-read \
              --content-type font/${fontForm} \
              --cache-control max-age=29030400,public \
              --exclude="*" \
              --include="*.${fontForm}" \
              build/font s3://mert.saglam.id/font
done

aws s3 sync --metadata-directive REPLACE \
            --expires 2034-01-01T00:00:00Z \
            --acl public-read \
            --content-type application/javascript \
            --cache-control max-age=29030400,public \
            --exclude="*" \
            --include="*.js" \
            --exclude="all.js" \
            build/js s3://mert.saglam.id/js

aws s3 sync --metadata-directive REPLACE \
            --expires 2034-01-01T00:00:00Z \
            --acl public-read \
            --content-type text/css \
            --cache-control max-age=29030400,public \
            --exclude="*" \
            --include="*.css" \
            --exclude="all.css" \
            build/css s3://mert.saglam.id/css

aws s3 cp   --acl public-read \
            --content-type text/html build/index.html s3://mert.saglam.id/index.html

aws cloudfront create-invalidation --distribution-id E18VDHOME7TQW8 --paths '/index.html'

