targets = sdl-cairo.o1

SDL_CONFIG = sdl-config
PKG_CONFIG = pkg-config
SDL_CFLAGS = ${shell ${SDL_CONFIG} --cflags}
SDL_LDFLAGS = ${shell ${SDL_CONFIG} --libs}
CAIRO_CFLAGS = ${shell ${PKG_CONFIG} --cflags cairo}
CAIRO_LDFLAGS = ${shell ${PKG_CONFIG} --libs cairo}

CFLAGS += ${SDL_CFLAGS} ${CAIRO_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS} ${CAIRO_LDFLAGS}

sdl-cairo.o1: sdl-cairo.scm

include config.mk
