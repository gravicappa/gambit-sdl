targets = sdl-cairo.o1

CFLAGS += ${shell sdl-config --cflags} ${shell pkg-config --cflags cairo}
LDFLAGS += ${shell sdl-config --libs} ${shell pkg-config --libs cairo}

sdl-cairo.o1: sdl-cairo.scm 

include config.mk
