targets = sdl.o1

SDL_CONFIG = sdl-config
SDL_CFLAGS = ${shell ${SDL_CONFIG} --cflags}
SDL_LDFLAGS = ${shell ${SDL_CONFIG} --libs}

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
