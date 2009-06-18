(define surface-flags
  (c-lambda (SDL_Surface*)
            Uint32
            "___result = ___arg1->flags;"))

(define surface-w
  (c-lambda (SDL_Surface*)
            int
            "___result = ___arg1->w;"))

(define surface-h
  (c-lambda (SDL_Surface*)
            int
            "___result = ___arg1->h;"))

(define surface-pitch
  (c-lambda (SDL_Surface*)
            Uint16
            "___result = ___arg1->pitch;"))

(define surface-offset
  (c-lambda (SDL_Surface*)
            int
            "___result = ___arg1->offset;"))

(define surface-clip-rect
  (c-lambda (SDL_Surface*)
            SDL_Rect*/release-rc
            "
            SDL_Rect *pr;
            pr = ___CAST(SDL_Rect*, ___EXT(___alloc_rc)(sizeof(SDL_Rect)));
            ___result_voidstar = pr;
            "))

(define surface-unused1
  (c-lambda (SDL_Surface*)
            Uint32
            "___result = ___arg1->unused1;"))

(define surface-locked
  (c-lambda (SDL_Surface*)
            Uint32
            "___result = ___arg1->locked;"))

(define surface-format-version
  (c-lambda (SDL_Surface*)
            unsigned-int
            "___result = ___arg1->format_version;"))

(define surface-refcount
  (c-lambda (SDL_Surface*)
            int
            "___result = ___arg1->refcount;"))

