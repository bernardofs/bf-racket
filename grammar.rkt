#lang brag

bf-program : ((/NEWLINE)* (bf-op | bf-loop)?)*
bf-op      : bf-fwd | bf-rwd | bf-inc | bf-dec | "write" | "read"
bf-fwd     : "fwd" number?
bf-rwd     : "rwd" number?
bf-inc     : "inc" number?
bf-dec     : "dec" number?
number     : NUMBER
bf-loop    : "begin" (bf-op | bf-loop)* "end"