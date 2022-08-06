
# Makefile to generate dist/*.min.js and dist/*.html
#
# uglifyjs and pandoc are assumed to be in the command-search path.

# Target README/index HTML file for publishing (in gh-pages branch only)
# In Github/Pages, it seems it has to be index.(html|md) or README.md on the root directory
#tgt_readme_html	= dist/README.html
tgt_readme_html	= index.html

ALL	= $(tgt_readme_html) dist/mathml-mpadded.min.js dist/mathml-mpadded-3-2-2.min.js dist/mathml-mpadded-2-7-7.min.js

pandocopts	= -s -N --section-divs -t html5 --toc --shift-heading-level-by=-1 --metadata title="Handle browser-dependence for MathML with Mathjax" -o

.SUFFIXES:	.js .md .html

all: $(ALL)

$(tgt_readme_html): README.md
	pandoc $(pandocopts) $@ $<
        # The original <h1> is ignored but title is converted to <h1>

dist/mathml-mpadded.min.js: src/mathml-mpadded.js src/mathml-mpadded-core.js
	uglifyjs $^ -o $@ -c -m && ruby -pi -e '$$_.sub!(/\bexport\{[^\}]*\};\s*\z/, "")' $@
        # remove "export{...};" at the tail so that it will be compatible with Classic JS.

dist/mathml-mpadded-3-2-2.min.js: src/mathml-mpadded-3-2-2.js src/mathml-mpadded-core.js
	uglifyjs $^ -o $@ -c -m && ruby -pi -e '$$_.sub!(/\bexport\{[^\}]*\};\s*\z/, "")' $@

dist/mathml-mpadded-2-7-7.min.js: src/mathml-mpadded-2-7-7.js src/mathml-mpadded-core.js
	uglifyjs $^ -o $@ -c -m && ruby -pi -e '$$_.sub!(/\bexport\{[^\}]*\};\s*\z/, "")' $@

.PHONY: clean test doc
clean:
	$(RM) dist/*.min.js dist/*~

test:
	err=0; for f in src/mathml-mpadded-core.js `echo $(ALL) | ruby -ane 'puts $$F.filter{|i| /\.min\.js$$/ =~ i}.map{|i| i.sub(/^dist(\/.+)\.min(\.js)$$/){"src"+$$1+$$2}}.join(" ")'`; do uglifyjs $$f -o /dev/null > /dev/null 2>&1; if [ $$? -ne 0 ]; then echo "Syntax Error detected: $$f"; err=1; fi; done; if [ $$err -ne 0 ]; then echo "ERROR: To print the detail, do 'make'."; exit 1; fi; npm test

# To forcibly update the HTML version of README.  The standard 
doc:
	pandoc $(pandocopts) $(tgt_readme_html) README.md

