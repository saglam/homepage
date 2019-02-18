fontSource = font/Lato2OFL
pyftsubsetParams = --no-recommended-glyphs \
                   --hinting \
                   --canonical-order \
                   --recalc-bounds

ttfFonts = font/lt400.ttf font/lt400i.ttf font/lt700.ttf font/lt700i.ttf
woffFonts = $(ttfFonts:.ttf=.woff)
woff2Fonts = $(woffFonts:=2)

font/lt400.ttf: $(fontSource)/Lato-Regular3.ttf
	pyftsubset $< $(pyftsubsetParams) \
	      --text-file=$(subst ttf,txt,$(subst lt,specimen,$@)) \
	      --output-file=$@

font/lt400i.ttf: $(fontSource)/Lato-Italic.ttf
	pyftsubset $< $(pyftsubsetParams) \
	      --text-file=$(subst ttf,txt,$(subst lt,specimen,$@)) \
	      --output-file=$@

font/lt700.ttf: $(fontSource)/Lato-Bold.ttf
	pyftsubset $< $(pyftsubsetParams) \
	      --text-file=$(subst ttf,txt,$(subst lt,specimen,$@)) \
	      --output-file=$@

font/lt700i.ttf: $(fontSource)/Lato-BoldItalic.ttf
	pyftsubset $< $(pyftsubsetParams) \
	      --text-file=$(subst ttf,txt,$(subst lt,specimen,$@)) \
	      --output-file=$@

font/%.woff: font/%.ttf
	sfnt2woff-zopfli -n 20 $<

font/%.woff2: font/%.ttf
	woff2_compress $<

