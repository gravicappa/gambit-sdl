targets = sdl.o1

SDL_CFLAGS = ${shell sdl-config --cflags} 
SDL_LDFLAGS = ${shell sdl-config --libs} 

CFLAGS += ${SDL_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS}

sources = sdl.scm \
          header.scm \
					ffi.scm \
					sdl-types.scm \
					sdl-const.scm \
					sdl-events%.scm \
					sdl-keysym%.scm \
					sdl-accessors.scm \

sdl-events%.scm:
	scripts/make-sdl-events > $@

sdl-keysym%.scm:
	scripts/make-sdl-keysym > $@

sdl.o1: ${sources}

include config.mk
