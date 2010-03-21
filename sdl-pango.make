targets = sdl-pango.o1

SDL_CONFIG = sdl-config
PKG_CONFIG = pkg-config
SDL_CFLAGS = ${shell ${SDL_CONFIG} --cflags}
SDL_LDFLAGS = ${shell ${SDL_CONFIG} --libs}
PANGO_CFLAGS = \
	${shell ${PKG_CONFIG} --cflags pango} \
	${shell ${PKG_CONFIG} --cflags SDL_Pango}
PANGO_LDFLAGS = \
	${shell ${PKG_CONFIG} --libs pango} \
	${shell ${PKG_CONFIG} --libs SDL_Pango}

CFLAGS += ${SDL_CFLAGS} ${PANGO_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS} ${PANGO_LDFLAGS}

sdl-pango.o1: sdl-pango.scm

include config.mk
