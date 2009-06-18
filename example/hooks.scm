(define (add-hook hook thunk)
  (set-cdr! hook (append (cdr hook) (list thunk))))

(define (run-hook hook . args)
  (if (and (pair? hook) (pair? (cdr hook)))
    (for-each (lambda (f) (apply f args))
              (cdr hook))))

(define (make-hook)
  (make-parameter (cons #f '())))
  

(define init-hook (make-hook))
(define draw-hook (make-hook))
(define free-hook (make-hook))
