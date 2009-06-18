targets = sdl-image.o1

CFLAGS += ${shell sdl-config --cflags}
LDFLAGS += ${shell sdl-config --libs}

sdl-image.o1: sdl-image.scm 

include config.mk
