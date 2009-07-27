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
