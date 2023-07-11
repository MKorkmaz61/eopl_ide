#lang racket
(require "top.scm")
(require "globalstack.scm")
(run "let x=3 in
 let p = proc(a) -(a,5)
  in (p x) 
")
(define print-element (lambda (i) (pretty-print i) (display "\n*element*\n")))
(display "\n**split**\n")
(map print-element (get-expstack))
(display "\n**split**\n")
(map print-element (get-envstack))
(display "\n**split**\n")
(map print-element (get-stostack))
