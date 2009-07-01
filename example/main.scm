
(load "../sdl")
(load "../sdl-image")
(load "../sdl-cairo")
(load "../sdl-pango")
(load "Cairo-r2/cairo")

(load "hooks")
(load "sdl-draw")
(load "cairo-draw")
(load "pango-draw")
(load "pango-cairo-draw")

(define *running?* (make-parameter #t))
(define *events* (make-parameter (make-table)))

(define (add-event id thunk)
  (table-set! (*events*) id thunk))

(define (dispatch-events ev)
  (let ((fn (table-ref (*events*) (sdl#event-type ev) #f)))
    (if fn
        (fn ev))))

(add-event
 sdl#+quit+
 (lambda (ev) (*running?* #f)))

(add-event
 sdl#+key-down+
 (lambda (ev)
   (display "key-pressed")
   (newline)
   (if (eq? (sdl#keyboard-event-keysym-sym ev) sdl#+k-escape+)
       (*running?* #f))))

(define (main-loop)
  (let ((screen (sdl#set-video-mode 1024
                                    768
                                    0
                                    (bitwise-ior sdl#+anyformat+
                                                 sdl#+doublebuf+))))
    (run-hook (init-hook) screen)
    ;(sdl#pango-init)
    (if screen
        (let loop ()
          (if (*running?*)
              (begin
                (sdl#fill-rect screen #f 0)
                (run-hook (draw-hook) screen (time->seconds (current-time)))
                (sdl#update-rect! screen 0 0 0 0)
                (sdl#flip! screen)
                (thread-sleep! 1/60)
                (sdl#event-loop dispatch-events)
                (loop))))
        (sdl#throw-sdl-error #f))
    (run-hook (free-hook))))

(define (main)
  (sdl#call-with-sdl (list sdl#+init-video+) main-loop)
  (##gc))

(main)
