targets = sdl-image.o1

SDL_CONFIG = sdl-config
SDL_CFLAGS = ${shell ${SDL_CONFIG} --cflags}
SDL_LDFLAGS = ${shell ${SDL_CONFIG} --libs}

CFLAGS += ${SDL_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS} -lSDL_image

sdl-image.o1: sdl-image.scm

include config.mk
