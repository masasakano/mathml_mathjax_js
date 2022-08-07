
# Makefile to generate the index file automatically.
#

ALL	= dist/README.md

rubycom	= 'ast = ["Sample HTMLs", "(Common) JavaScripts"]; \
          print "\# Selective loading of MathJax\n"; \
          ARGV.map{|ec|ec.sub(%r@^dist/@, "")}.partition{|ef| %r@demo/@ =~ ef}.map{|ev| ev.reverse}.each_with_index{|ea,i| ea.each_with_index{|es,j| if(j==0)then;print "\n\#\# "+ast[i]+"\n\n";end;puts "* [\#{File.basename es}](\#{es})"}}; print "\n------\n\n[Back to Manual page](../)\n"'

.SUFFIXES:	.js .md .html

all: $(ALL)

# auto-generate dist/README.md according to the available files (JS, HTMLs)
$(ALL): dist/demo/*.html dist/*.min.js
	ruby -e $(rubycom) $^ > $@

.PHONY: clean check doc
clean:
	$(RM) dist/*~

# To check if any update like "git checkout master XXX.XX" is required.
check:
	wa="git diff master -- README.md"; chk=`$$wa`; if [ "$$chk" != "" ]; then echo "ERROR found: README.md in master has been updated. Run:  $$wa" >&2; exit 1; fi; \
        wa="git diff master -- dist/demo/*.html"; chk=`$$wa`; \
          if [ "$$chk" != "" ]; then echo "ERROR found: dist/demo/*.html in master have been updated. Run:  $$wa" >&2; exit 1; fi; \
        for f in tmp/*.min.js; do \
          f2=`basename $$f`; wa="diff dist/$$f2 $$f"; chk=`$$wa`; \
          if [ "$$chk" != "" ]; then echo "ERROR found: $$f is newer. Run:  $$wa" >&2; exit 1; fi; done

# To forcibly update README.
doc:
	ruby -e $(rubycom) $^ > $@

