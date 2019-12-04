# bf-racket
An assembly bf simulator in racket

## Install

Install it by typing at the bf directory `raco pkg install`. This will generate a bf lib.

## Test

Run one of `reader_rkt_tests` files by typing `racket file_name.rkt`.

## Create a new input from a bf code
Pass the bf code as an input to the `tests/gen_assembly_code.cpp`. This will return an code compatible with this bf-racket program. Then you will need only add `#lang bf` at the beggining to make the racket recognize this program.

## Remove

Type `raco pkg remove bf`.
