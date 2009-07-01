
(load "s-pango-cairo/pango-cairo")

(define (cairo-pango-draw screen cairo pango time)
  (if (and cairo pango)
      (let ((c (sdl#sdl-cairo-instance cairo)))
        (sdl#clear-cairo-surface cairo)
        (cairo-set-source-rgba c 0.0 0.0 0.0 1.0)
        (cairo-rectangle c 0.0 0.0 200.0 100.0)
        (cairo-fill c)
        (cairo-identity-matrix c)
        (cairo-set-source-rgba c 1.0 1.0 0.7 1.0)
        (pango#cairo-show-layout c pango)
        (sdl#blit-surface (sdl#sdl-cairo-surface cairo)
                          #f
                          screen
                          #f))))

(let ((pango #f)
      (cairo #f)
      (text (string-append
              "This <i>is</i> cairo text!"
              " It supports unicode "
              "<span background=\"red\" color=\"yellow\">  ☭</span>!"
              " Даже так."
              "<span color=\"red\">Ιλι τακ.</span>")))

  (add-hook
    (init-hook)
    (lambda (s)
      (set! cairo (sdl#make-sdl-cairo (sdl#surface-w s) (sdl#surface-h s)))
      (set! pango (pango#cairo-create-layout (sdl#sdl-cairo-instance cairo)))
      (let ((font (pango#font-description-from-string "Sans 12")))
        (pango#layout-font-description-set! pango font))
      (pango#layout-width-set! pango 200)
      (pango#layout-markup-set! pango text)))

  (add-hook (draw-hook)
            (lambda (s t)
              (cairo-pango-draw s cairo pango t))))
