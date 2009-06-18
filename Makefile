namespace = sdl\#
namespace_def = sdl\#.scm

.PHONY: all clean clean-obj clean-generated build

do_make = targ=$@; \
          for d in *.make ; do \
				    make -f $$d $${targ}; \
				  done

all:
	@${do_make}

${namespace_def}: ${wildcard *.scm}
	cat $^ | scripts/make-gambit-include ${namespace} > $@

clean:
	@${do_make}
	-rm -f ${namespace_def} 2>/dev/null

clean-generated:
	-rm -f *%.scm
