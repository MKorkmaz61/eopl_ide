#lang racket
(require "top.scm")
(require "globalstack.scm")
(run "let p = proc (z) set z = 44
         in let x = 33
         in begin (p x); x end")
(define print-element (lambda (i) (pretty-print i) (display "\n*element*\n")))
(display "\n**split**\n")
(map print-element (get-expstack))
(display "\n**split**\n")
(map print-element (get-envstack))
(display "\n**split**\n")
(map print-element (get-stostack))
