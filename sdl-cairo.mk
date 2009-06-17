sources += sdl-cairo.scm

libs := -lSDL -lcairo

sdl-cairo.o1: sdl-cairo.scm 
	${clean-object}
	${call build-scm,-lSDL -lcairo}
