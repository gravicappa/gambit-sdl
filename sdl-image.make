targets = sdl-image.o1

SDL_CFLAGS = ${shell sdl-config --cflags} 
SDL_LDFLAGS = ${shell sdl-config --libs} 

CFLAGS += ${SDL_CFLAGS}
LDFLAGS += ${SDL_LDFLAGS} -lSDL_image

sdl-image.o1: sdl-image.scm 

include config.mk
