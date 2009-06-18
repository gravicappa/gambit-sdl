(define (sdl-draw screen sprite time)
  (let ((x (inexact->exact (+ 160 (round (* 20 (+ 1 (sin (* time 1.0))))))))
        (y (inexact->exact (+ 120 (round (* 50 (+ 1 (cos (* time 1.5))))))))
        (xs (inexact->exact (+ 260 (round (* 20 (+ 1 (sin (* time 4.0)))))))))
    (sdl#fill-rect screen (sdl#make-sdl-rect x y 30 20) #xff00ff)
    (if sprite
        (sdl#blit-surface sprite
                          #f
                          screen
                          (sdl#make-sdl-rect xs
                                             x
                                             (sdl#surface-w sprite)
                                             (sdl#surface-h sprite))))))

(let ((sprite #f))
  (add-hook (init-hook) (lambda (s) (set! sprite (sdl#load-image "img.png"))))
  (add-hook (draw-hook) (lambda (s t) (sdl-draw s sprite t))))
