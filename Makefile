local_deploy: build/index.html

.PHONY: local_deploy

include font/Makefile

nocompile: Makefile font/Makefile $(ttfFonts)
	python3 -m http.server 8000

build/css/all.css: font/Makefile $(ttfFonts) $(woffFonts) $(woff2Fonts) \
	                 css/lato.css css/texne.css css/popup.css css/entry.css css/calendar.css
	mkdir -p build/css
	cp css/lato.css build/css/lato.css
	./sh/fillcss.sh
	cat build/css/lato.css css/texne.css css/popup.css css/entry.css css/calendar.css | csso --output $@
	rm build/css/lato.css

build/js/all.js: Makefile js/texne.js js/popup.js js/entry.js js/calendar.js \
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

build/index.html: Makefile build/js/all.js build/css/all.css index.html
	./sh/fillhtml.sh

aws_deploy: local_deploy
	./sh/aws_deploy.sh

clean: cleanFont
	rm -rf build

cleanFont:
	rm -f font/*.woff font/*.woff2 font/*.ttf

