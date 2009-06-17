(include "header.scm")

(c-declare #<<eof
#include <SDL/SDL.h>
eof
)

(include "ffi.scm")
(include "sdl-types.scm")
(include "sdl-const.scm")
(include "sdl-keysym%.scm")
(include "sdl-events%.scm")

(define make-sdl-rect
  (c-lambda (int int int int)
            SDL_Rect*/release-rc
            "
            SDL_Rect r, *pr = 0;
            r.x = ___arg1;
            r.y = ___arg2;
            r.w = ___arg3;
            r.h = ___arg4;
            pr = ___CAST(SDL_Rect*, ___EXT(___alloc_rc)(sizeof(r)));
            *pr = r;
            ___result_voidstar = pr;
            "))

(define fill-rect*
  (c-lambda (SDL_Surface* int int int int rgb_color)
            bool
            "
            SDL_Rect r;
            r.x = ___arg2;
            r.y = ___arg3;
            r.w = ___arg4;
            r.h = ___arg5;
            ___result = (SDL_FillRect(___arg1, &r, ___arg6) == 0);
            "))

(define fill-rect
  (c-lambda (SDL_Surface* SDL_Rect* rgb_color)
            bool
            "___result = (SDL_FillRect(___arg1, ___arg2, ___arg3) == 0);"))

(define set-clip-rect!
  (c-lambda (SDL_Surface* SDL_Rect*)
            void
            "SDL_SetClipRect"))

(define blit-surface
  (c-lambda (SDL_Surface* SDL_Rect* SDL_Surface* SDL_Rect*)
            bool
            "
            ___result = (SDL_BlitSurface(___arg1, ___arg2, ___arg3, ___arg4)
                         == 0);
            "))

(define (init flags)
  ((c-lambda (unsigned-int32)
             bool
             "___result = (SDL_Init(___arg1) == 0);")
   (apply bitwise-ior flags)))

(define exit
  (c-lambda () void "SDL_Quit"))

(define (call-with-sdl flags thunk)
  (init flags)
  (dynamic-wind
    (lambda () #f)
    thunk
    exit))

(define set-unicode!
  (c-lambda (bool) bool "SDL_EnableUNICODE"))

(define get-error
  (c-lambda () char-string "SDL_GetError"))

(define (throw-sdl-error thunk)
  (let ((msg (get-error)))
    (if (procedure? thunk)
        (thunk msg)
        (error (string-append "SDL-ERROR: " msg)))))

(define create-rgb-surface
  (c-lambda (unsigned-int32
             int
             int
             int
             unsigned-int32
             unsigned-int32
             unsigned-int32
             unsigned-int32)
            SDL_Surface*/SDL_FreeSurface
            "SDL_CreateRGBSurface"))

(define surface-pitch
  (c-lambda (SDL_Surface*)
            unsigned-int16
            "___result = ___arg1->pitch;"))

(define set-video-mode
  (c-lambda (int int int unsigned-int32)
            SDL_Surface*
            "SDL_SetVideoMode"))

(define update-rect!
  (c-lambda (SDL_Surface* int32 int32 int32 int32)
            void
            "SDL_UpdateRect"))

(define flip!
  (c-lambda (SDL_Surface*)
            bool
            "___result = (SDL_Flip(___arg1) == 0);"))

(define must-lock-surface?
  (c-lambda (SDL_Surface*)
            bool
            "___result = SDL_MUSTLOCK(___arg1);"))

(c-define (%call-event-handler handler ev)
          (scheme-object SDL_Event*)
          bool
          "call_event_handler"
          "static"
  (handler ev))

(define event-loop
  (c-lambda (scheme-object)
            void
            "
            SDL_Event ev;
            while (SDL_PollEvent(&ev) && call_event_handler(___arg1, &ev));
            "))

(define poll-event
  (c-lambda ()
            SDL_Event*/release-rc
            "
            SDL_Event ev, *pev = 0;
            if (SDL_PollEvent(&ev)) {
              pev = ___CAST(SDL_Event*, ___EXT(___alloc_rc)(sizeof(ev)));
              *pev = ev;
            }
            ___result_voidstar = pev;
            "))

(define show-cursor!
  (c-lambda (bool)
            bool
            "___result = (SDL_ShowCursor((___arg1)
                                        ? SDL_ENABLE
                                        : SDL_DISABLE)
                          == SDL_ENABLE);"))

(define lock-surface!
  (c-lambda (SDL_Surface*)
            bool
            "___result = (SDL_LockSurface(___arg1) == 0);"))

(define unlock-surface!
  (c-lambda (SDL_Surface*)
            void
            "SDL_UnlockSurface"))

(define load-bmp
  (c-lambda (char-string)
            SDL_Surface*/SDL_FreeSurface
            "SDL_LoadBMP"))


