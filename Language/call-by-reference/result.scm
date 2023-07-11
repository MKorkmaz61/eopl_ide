#lang racket
(require "top.scm")
(require "globalstack.scm")
(run "let p = proc (x) set x = 4
      in let a = 3
         in begin (p a); a end
")
(define print-element (lambda (i) (pretty-print i) (display "\n*element*\n")))
(display "\n**split**\n")
(map print-element (get-expstack))
(display "\n**split**\n")
(map print-element (get-envstack))
(display "\n**split**\n")
(map print-element (get-stostack))
