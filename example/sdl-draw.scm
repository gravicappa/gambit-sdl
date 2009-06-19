(define (sdl-draw screen sprite time)
  (let* ((xc (* 0.5 (sdl#surface-w screen)))
         (yc (* 0.5 (sdl#surface-h screen)))
         (x (inexact->exact (+ xc (round (* 20 (+ 1 (sin (* time 1.0))))))))
         (y (inexact->exact (+ yc (round (* 50 (+ 1 (cos (* time 1.5))))))))
         (xs (inexact->exact (+ yc (round (* 20 (+ 1 (sin (* time 4.0)))))))))
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
