targets = sdl-pango.o1

SDL_CFLAGS = ${shell sdl-config --cflags} 
SDL_LDFLAGS = ${shell sdl-config --libs} 
PANGO_CFLAGS = \
	${shell pkg-config --cflags pango} \
	${shell pkg-config --cflags SDL_Pango} 
PANGO_LDFLAGS = \
	${shell pkg-config --libs pango} \
	${shell pkg-config --libs SDL_Pango} 

CFLAGS += ${SDL_CFLAGS} ${PANGO_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS} ${PANGO_LDFLAGS}

sdl-pango.o1: sdl-pango.scm 

include config.mk
