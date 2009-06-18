(define (cairo-draw screen cairo time)
  (if cairo
      (begin
        (let ((c (sdl#sdl-cairo-instance cairo)))
          (sdl#clear-cairo-surface cairo)
          (cairo-set-source-rgba c 1.0 0.2 0.2 0.7)
          (cairo-arc c
                     (* 100 (+ 2 (sin time)))
                     (* 100 (+ 2 (cos (+ time 20.3))))
                     40.
                     0.
                     (* 2 3.14))
          (cairo-fill c))
        (sdl#blit-surface (sdl#sdl-cairo-surface cairo)
                          #f
                          screen
                          #f))))

(let ((cairo #f))
  (add-hook (init-hook)
            (lambda (s) (set! cairo (sdl#make-sdl-cairo 320 240))))
  (add-hook (draw-hook) (lambda (s t) (cairo-draw s cairo t))))
