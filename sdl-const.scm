;; Init constants for SDL subsystems

(define +init-timer+ #x00000001)
(define +init-audio+ #x00000010)
(define +init-video+ #x00000020)
(define +init-cdrom+ #x00000100)
(define +init-joystick+ #x00000200)
(define +init-noparachute+ #x00100000)
(define +init-eventthread+ #x01000000)
(define +init-everything+ #x0000FFFF)

;; Surface defines

(define +swsurface+ #x00000000) ; For CreateRGBSurface
(define +hwsurface+ #x00000001)
(define +asyncblit+ #x00000004)
(define +anyformat+ #x10000000) ; For SetVideoMode
(define +hwpalette+ #x20000000)
(define +doublebuf+ #x40000000)
(define +fullscreen+ #x80000000)
(define +opengl+ #x00000002)
(define +openglblit+ #x0000000A)
(define +resizable+ #x00000010)
(define +noframe+ #x00000020)
(define +hwaccel+ #x00000100) ; Internal (read-only)
(define +srccolorkey+ #x00001000)
(define +rleaccelok+ #x00002000)
(define +rleaccel+ #x00004000)
(define +srcalpha+ #x00010000)
(define +prealloc+ #x01000000)

;; GL attributes (SDL_GLattr)

(define +gl-red-size+ 0)
(define +gl-green-size+ 1)
(define +gl-blue-size+ 2)
(define +gl-alpha-size+ 3)
(define +gl-buffer-size+ 4)
(define +gl-doublebuffer+ 5)
(define +gl-depth-size+ 6)
(define +gl-stencil-size+ 7)
(define +gl-accum-red-size+ 8)
(define +gl-accum-green-size+ 9)
(define +gl-accum-blue-size+ 10)
(define +gl-accum-alpha-size+ 11)

;; SDL event type constants

(define +no-event+ 0)
(define +active-event+ 1)
(define +key-down+ 2)
(define +key-up+ 3)
(define +mouse-motion+ 4)
(define +mouse-button-down+ 5)
(define +mouse-button-up+ 6)
(define +joy-axis-motion+ 7)
(define +joy-ball-motion+ 8)
(define +joy-hat-motion+ 9)
(define +joy-button-down+ 10)
(define +joy-button-up+ 11)
(define +quit+ 12)
(define +sys-wm-event+ 13)
(define +event-reserved-a+ 14)
(define +event-reserved-b+ 15)
(define +video-resize+ 16)
(define +video-expose+ 17)
(define +event-reserved-2+ 18)
(define +event-reserved-3+ 19)
(define +event-reserved-4+ 20)
(define +event-reserved-5+ 21)
(define +event-reserved-6+ 22)
(define +event-reserved-7+ 23)
(define +user-event+ 24)
(define +num-events+ 32)

;; Event actions

(define +add-event+ 0)
(define +peek-event+ 1)
(define +get-event+ 2)

;; Input Grabbing modes

(define +grab-query+ -1)
(define +grab-off+ 0)
(define +grab-on+ 1)

;; Keyboard/Mouse state enum

(define +pressed+ 1)
(define +released+ 0)

;; Mouse button enum

(define +button-left+ 1)
(define +button-middle+ 2)
(define +button-right+ 3)

;; Joystick hat enum

(define +hat-centered+ 0)
(define +hat-up+ 1)
(define +hat-right+ 2)
(define +hat-down+ 4)
(define +hat-left+ 8)
(define +hat-rightup+ (bitwise-ior +hat-right+ +hat-up+))
(define +hat-rightdown+ (bitwise-ior +hat-right+ +hat-down+))
(define +hat-leftup+ (bitwise-ior +hat-left+ +hat-up+))
(define +hat-leftdown+ (bitwise-ior +hat-left+ +hat-down+))

;; Activate state

(define +app-mouse-focus+ 1)
(define +app-input-focus+ 2)
(define +app-active+ 4)

;; SDL boolean type

(define +false+ 0)
(define +true+ 1)

;; Audio

(define +audio-u8+ #x0008)
(define +audio-s8+ #x8008)
(define +audio-u16lsb+ #x0010)
(define +audio-s16lsb+ #x8010)
(define +audio-u16msb+ #x1010)
(define +audio-s16msb+ #x9010)
(define +audio-u16+ +audio-u16lsb+)
(define +audio-s16+ +audio-s16lsb+)

;; CD

(define +max-tracks+ 99)

(define +audio-track+ #x00)
(define +data-track+ #x04)

(define +trayempty+ 0)
(define +stopped+ 1)
(define +playing+ 2)
(define +paused+ 3)
(define +cd-error+ -1)

;; Misc
(define +default-repeat-delay+ 500)
(define +default-repeat-interval+ 30)
