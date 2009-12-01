(include "header.scm")

(c-declare #<<eof
#include <SDL/SDL.h>
eof
)

(include "ffi.scm")
(include "sdl-types.scm")
(include "sdl-const.scm")
(include "sdl-accessors.scm")
(include "sdl-keysym%.scm")
(include "sdl-events%.scm")

(define make-rect
  (c-lambda (int int int int)
            SDL_Rect*/release-rc
            "
            SDL_Rect r, *pr = 0;
            r.x = ___arg1;
            r.y = ___arg2;
            r.w = ___arg3;
            r.h = ___arg4;
            pr = ___CAST(SDL_Rect*, ___EXT(___alloc_rc)(sizeof(r)));
            if (pr)
              *pr = r;
            ___result_voidstar = pr;
            "))

(define fill-rect/xywh!
  (c-lambda (SDL_Surface* int int int int rgb-color)
            bool
            "
            SDL_Rect r;
            r.x = ___arg2;
            r.y = ___arg3;
            r.w = ___arg4;
            r.h = ___arg5;
            ___result = (SDL_FillRect(___arg1, &r, ___arg6) == 0);
            "))

(define fill-rect!
  (c-lambda (SDL_Surface* SDL_Rect* rgb-color)
            bool
            "___result = (SDL_FillRect(___arg1, ___arg2, ___arg3) == 0);"))

(define set-clip-rect!
  (c-lambda (SDL_Surface* SDL_Rect*)
            void
            "SDL_SetClipRect"))

(define clip-rect
  (c-lambda (SDL_Surface*)
            SDL_Rect*/release-rc
            "
            SDL_Rect *pr = 0;
            pr = ___CAST(SDL_Rect*, ___EXT(___alloc_rc)(sizeof(SDL_Rect)));
            if (pr) {
              SDL_GetClipRect(___arg1, pr);
            }
            ___result_voidstar = pr;
            "))

(define blit-surface!
  (c-lambda (SDL_Surface* SDL_Rect* SDL_Surface* SDL_Rect*)
            bool
            "
            ___result = (SDL_BlitSurface(___arg1, ___arg2, ___arg3, ___arg4)
                         == 0);
            "))

(define (init! flags)
  (c-lambda (unsigned-int32)
            bool
            "___result = (SDL_Init(___arg1) == 0);"))

(define quit!
  (c-lambda () void "SDL_Quit"))

(define (call-with-sdl flags thunk)
  (if (init! flags)
      (let ((exception-handler (current-exception-handler)))
        (with-exception-handler
          (lambda (e)
            (quit!)
            (exception-handler e))
          (lambda ()
            (thunk)
            (quit!))))
      (throw-sdl-error #f)))

(define enable-unicode!
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

(define create-rgb-surface-from
  (c-lambda ((pointer void)
             int
             int
             int
             int
             unsigned-int32
             unsigned-int32
             unsigned-int32
             unsigned-int32)
            SDL_Surface*/SDL_FreeSurface
            "SDL_CreateRGBSurfaceFrom"))

(define set-video-mode!
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

(define must-lock?
  (c-lambda (SDL_Surface*)
            bool
            "___result = SDL_MUSTLOCK(___arg1);"))

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

(define (event-loop thunk)
  (let ((ev (poll-event)))
    (if ev
        (begin
          (thunk ev)
          (event-loop thunk))
        #f)))

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

(define screen-w
  (c-lambda ()
            int
            "
             const SDL_VideoInfo *info;

             info = SDL_GetVideoInfo();
             ___result = 0;
             if (info) {
               ___result = info->current_w;
             }
            "))

(define screen-h
  (c-lambda ()
            int
            "
             const SDL_VideoInfo *info;

             info = SDL_GetVideoInfo();
             ___result = 0;
             if (info) {
               ___result = info->current_h;
             }
            "))

(define video-driver-name
  (c-lambda ()
            char-string
            "
            char name[256];
            ___result = SDL_VideoDriverName(name, 256);
            "))

(define set-alpha!
  (c-lambda (SDL_Surface* int unsigned-int8)
            bool
            "
            ___result = (SDL_SetAlpha(___arg1, ___arg2, ___arg3) == 0);"))

(define warp-mouse!
  (c-lambda (int int) void "SDL_WarpMouse"))

(define get-video-surface
  (c-lambda ()
            SDL_Surface*
            "SDL_GetVideoSurface"))

(define set-key-repeat!
  (c-lambda (int int)
            bool
            "___result = (SDL_EnableKeyRepeat(___arg1, ___arg2) == 0);"))

(include "sdl-wm.scm")
