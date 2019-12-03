#lang br/quicklang

;; bf-reader - Calls expander

(require "grammar.rkt")
(require "lexer.rkt" brag/support)

;; Uses expander
(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module bf-mod "expander.rkt"
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)

;; Tokenizer
;; Returns the function to read, process and pass the next token
;; to the parser
(define (make-tokenizer ip [path #f])
  (port-count-lines! ip)
  (lexer-file-path path)
  (define (next-token) (bf-lexer ip))
  next-token)

(provide make-tokenizer)