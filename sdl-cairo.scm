(namespace ("sdl-cairo#"))
(##include "~~/lib/gambit#.scm")

(declare
  (standard-bindings)
  (extended-bindings)
  (not safe))

(c-declare #<<end-of-c

#include <stdlib.h>
#include <SDL/SDL.h>
#include <cairo/cairo.h>

typedef struct sdl_cairo {
  int width;
  int height;
  void *blit;
  SDL_Surface *sdl_blit;
  cairo_surface_t *cairo_blit;
  cairo_t *cairo;
} sdl_cairo_t;

#define DEBUG

#ifdef DEBUG

#include <stdio.h>
#include <stdarg.h>

void
log_printf(char *string, ...)
{
  va_list args;
  va_start(args, string);
  vfprintf(stderr, string, args);
  va_end(args);
}

#else /*DEBUG*/

void log_printf(char *string, ...)
{
}

#endif /*DEBUG*/

void
free_blit_surface(struct sdl_cairo *c)
{
  if (c) {
   if (c->cairo) {
      cairo_destroy(c->cairo);
      c->cairo = 0;
    }
    if (c->cairo_blit) {
      cairo_surface_destroy(c->cairo_blit);
      c->cairo_blit = 0;
    }
    if (c->sdl_blit) {
      SDL_FreeSurface(c->sdl_blit);
      c->sdl_blit = 0;
    }
    if (c->blit) {
      free(c->blit);
      c->blit = 0;
    }
  }
}

void
free_sdl_cairo(struct sdl_cairo *c)
{
  if (c) {
    free_blit_surface(c);
    free(c);
  }
}

int
init_sdl_surface(struct sdl_cairo *c)
{
  int ret = 1;
  c->blit = realloc(c->blit, c->width * c->height * 4);
  if (c->blit) {
    c->sdl_blit = SDL_CreateRGBSurfaceFrom(c->blit,
                                           c->width, 
                                           c->height, 
                                           32,
                                           c->width * 4,
                                           0x00ff0000,
                                           0x0000ff00,
                                           0x000000ff,
                                           0xff000000);

    if (c->sdl_blit) {
      ret = 0;
    } else {
      log_printf(";; Error: unable to create SDL surface\n");
      free_blit_surface(c);
    }
  } else {
    log_printf(";; Error: unable to allocate blit buffer\n");
  }
  return ret;
}

int
init_cairo_on_surface(struct sdl_cairo *c)
{
  int ret = 1;
  if (c) {
    c->cairo_blit = cairo_image_surface_create_for_data(c->blit,
                                                        CAIRO_FORMAT_ARGB32,
                                                        c->width,
                                                        c->height,
                                                        c->width * 4);
    if (c->cairo_blit) {
      c->cairo = cairo_create(c->cairo_blit);
      if (c->cairo) {
        /*cairo_set_antialias(c->cairo, CAIRO_ANTIALIAS_SUBPIXEL);*/
        ret = 0;
      } else {
        log_printf(";; Error: unable to create cairo\n");
        free_blit_surface(c);
      }
    } else {
      log_printf(";; Error: unable to create cairo surface\n");
      free_blit_surface(c);
    }
  }
  return ret;
}

int
resize_sdl_cairo(struct sdl_cairo *c, int width, int height)
{
  int ret = 1;
  if (c) {
    free_blit_surface(c);
    c->width = width;
    c->height = height;
    if (!(init_sdl_surface(c) || init_cairo_on_surface(c))) {
      ret = 0;
    }
  }
  return ret;
}

struct sdl_cairo *
create_sdl_cairo(int width, int height)
{
  struct sdl_cairo *c;

  c = malloc(sizeof(struct sdl_cairo));
  if (c) {
    memset(c, 0, sizeof(struct sdl_cairo));
    if (resize_sdl_cairo(c, width, height)) {
      log_printf(";; Error: failed to create surfaces\n");
      free_sdl_cairo(c);
      c = 0;
    }
  } else {
    log_printf(";; Error: failed to allocate memory\n");
  }
  return c;
}

void
clear_sdl_surface(struct sdl_cairo *c)
{
  if (c && c->blit)
    memset(c->blit, 0, 4 * c->width * c->height);
}

end-of-c
)

(include "ffi.scm")
(%extern-object-releaser-set! "free_sdl_cairo" "free_sdl_cairo(p);\n")

(%define/extern-object "sdl_cairo_t" "free_sdl_cairo")
(c-define-type cairo-t* (pointer "cairo_t"))
(c-define-type SDL_Surface* (pointer "SDL_Surface"))

(define +cairo-antialias-default+ 
        ((c-lambda () int "___result = CAIRO_ANTIALIAS_DEFAULT;")))

(define +cairo-antialias-none+ 
        ((c-lambda () int "___result = CAIRO_ANTIALIAS_NONE;")))

(define +cairo-antialias-gray+ 
        ((c-lambda () int "___result = CAIRO_ANTIALIAS_GRAY;")))

(define +cairo-antialias-subpixel+ 
        ((c-lambda () int "___result = CAIRO_ANTIALIAS_SUBPIXEL;")))

(define make-sdl-cairo
  (c-lambda (int int)
            sdl_cairo_t*/free_sdl_cairo
            "create_sdl_cairo"))

(define resize-sdl-cairo!
  (c-lambda (sdl_cairo_t* int int)
            bool
            "___result = (resize_sdl_cairo(___arg1, ___arg2, ___arg3) == 0);"))

(define cairo
  (c-lambda (sdl_cairo_t*)
            cairo-t*
            "___result_voidstar = ___arg1->cairo;"))

(define surface
  (c-lambda (sdl_cairo_t*)
            SDL_Surface*
            "___result_voidstar = ___arg1->sdl_blit;"))

(define clear-surface!
  (c-lambda (sdl_cairo_t*)
            void
            "clear_sdl_surface"))
