(define (pango-draw screen pango time)
  #f)

(let ((pango #f)
      (surface #f))
  (add-hook (init-hook)
            (lambda (s)
              (sdl#pango-init)
              (set! surface (sdl#create-rgb-surface
                             0
                             (sdl#surface-w s)
                             (sdl#surface-h s)
                             32
                             #x00ff0000
                             #x0000ff00
                             #x000000ff
                             #xff000000))
              (set! pango (sdl#pango-create-context))
              (sdl#pango-set-minimum-size! pango 100 0)
              (sdl#pango-set-default-color!
               pango
               sdl#+pango-transparent-back-white-letter+)
              (sdl#pango-set-markup! pango "This is <i>pango</i>")))
  (add-hook (draw-hook)
            (lambda (s t)
              (let* ((xc (* 0.5 (sdl#surface-w s)))
                     (yc (* 0.5 (sdl#surface-h s)))
                     (x (inexact->exact (round (+ xc (* 40 (sin (+ t 0.4)))))))
                     (y (inexact->exact (round (+ yc (* 40 (cos (* t 1.3))))))))
                (sdl#pango-draw pango surface x y)
                (sdl#blit-surface surface
                                  #f
                                  s
                                  #f)))))
