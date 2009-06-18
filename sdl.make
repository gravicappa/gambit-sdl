targets = sdl.o1

CFLAGS += ${shell sdl-config --cflags} 
LDFLAGS += ${shell sdl-config --libs}

sources = sdl.scm \
          header.scm \
					ffi.scm \
					sdl-types.scm \
					sdl-const.scm \
					sdl-events%.scm \
					sdl-keysym%.scm

sdl-events%.scm:
	scripts/make-sdl-events > $@

sdl-keysym%.scm:
	scripts/make-sdl-keysym > $@

sdl.o1: ${sources}

include config.mk
