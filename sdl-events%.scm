;; SDL_Event type

(define event-type
  (c-lambda (SDL_Event*)
	          Uint8
						"___result = ___arg1->type;"))

;; SDL_ActiveEvent accessors

(define active-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->active.type;"))

(define active-event-gain
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->active.gain;"))

(define active-event-state
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->active.state;"))

;; SDL_ExposeEvent accessors

(define expose-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->expose.type;"))

;; SDL_JoyAxisEvent accessors

(define joy-axis-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jaxis.type;"))

(define joy-axis-event-which
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jaxis.which;"))

(define joy-axis-event-axis
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jaxis.axis;"))

(define joy-axis-event-value
  (c-lambda (SDL_Event*) 
            Sint16 
            "___result = ___arg1->jaxis.value;"))

;; SDL_JoyBallEvent accessors

(define joy-ball-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jball.type;"))

(define joy-ball-event-which
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jball.which;"))

(define joy-ball-event-ball
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jball.ball;"))

(define joy-ball-event-xrel
  (c-lambda (SDL_Event*) 
            Sint16 
            "___result = ___arg1->jball.xrel;"))

(define joy-ball-event-yrel
  (c-lambda (SDL_Event*) 
            Sint16 
            "___result = ___arg1->jball.yrel;"))

;; SDL_JoyButtonEvent accessors

(define joy-button-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jbutton.type;"))

(define joy-button-event-which
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jbutton.which;"))

(define joy-button-event-button
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jbutton.button;"))

(define joy-button-event-state
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jbutton.state;"))

;; SDL_JoyHatEvent accessors

(define joy-hat-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jhat.type;"))

(define joy-hat-event-which
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jhat.which;"))

(define joy-hat-event-hat
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jhat.hat;"))

(define joy-hat-event-value
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->jhat.value;"))

;; SDL_KeyboardEvent accessors

(define keyboard-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->key.type;"))

(define keyboard-event-which
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->key.which;"))

(define keyboard-event-state
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->key.state;"))

;; SDL_MouseButtonEvent accessors

(define mouse-button-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->button.type;"))

(define mouse-button-event-which
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->button.which;"))

(define mouse-button-event-button
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->button.button;"))

(define mouse-button-event-state
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->button.state;"))

(define mouse-button-event-x
  (c-lambda (SDL_Event*) 
            Uint16 
            "___result = ___arg1->button.x;"))

(define mouse-button-event-y
  (c-lambda (SDL_Event*) 
            Uint16 
            "___result = ___arg1->button.y;"))

;; SDL_MouseMotionEvent accessors

(define mouse-motion-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->motion.type;"))

(define mouse-motion-event-which
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->motion.which;"))

(define mouse-motion-event-state
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->motion.state;"))

(define mouse-motion-event-x
  (c-lambda (SDL_Event*) 
            Uint16 
            "___result = ___arg1->motion.x;"))

(define mouse-motion-event-y
  (c-lambda (SDL_Event*) 
            Uint16 
            "___result = ___arg1->motion.y;"))

(define mouse-motion-event-xrel
  (c-lambda (SDL_Event*) 
            Sint16 
            "___result = ___arg1->motion.xrel;"))

(define mouse-motion-event-yrel
  (c-lambda (SDL_Event*) 
            Sint16 
            "___result = ___arg1->motion.yrel;"))

;; SDL_QuitEvent accessors

(define quit-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->quit.type;"))

;; SDL_ResizeEvent accessors

(define resize-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->resize.type;"))

(define resize-event-w
  (c-lambda (SDL_Event*) 
            int 
            "___result = ___arg1->resize.w;"))

(define resize-event-h
  (c-lambda (SDL_Event*) 
            int 
            "___result = ___arg1->resize.h;"))

;; SDL_SysWMEvent accessors

(define syswm-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->syswm.type;"))

;; SDL_UserEvent accessors

(define user-event-type
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->user.type;"))

(define user-event-code
  (c-lambda (SDL_Event*) 
            int 
            "___result = ___arg1->user.code;"))

(define keyboard-event-keysym-scancode
  (c-lambda (SDL_Event*) 
            Uint8 
            "___result = ___arg1->key.keysym.scancode;"))

(define keyboard-event-keysym-sym
  (c-lambda (SDL_Event*) 
            SDLKey 
            "___result = ___arg1->key.keysym.sym;"))

(define keyboard-event-keysym-mod
  (c-lambda (SDL_Event*) 
            SDLMod 
            "___result = ___arg1->key.keysym.mod;"))

(define keyboard-event-keysym-unicode
  (c-lambda (SDL_Event*) 
            Uint16 
            "___result = ___arg1->key.keysym.unicode;"))

