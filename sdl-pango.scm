(include "header.scm")

(c-declare #<<eof
#include <pango/pango.h>
#include <SDL_Pango.h>
eof
)

(include "ffi.scm")
(c-define-type SDL_Surface* (pointer "SDL_Surface"))
(c-define-type PangoLayout* (pointer "PangoLayout"))
(%extern-object-releaser-set! "SDLPango_FreeContext"
                              "SDLPango_FreeContext(p);\n")
(%define/extern-object "SDLPango_Context" "SDLPango_FreeContext")

(define pango-init
  (c-lambda () bool "SDLPango_Init"))

(define pango-was-init?
  (c-lambda () bool "___result = (SDLPango_WasInit() == 0);"))

(define pango-create-context
  (c-lambda ()
            SDLPango_Context*/SDLPango_FreeContext
            "SDLPango_CreateContext"))

(define pango-layout
  (c-lambda (SDLPango_Context*)
            PangoLayout*
            "SDLPango_GetPangoLayout"))

(define pango-layout-width
  (c-lambda (SDLPango_Context*)
            int
            "SDLPango_GetLayoutWidth"))

(define pango-layout-height
  (c-lambda (SDLPango_Context*)
            int
            "SDLPango_GetLayoutHeight"))

(define pango-set-minimum-size!
  (c-lambda (SDLPango_Context* int int)
            void
            "SDLPango_SetMinimumSize"))

(define pango-set-markup!
  (c-lambda (SDLPango_Context* char-string)
            void
            "SDLPango_SetMarkup(___arg1, ___arg2, -1);"))

(define pango-set-text!
  (c-lambda (SDLPango_Context* char-string)
            void
            "SDLPango_SetText(___arg1, ___arg2, -1);"))

(define pango-set-language!
  (c-lambda (SDLPango_Context* char-string)
            void
            "SDLPango_SetLanguage"))

(define pango-set-dpi!
  (c-lambda (SDLPango_Context* double double)
            void
            "SDLPango_SetDpi"))

(define pango-draw
  (c-lambda (SDLPango_Context* SDL_Surface* int int)
            void
            "SDLPango_Draw"))
