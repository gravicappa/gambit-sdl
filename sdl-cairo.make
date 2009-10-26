targets = sdl-cairo.o1

SDL_CFLAGS = ${shell sdl-config --cflags} 
SDL_LDFLAGS = ${shell sdl-config --libs} 
CAIRO_CFLAGS = ${shell pkg-config --cflags cairo}
CAIRO_LDFLAGS = ${shell pkg-config --libs cairo}

CFLAGS += ${SDL_CFLAGS} ${CAIRO_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS} ${CAIRO_LDFLAGS}

sdl-cairo.o1: sdl-cairo.scm 

include config.mk
