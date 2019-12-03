#lang br/quicklang

(define-macro (bf-module-begin PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

(provide (rename-out [bf-module-begin #%module-begin]))

;; fold-funcs
(define (fold-funcs apl bf-funcs)
  (for/fold ([current-apl apl])
            ([bf-func (in-list bf-funcs)])
    (apply bf-func current-apl)))

;; apply-n-times
(define (apply-n-times apl n func)
  (for/fold ([current-apl apl]) ([i n])
    (apply func current-apl)))

;; bf-program
(define-macro (bf-program OP-OR-LOOP-ARG ...)
  #'(begin
      (define first-apl (list (make-vector 30000 0) 0))
      (void (fold-funcs first-apl (list OP-OR-LOOP-ARG ...)))))

(provide bf-program)

;;bf-loop
(define-macro (bf-loop "begin" OP-OR-LOOP-ARG ... "end")
  #'(lambda (arr ptr)
      (for/fold ([current-apl (list arr ptr)])
                ([i (in-naturals)]
                 #:break (zero? (apply current-byte
                                       current-apl)))
        (fold-funcs current-apl (list OP-OR-LOOP-ARG ...)))))

(provide bf-loop)

;#'(lambda (arr ptr) ((for/fold ([current-apl (list arr ptr)]) ([i n]) (plus arr ptr))

;; bf-op
(define-macro-cases bf-op
  [(bf-op (bf-fwd "fwd")) #'gt]
  [(bf-op (bf-inc "fwd" (number N))) #'(lambda (arr ptr) (apply-n-times (list arr ptr) N gt))]
  [(bf-op (bf-rwd "rwd")) #'lt]
  [(bf-op (bf-inc "rwd" (number N))) #'(lambda (arr ptr) (apply-n-times (list arr ptr) N lt))]
  [(bf-op (bf-inc "inc")) #'plus]
  [(bf-op (bf-inc "inc" (number N))) #'(lambda (arr ptr) (apply-n-times (list arr ptr) N plus))]
  [(bf-op (bf-dec "dec")) #'minus]
  [(bf-op (bf-inc "dec" (number N))) #'(lambda (arr ptr) (apply-n-times (list arr ptr) N minus))]
  [(bf-op "write") #'period]
  [(bf-op "read") #'comma])

(provide bf-op)

;; Opera no vetor ponteiro
(define (current-byte arr ptr) (vector-ref arr ptr))

(define (set-current-byte arr ptr val)
  (define new-arr (vector-copy arr))
  (vector-set! new-arr ptr val)
  new-arr)

;; Implementa comandos
(define (gt arr ptr) (list arr (add1 ptr)))

(define (lt arr ptr) (list arr (sub1 ptr)))

(define (plus arr ptr)
  (list
   (set-current-byte arr ptr (add1 (current-byte arr ptr)))
   ptr))

(define (minus arr ptr)
  (list
   (set-current-byte arr ptr (sub1 (current-byte arr ptr)))
   ptr))

(define (period arr ptr)
  (write-byte (current-byte arr ptr))
  (list arr ptr))

(define (comma arr ptr)
  (list (set-current-byte arr ptr (read-byte)) ptr))


