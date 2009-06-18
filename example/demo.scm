
(load "../sdl")
(load "../sdl-image")
(load "../sdl-cairo")
(load "~/develop/research/Cairo-r2/cairo")

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

(define (draw screen sprite time)
  (let ((x (inexact->exact (+ 160 (round (* 20 (+ 1 (sin (* time 1.0))))))))
        (y (inexact->exact (+ 120 (round (* 50 (+ 1 (cos (* time 1.5))))))))
        (xs (inexact->exact (+ 260 (round (* 20 (+ 1 (sin (* time 4.0)))))))))
    (sdl#fill-rect screen (sdl#make-sdl-rect x y 30 20) #xff00ff)
    (if sprite
        (sdl#blit-surface sprite
                          #f
                          screen
                          (sdl#make-sdl-rect xs x 72 56)))
    ))

(define (draw-vectors screen cr time)
  (if cr
      (begin
        (let ((c (sdl#sdl-cairo-instance cr)))
          (sdl#clear-cairo-surface cr)
          ;(cairo-set-source-rgba c 0.0 0.2 0.2 0.0)
          ;(cairo-paint c)
          (cairo-set-source-rgba c 1.0 0.2 0.2 0.7)
          (cairo-arc c
                     (* 100 (+ 2 (sin time)))
                     (* 100 (+ 2 (cos (+ time 20.3))))
                     40.
                     0.
                     (* 2 3.14))
          (cairo-fill c))
        (sdl#blit-surface (sdl#sdl-cairo-surface cr)
                          #f
                          screen
                          #f))))

(define (main-loop)
  (let ((screen (sdl#set-video-mode 320
                                    240
                                    0
                                    (bitwise-ior sdl#+anyformat+
                                                 sdl#+doublebuf+)))
        (sprite (sdl#load-image "img.png"))
        (cr (sdl#make-sdl-cairo 320 240)))
    (if screen
        (let loop ()
          (if (*running?*)
              (begin
                (sdl#fill-rect screen #f 0)
                (draw screen sprite (time->seconds (current-time)))
                (draw-vectors screen cr (time->seconds (current-time)))
                (sdl#update-rect! screen 0 0 0 0)
                (sdl#flip! screen)
                (thread-sleep! 1/60)
                (sdl#event-loop dispatch-events)
                (loop))))
        (sdl#throw-sdl-error #f))))

(sdl#call-with-sdl (list sdl#+init-video+) main-loop)
