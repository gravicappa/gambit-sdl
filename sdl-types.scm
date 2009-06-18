
(c-define-type rgb_color int32)
(c-define-type Uint8 unsigned-int8)
(c-define-type Sint8 int8)
(c-define-type Uint16 unsigned-int16)
(c-define-type Sint16 int16)
(c-define-type Uint32 unsigned-int32)
(c-define-type SDLKey int)
(c-define-type SDLMod int)
(%define/extern-object "SDL_Rect" "release-rc")
(%define/extern-object "SDL_Event" "release-rc")

(%extern-object-releaser-set! "SDL_FreeSurface" "SDL_FreeSurface(p);\n")
(%define/extern-object "SDL_Surface" "SDL_FreeSurface")
