(let ((period-sec 1)
      (prev-report #f)
      (prev-time #f)
      (fps 0)
      (avg 0)
      (total 0)
      (frames 0))
  (define (report-fps)
    (display (string-append "fps[avg]: " (number->string avg) " Hz"))
    (newline))
  (add-hook (draw-hook)
            (lambda (s time)
              (let ((s (time->seconds (current-time))))
                (if prev-time
                    (let ((dt (- s prev-time)))
                      (set! fps (/ 1 dt))
                      (set! total (+ dt total))
                      (set! frames (+ 1 frames))
                      (if (or (not prev-report)
                              (> (- s prev-report) period-sec))
                          (begin
                            (set! avg (/ frames total))
                            (set! total 0)
                            (set! frames 0)
                            (set! prev-report s)
                            (report-fps)))))
                (set! prev-time s)))))
