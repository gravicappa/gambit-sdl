targets = sdl-pango.o1

CFLAGS += ${shell sdl-config --cflags} ${shell pkg-config --cflags pango}
LDFLAGS += ${shell sdl-config --libs} ${shell pkg-config --libs pango}

sdl-pango.o1: sdl-pango.scm 

include config.mk
