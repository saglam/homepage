local_deploy: build/index.html

.PHONY: papers

build/papers: build/papers/ssd.pdf

build/papers/ssd.pdf:
	make -C papers/ssd
	mkdir -p build/papers
	cp papers/ssd/ssd.pdf build/papers

build/css/all.css: css/texne.css css/popup.css css/entry.css css/calendar.css
	mkdir -p build/css
	cat $^ | csso --output $@

build/js/all.js: js/texne.js js/popup.js js/entry.js js/calendar.js \
                 references/main.bib \
                 papers/*/changelog.txt
	mkdir -p build/js
	cp js/entry.js build/js/entry.js
	./filljs.sh
	java -jar ../code/bluck-out/java/compiler.jar -W VERBOSE -O ADVANCED \
	     --language_out ECMASCRIPT5_STRICT --charset UTF-8 \
	     --js js/texne.js js/popup.js build/js/entry.js js/calendar.js \
	     | uglifyjs -m -o $@
	rm -f build/js/entry.js

build/index.html: build/js/all.js build/css/all.css index.html
	$(eval cssMd5 := $(shell sha1sum -b build/css/all.css | cut -c1-40 | base64 | cut -c3-8))
	cp build/css/all.css build/css/$(cssMd5).css
	$(eval jsMd5 := $(shell sha1sum -b build/js/all.js | cut -c1-40 | base64 | cut -c3-8))
	cp build/js/all.js build/js/$(jsMd5).js
	cp index.html build/tmp.html
	perl -0777 -i -pe 's/<!-- build:js -->\n?([\s\S]*?)\n?<!-- endbuild -->/<script async src=js\/$(jsMd5).js><\/script>/' build/tmp.html
	perl -0777 -i -pe 's/<!-- build:css -->\n?([\s\S]*?)\n?<!-- endbuild -->/<link href=css\/$(cssMd5).css rel=stylesheet type="text\/css"\/>/' build/tmp.html
	html-minifier -c htmlminifier.conf build/tmp.html > build/index.html
	rm -rf build/tmp.html
	touch --date="2019-01-01" build/index.html
	zopfli --force --best       --i20       --keep  build/index.html
	brotli --force --quality 11 --repeat 20 --input build/index.html --output build/index.html.br
	touch build/index.html
	touch build/index.html.br
	touch build/index.html.gz
	touch --date="2019-01-01" build/js/$(jsMd5).js
	touch --date="2019-01-01" build/css/$(cssMd5).css
	zopfli --force --best       --i20       --keep build/js/$(jsMd5).js
	zopfli --force --best       --i20       --keep build/css/$(cssMd5).css
	touch --date="2019-01-01" build/js/$(jsMd5).js.gz
	touch --date="2019-01-01" build/css/$(cssMd5).css.gz
	brotli --force --quality 11 --repeat 20 --input build/js/$(jsMd5).js    --output build/js/$(jsMd5).js.br
	brotli --force --quality 11 --repeat 20 --input build/css/$(cssMd5).css --output build/css/$(cssMd5).css.br

aws_deploy: local_deploy
	aws s3 sync --metadata-directive REPLACE \
	            --expires 2034-01-01T00:00:00Z \
	            --acl public-read \
	            --content-type application/javascript \
	            --cache-control max-age=29030400,public \
	            --exclude="all.js" \
	            build/js s3://mert.saglam.id/js
	aws s3 sync --metadata-directive REPLACE \
	            --expires 2034-01-01T00:00:00Z \
	            --acl public-read \
	            --content-type text/css \
	            --cache-control max-age=29030400,public \
	            --exclude="all.css" \
	            build/css s3://mert.saglam.id/css
	aws s3 cp   --acl public-read \
	            --content-type text/html build/index.html s3://mert.saglam.id/index.html
	aws cloudfront create-invalidation --distribution-id E18VDHOME7TQW8 --paths '/index.html'

aws_deploy_preso:
	aws s3 sync --acl public-read ../presentations/heatdiscrete s3://mert.saglam.id/slides/heatdiscrete
	aws cloudfront create-invalidation --distribution-id E18VDHOME7TQW8 --paths '/slides/heatdiscrete/*'

clean:
	rm -rf build

