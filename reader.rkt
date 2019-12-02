#lang br/quicklang

;; BF - Leitor Versão 3 - Chama expansor funcional

;; Usa Parser Versão 1
(require "grammar.rkt")
(require "lexer.rkt" brag/support)

;; Usa a versão expansor funcional
(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module bf-mod "expander.rkt"
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)

;; tokenizer
;; retorna função para ler, processar e repassar o próximo token
;; para o parser
(define (make-tokenizer ip [path #f])
  (port-count-lines! ip)
  (lexer-file-path path)
  (define (next-token) (bf-lexer ip))
  next-token)

(provide make-tokenizer)