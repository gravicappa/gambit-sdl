targets = sdl-pango.o1

CFLAGS += ${shell sdl-config --cflags} \
          ${shell pkg-config --cflags pango} \
					${shell pkg-config --cflags SDL_Pango}
LDFLAGS += ${shell sdl-config --libs} \
           ${shell pkg-config --libs pango} \
					 ${shell pkg-config --libs SDL_Pango}

sdl-pango.o1: sdl-pango.scm 

include config.mk
