
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

.PHONY: clean doc
clean:
	$(RM) dist/*~

# To forcibly update README.
doc:
	ruby -e $(rubycom) $^ > $@

