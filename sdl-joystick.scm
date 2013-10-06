(%extern-object-releaser-set! "SDL_JoystickClose" "SDL_JoystickClose(p);\n")
(%define/extern-object "SDL_Joystick" "SDL_JoystickClose")

(define num-joysticks
  (c-lambda () int "SDL_NumJoysticks"))

(define joystick-open
  (c-lambda (int) SDL_Joystick* "SDL_JoystickOpen"))

(define joystick-update
  (c-lambda () void "SDL_JoystickUpdate"))

(define joystick-num-axes
  (c-lambda (SDL_Joystick*) int "SDL_JoystickNumAxes"))

(define joystick-num-buttons
  (c-lambda (SDL_Joystick*) int "SDL_JoystickNumButtons"))

(define joystick-get-axis
  (c-lambda (SDL_Joystick* int) Sint16 "SDL_JoystickGetAxis"))

(define joystick-get-button
  (c-lambda (SDL_Joystick* int) Uint8 "SDL_JoystickGetButton"))
