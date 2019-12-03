#lang br
(require "grammar.rkt" "reader.rkt")
(require brag/support)
(parse-to-datum (apply-tokenizer make-tokenizer
"
inc 4
dec 1
inc 3
dec 1
inc 2
dec 1
inc 2
begin
fwd 1
inc 4
dec
inc 3
dec
inc 2
dec 1
inc 2
rwd 1
dec 1
end
fwd 1
write
"))