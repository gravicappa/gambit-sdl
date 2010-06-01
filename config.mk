GSC = gsc

SDL_CONFIG = sdl-config
PKG_CONFIG = pkg-config

SDL_CFLAGS = ${shell ${SDL_CONFIG} --cflags}
SDL_LDFLAGS = ${shell ${SDL_CONFIG} --libs}
CFLAGS += ${SDL_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS}

CAIRO_CFLAGS = ${shell ${PKG_CONFIG} --cflags cairo}
CAIRO_LDFLAGS = ${shell ${PKG_CONFIG} --libs cairo}
CFLAGS += ${CAIRO_CFLAGS}
LDFLAGS += ${CAIRO_LDFLAGS}

PANGO_CFLAGS = \
	${shell ${PKG_CONFIG} --cflags pango} \
	${shell ${PKG_CONFIG} --cflags SDL_Pango}
PANGO_LDFLAGS = \
	${shell ${PKG_CONFIG} --libs pango} \
	${shell ${PKG_CONFIG} --libs SDL_Pango}
CFLAGS += ${PANGO_CFLAGS}
LDFLAGS += ${PANGO_LDFLAGS}
