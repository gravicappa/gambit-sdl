(define surface-flags
  (c-lambda (SDL_Surface*) Uint32 "___result = ___arg1->flags;"))

(define surface-w
  (c-lambda (SDL_Surface*) int "___result = ___arg1->w;"))

(define surface-h
  (c-lambda (SDL_Surface*) int "___result = ___arg1->h;"))

(define surface-pitch
  (c-lambda (SDL_Surface*) Uint16 "___result = ___arg1->pitch;"))

(define surface-offset
  (c-lambda (SDL_Surface*) int "___result = ___arg1->offset;"))

(define surface-unused1
  (c-lambda (SDL_Surface*) Uint32 "___result = ___arg1->unused1;"))

(define surface-locked
  (c-lambda (SDL_Surface*) Uint32 "___result = ___arg1->locked;"))

(define surface-format-version
  (c-lambda (SDL_Surface*)
            unsigned-int
            "___result = ___arg1->format_version;"))

(define surface-refcount
  (c-lambda (SDL_Surface*) int "___result = ___arg1->refcount;"))

(define surface-pixels
  (c-lambda (SDL_Surface*)
            (pointer void)
            "___result_voidstar = ___arg1->pixels;"))

(define surface-format
  (c-lambda (SDL_Surface*)
            SDL_PixelFormat*
            "___result_voidstar = ___arg1->format;"))

(define video-info-current-w
  (c-lambda (SDL_VideoInfo*) int "___result = ___arg1->current_w;"))

(define video-info-current-h
  (c-lambda (SDL_VideoInfo*) int "___result = ___arg1->current_h;"))

(define video-info-vfmt
  (c-lambda (SDL_VideoInfo*)
            SDL_PixelFormat*
            "___result_voidstar = ___arg1->vfmt;"))

(define pixelformat-bits-per-pixel
  (c-lambda (SDL_PixelFormat*) int "___result = ___arg1->BitsPerPixel;"))

(define pixelformat-bytes-per-pixel
  (c-lambda (SDL_PixelFormat*) int "___result = ___arg1->BytesPerPixel;"))
