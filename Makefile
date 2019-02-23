run: local_deploy
	cd build; python3 -m http.server 8000; cd ..;

include font/Makefile

runnocompile: Makefile font/Makefile $(ttfFonts)
	python3 -m http.server 8000

local_deploy: build/index.html build/index.html.gz build/index.html.br

build/css/all.css: font/Makefile $(ttfFonts) $(woffFonts) $(woff2Fonts) \
                   css/lato.css css/texne.css css/popup.css css/entry.css css/calendar.css
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

build/index.html: font/Makefile $(woff2Fonts) \
                  build/js/all.js build/js/all.js.gz build/js/all.js.br \
                  build/css/all.css build/css/all.css.gz build/css/all.css.br \
                  index.html
	mkdir -p build
	cp index.html build/tmp.html
	./sh/fillhtml.sh
	html-minifier -c htmlminifier.conf build/tmp.html > build/index.html
	rm build/tmp.html

aws_deploy: local_deploy
	./sh/aws_deploy.sh

clean: cleanFont
	rm -rf build

cleanFont:
	rm -f font/*.woff font/*.woff2 font/*.ttf

.PHONY: local_deploy aws_deploy clean cleanFont

%.gz: %
	cp $< $@.tmp
	touch $@.tmp --date="2019-01-01"
	zopfli --force --best --i20 $@.tmp
	mv $@.tmp.gz $<.gz
	rm -f $@.tmp

%.br: %
	cp $< $@.tmp
	touch $@.tmp --date="2019-01-01"
	brotli --force --quality 11 --repeat 20 --input $@.tmp --output $@
	touch $@
	rm $@.tmp

