local_deploy: build/index.html

.PHONY: papers

build/papers: build/papers/ssd.pdf

build/papers/ssd.pdf:
	make -C papers/ssd
	mkdir -p build/papers
	cp papers/ssd/ssd.pdf build/papers

build/css/all.css: css/lato.css css/texne.css css/popup.css css/entry.css css/calendar.css
	mkdir -p build/css
	cp css/lato.css build/css/lato.css
	./sh/fillcss.sh
	cat build/css/lato.css css/texne.css css/popup.css css/entry.css css/calendar.css | csso --output $@
	rm build/css/lato.css

build/js/all.js: js/texne.js js/popup.js js/entry.js js/calendar.js \
                 references/main.bib \
                 papers/*/changelog.txt
	mkdir -p build/js
	cp js/entry.js build/js/entry.js
	./sh/filljs.sh
	java -jar ../code/bluck-out/java/compiler.jar -W VERBOSE -O ADVANCED \
	     --language_out ECMASCRIPT5_STRICT --charset UTF-8 \
	     --js js/texne.js js/popup.js build/js/entry.js js/calendar.js \
	     | uglifyjs -m -o $@
	rm -f build/js/entry.js

build/index.html: build/js/all.js build/css/all.css index.html
	./sh/fillhtml.sh

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

clean:
	rm -rf build

