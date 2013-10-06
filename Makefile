name = s-sdl
namespace = sdl
namespace_def = sdl\#.scm
targets: sdl.o1 sdl-pango.o1 sdl-image.o1 sdl-cairo.o1

include config.mk

.PHONY: all clean clean-generated build package

all: build ${namespace_def}

sdl_sources = \
  sdl.scm \
	ffi.scm \
	sdl-types.scm \
	sdl-const.scm \
	sdl-events%.scm \
	sdl-keysym%.scm \
	sdl-accessors.scm \
	sdl-joystick.scm

sdl-events%.scm:
	scripts/make-sdl-events > $@

sdl-keysym%.scm:
	scripts/make-sdl-keysym > $@

sdl.o1: ${sdl_sources}
sdl-pango.o1: sdl-pango.scm
sdl-image.o1: sdl-image.scm
sdl-cairo.o1: sdl-cairo.scm

build:
	@targ=all; ${do_make}

%.o1: %.scm
	${GSC} ${GSCFLAGS} -cc-options "${CFLAGS}" -ld-options "${LDFLAGS}" $<

${namespace_def}: ${shell ls *.scm | grep -v \#}
	cat $^ | scripts/make-gambit-include ${namespace}\# > $@

clean:
	-rm *.o* ${targets} 2>/dev/null
	-rm -f ${namespace_def} 2>/dev/null
	-rm -f ${name}.tar.bz2 2>/dev/null

clean-generated:
	-rm -f *%.scm

package:
	git archive --format tar --prefix=${name}/ HEAD^{tree} \
	| bzip2 > ${name}.tar.bz2
