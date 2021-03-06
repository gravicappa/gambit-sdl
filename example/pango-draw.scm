(define (pango-draw screen pango time)
  #f)

(let ((pango #f)
      (surface #f)
      (text (string-append
              "This <i>is</i> pango text!"
              " It supports unicode "
              "<span background=\"red\" color=\"yellow\">  ☭</span>!"
              " Даже так."
              "<span color=\"red\">Ιλι τακ.</span>")))
  (add-hook (init-hook)
            (lambda (s)
              (sdl-pango#init!)
              (set! surface (sdl#create-rgb-surface
                              0
                              (sdl#surface-w s)
                              (sdl#surface-h s)
                              32
                              #x00ff0000
                              #x0000ff00
                              #x000000ff
                              #xff000000))
              (set! pango (sdl-pango#create-context))
              (sdl-pango#set-minimum-size! pango 200 0)
              (sdl-pango#set-default-color!
                pango
                (sdl-pango#matrix<-rgb 255 1.0 0.7))
              (sdl-pango#set-markup! pango text)))
  (add-hook (draw-hook)
            (lambda (s t)
              (let* ((xc (* 0.5 (sdl#surface-w s)))
                     (yc (* 0.5 (sdl#surface-h s)))
                     (x (inexact->exact (round (+ xc (* 40 (sin (+ t 0.4)))))))
                     (y (inexact->exact (round (+ yc (* 40 (cos (* t 1.3))))))))
                (sdl-pango#draw! pango surface x y)
                (sdl#blit-surface! surface #f s #f)
                (sdl-pango#draw! pango surface 10 y)
                (sdl#blit-surface! surface #f s #f)
                ))))
