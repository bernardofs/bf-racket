#lang br

(require brag/support)

(define-lex-abbrev number (:seq (:+ (char-set "0123456789"))))
(define-lex-abbrev op (:or "fwd" "rwd" "inc" "dec" "read"
                           "write" "begin" "end"))

(define bf-lexer
  (lexer-srcloc
   ["\n" (token 'NEWLINE lexeme)]
   [op (token lexeme lexeme)]
   [whitespace (token lexeme #:skip? #t)]
   [number (token 'NUMBER (string->number lexeme))]))

(provide bf-lexer)