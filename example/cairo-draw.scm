(define (cairo-draw screen cairo img time)
  (if cairo
      (begin
        (let ((c (sdl#sdl-cairo-instance cairo))
              (xc (* 0.5 (sdl#surface-w screen)))
              (yc (* 0.5 (sdl#surface-h screen))))
          (sdl#clear-cairo-surface cairo)
          (cairo-identity-matrix c)
          (cairo-set-source-rgba c 1.0 0.2 0.2 0.7)
          (cairo-arc c
                     (+ xc (* 10 (+ (sin time))))
                     (+ yc (* 40 (+ (cos (+ time 20.3)))))
                     40.
                     0.
                     (* 2 3.14))
          (cairo-fill c)
          (cairo-identity-matrix c)
          (cairo-translate c xc yc)
          (cairo-rotate c time)
          (cairo-set-source-surface c img 0. 0.)
          (cairo-paint c))
        (sdl#blit-surface (sdl#sdl-cairo-surface cairo)
                          #f
                          screen
                          #f))))

(let ((cairo #f)
      (img #f))
  (add-hook (init-hook)
            (lambda (s)
              (set! cairo (sdl#make-sdl-cairo 320 240))
              (set! img (cairo-image-surface-create-from-png "img.png"))))
  (add-hook (draw-hook) (lambda (s t) (cairo-draw s cairo img t)))
  (add-hook (free-hook)
            (lambda (s)
              (cairo-surface-destroy img))))
