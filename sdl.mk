sources += sdl.scm

sdl-events%.scm: /usr/include/SDL/SDL_events.h
	scripts/make-sdl-events > $@

sdl-keysym%.scm: /usr/include/SDL/SDL_keysym.h
	scripts/make-sdl-keysym > $@

sdl.o1: sdl.scm sdl-events%.scm sdl-keysym%.scm
	${clean-object}
	${call build-scm,-lSDL}
