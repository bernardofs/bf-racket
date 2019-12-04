#lang brag

bf-program : bf-body
@bf-body   : ((/NEWLINE)* (bf-op | bf-loop)?)*
bf-loop    : "begin" bf-body "end"
bf-op      : bf-fwd | bf-rwd | bf-inc | bf-dec | bf-write | bf-read

bf-fwd     : /"fwd" number?
bf-rwd     : /"rwd" number?
bf-inc     : /"inc" number?
bf-dec     : /"dec" number?
bf-write   : /"write"
bf-read    : /"read"

number     : NUMBER
