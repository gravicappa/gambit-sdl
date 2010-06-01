(namespace ("sdl-cairo#"))
(##include "~~lib/gambit#.scm")

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

#define AMASK 0xff000000
#define RMASK 0x00ff0000
#define GMASK 0x0000ff00
#define BMASK 0x000000ff

#define ASHIFT 24
#define RSHIFT 16
#define GSHIFT 8
#define BSHIFT 0

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
                                           c->width, c->height, 32,
                                           c->width * 4,
                                           RMASK, GMASK, BMASK, AMASK);

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

#define RECIPROCAL_BITS 16
static unsigned const reciprocal_table[256] = {

#define ceil_div(a, b) ((a) + (b) - 1) / (b)
#define R(i)  ((i) ? ceil_div(255 * (1 << RECIPROCAL_BITS), (i)) : 0)
#define R1(i) R(i),  R(i + 1),   R(i + 2),   R(i + 3)
#define R2(i) R1(i), R1(i + 4),  R1(i + 8),  R1(i + 12)
#define R3(i) R2(i), R2(i + 16), R2(i + 32), R2(i + 48)

  R3(0), R3(64), R3(128), R3(192)
};
 
#define RSHIFT 16
#define GSHIFT 8
#define BSHIFT 0

void
premult_pixels_onto(struct sdl_cairo *c, SDL_Rect *rect)
{
  if (c && c->blit && rect) {
    int i, j, dp;
    unsigned int *pix = (unsigned int *)c->blit;

    if (rect->x < 0) {
      rect->w += rect->x;
      rect->x = 0;
    }
    if (rect->x + rect->w >= c->width) {
      rect->w = c->width - rect->x - 1;
    }
    if (rect->y < 0) {
      rect->h += rect->y;
      rect->y = 0;
    }
    if (rect->y + rect->h >= c->height) {
      i = c->height - rect->y - 1;
      rect->h = (i >= 0) ? i : 0;
    }

    if (rect->w > 0 && rect->h > 0) {
      pix += rect->x + rect->y * c->width;
      dp = c->width - rect->w;
      for (i = rect->h; i; --i) {
        int r, g, b, m;

        for (j = rect->w; j; --j, ++pix) {
          m = reciprocal_table[(*pix & AMASK) >> ASHIFT];
          r = (((*pix & RMASK) * m) >> RECIPROCAL_BITS) & RMASK;
          g = (((*pix & GMASK) * m) >> RECIPROCAL_BITS) & GMASK;
          b = (((*pix & BMASK) * m) >> RECIPROCAL_BITS) & BMASK;
          *pix = r | g | b | (*pix & AMASK);
        }
        pix += dp;
      }
    }
  }
}

end-of-c
)

(include "ffi.scm")
(%extern-object-releaser-set! "free_sdl_cairo" "free_sdl_cairo(p);\n")

(%define/extern-object "sdl_cairo_t" "free_sdl_cairo")
(c-define-type cairo-t* (pointer "cairo_t"))
(c-define-type SDL_Surface* (pointer "SDL_Surface"))
(c-define-type SDL_Rect* (pointer "SDL_Rect"))

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

(define premultiply-pixels!
  (c-lambda (sdl_cairo_t* SDL_Rect*)
            void
            "premult_pixels_onto"))
