(define-macro (%eval-at-macroexpand expr)
  (eval expr (scheme-report-environment 5))
  #f)

(%eval-at-macroexpand
  (define %ffi-releasers (make-table)))

(define-macro (%extern-object-releaser-set! name code)
  (eval `(table-set! %ffi-releasers ,name ,code)
        (scheme-report-environment 5))
  #f)

(%extern-object-releaser-set! "release-rc" "___EXT(___release_rc)(p);\n")

(%eval-at-macroexpand
  (define (%string-replace new old str)
    (let ((tgt (string-copy str))
          (len (string-length str)))
      (let loop ((i 0))
        (if (< i len)
            (let ((c (string-ref str i)))
              (string-set! tgt i (if (char=? c old) new c))
              (loop (+ i 1)))
            tgt)))))

(define-macro (%define/extern-object name type)
  (let* ((sym (string->symbol name))
         (ptr (string->symbol (string-append name "*")))
         (ptr/free (string->symbol (string-append name "*/" type)))
         (releaser (string-append type "_" name))
         (c-releaser (%string-replace #\_ #\- releaser)))
    `(begin
       (c-declare
         ,(string-append
            "___SCMOBJ " c-releaser "(void *ptr)\n"
            "{\n"
            name " *p = ptr;\n"
            "#ifdef debug_free\n"
            "printf(\"" c-releaser "(%p)\\n\", p);\n"
            "fflush(stdout);\n"
            "#endif\n"
            ;"#ifdef really_free\n"
            (table-ref %ffi-releasers type)
            ;"#endif\n"
            "return ___FIX(___NO_ERR);\n"
            "}\n"))
       (c-define-type ,sym ,name)
       (c-define-type ,ptr (pointer ,sym (,ptr)))
       (c-define-type ,ptr/free (pointer ,sym (,ptr) ,c-releaser)))))
