(namespace ("sdl#"))
(##include "~~lib/gambit#.scm")

(declare
  (standard-bindings)
  (extended-bindings)
  (not safe))

(c-declare #<<eof
#include <SDL/SDL_image.h>
eof
)

(include "ffi.scm")
(include "sdl-types.scm")

(define load-image
  (c-lambda (char-string)
            SDL_Surface*/SDL_FreeSurface
            "IMG_Load"))
