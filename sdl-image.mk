sources += sdl-image.scm

libs := -lSDL -lSDL_image

sdl-image.o1: sdl-image.scm 
	${clean-object}
	${call build-scm,-lSDL -lSDL_image}
