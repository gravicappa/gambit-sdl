(namespace ("sdl-pango#"))
(##include "~~/lib/gambit#.scm")

(declare
  (standard-bindings)
  (extended-bindings)
  (not safe))

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
(%define/extern-object "SDLPango_Matrix" "release-rc")

(define init!
  (c-lambda () bool "SDLPango_Init"))

(define was-init?
  (c-lambda () bool "___result = (SDLPango_WasInit() == 0);"))

(define create-context
  (c-lambda ()
            SDLPango_Context*/SDLPango_FreeContext
            "SDLPango_CreateContext"))

(define pango-layout
  (c-lambda (SDLPango_Context*)
            PangoLayout*
            "SDLPango_GetPangoLayout"))

(define layout-width
  (c-lambda (SDLPango_Context*)
            int
            "SDLPango_GetLayoutWidth"))

(define layout-height
  (c-lambda (SDLPango_Context*)
            int
            "SDLPango_GetLayoutHeight"))

(define set-minimum-size!
  (c-lambda (SDLPango_Context* int int)
            void
            "SDLPango_SetMinimumSize"))

(define set-markup!
  (c-lambda (SDLPango_Context* UTF-8-string)
            void
            "SDLPango_SetMarkup(___arg1, ___arg2, -1);"))

(define set-text!
  (c-lambda (SDLPango_Context* UTF-8-string)
            void
            "SDLPango_SetText(___arg1, ___arg2, -1);"))

(define set-language!
  (c-lambda (SDLPango_Context* char-string)
            void
            "SDLPango_SetLanguage"))

(define set-dpi!
  (c-lambda (SDLPango_Context* double double)
            void
            "SDLPango_SetDpi"))

(define draw!
  (c-lambda (SDLPango_Context* SDL_Surface* int int)
            void
            "SDLPango_Draw"))

(define +black-back+
  ((c-lambda ()
             SDLPango_Matrix*
             "___result_voidstar = (SDLPango_Matrix *)MATRIX_BLACK_BACK;")))

(define +white-back+
  ((c-lambda ()
             SDLPango_Matrix*
             "___result_voidstar = (SDLPango_Matrix *)MATRIX_WHITE_BACK;")))

(define +transparent-back-black-letter+
  ((c-lambda () 
             SDLPango_Matrix* 
             "___result_voidstar 
               = (SDLPango_Matrix *)MATRIX_TRANSPARENT_BACK_BLACK_LETTER;")))

(define +transparent-back-white-letter+
  ((c-lambda () 
             SDLPango_Matrix* 
             "___result_voidstar 
               = (SDLPango_Matrix *)MATRIX_TRANSPARENT_BACK_WHITE_LETTER;")))

(define +transparent-back-transparent-letter+
  ((c-lambda
    ()
    SDLPango_Matrix*
    "___result_voidstar 
      = (SDLPango_Matrix *)MATRIX_TRANSPARENT_BACK_TRANSPARENT_LETTER;")))

(define set-default-color!
  (c-lambda (SDLPango_Context* SDLPango_Matrix*)
            void
            "SDLPango_SetDefaultColor"))

(define matrix<-rgba
  (let ((color (lambda (c)
                 (cond ((and (exact? c) (integer? c)) c)
                       (else (round (* 255 (inexact->exact c))))))))
    (lambda (r g b a)
      ((c-lambda (unsigned-int8 unsigned-int8 unsigned-int8 unsigned-int8)
                 SDLPango_Matrix*/release-rc
                 "
                  SDLPango_Matrix colormat, *pcolormat;
                  int i, j;

                  for (i = 0; i < 4; ++i) {
                    colormat.m[0][i] = ___arg1;
                    colormat.m[1][i] = ___arg2;
                    colormat.m[2][i] = ___arg3;
                  }
                  colormat.m[3][0] = 0;
                  colormat.m[3][1] = ___arg4;
                  colormat.m[3][2] = 0;
                  colormat.m[3][3] = 0;

                  pcolormat = ___CAST(SDLPango_Matrix*,
                                      ___EXT(___alloc_rc)(sizeof(colormat)));
                  if (pcolormat)
                    *pcolormat = colormat;
                  ___result_voidstar = pcolormat;
                 "
                 )
       (color r)
       (color g)
       (color b)
       (color a)))))

(define (matrix<-rgb r g b)
  (matrix<-rgba r g b 255))
