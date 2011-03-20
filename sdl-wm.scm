(c-declare "#include <SDL/SDL_syswm.h>")

(define window-id
  (c-lambda ()
            int
            "
             SDL_SysWMinfo info;
             SDL_VERSION(&info.version);
             int ret = -1;
             if (1 == SDL_GetWMInfo(&info)) {
             #if defined(SDL_VIDEO_DRIVER_X11)
               if (info.subsystem == SDL_SYSWM_X11)
                 ret = info.info.x11.window;
             #endif
             }
             ___result = ret;
            "))

(define wm-set-caption
  (c-lambda (char-string char-string) void "SDL_WM_SetCaption"))

(define wm-set-caption/utf8
  (c-lambda (UTF-8-string UTF-8-string) void "SDL_WM_SetCaption"))
