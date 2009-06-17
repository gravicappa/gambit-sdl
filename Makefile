sources = 
namespace = sdl\#
namespace_def = sdl\#.scm

LDFLAGS = 
GSCFLAGS = 
objects = ${sources:%.scm=%.o1}

.PHONY: all clean clean-obj clean-generated build

all: build 

include ${wildcard *.mk}

build: ${objects} ${namespace_def}

${namespace_def}: ${sources} ${wildcard *%.scm}
	cat $^ | scripts/make-gambit-include ${namespace} > $@

clean-object = -rm -f $@ 2>/dev/null
build-scm = ${GSC} ${GSCFLAGS} -ld-options "${1}" $<

%.o1: %.scm
	${clean-object}
	${build-scm}

clean: clean-obj
	-rm -f ${namespace_def} 2>/dev/null

clean-obj:
	-rm -f *.o* 2>/dev/null

clean-generated:
	-rm -f *%.scm
