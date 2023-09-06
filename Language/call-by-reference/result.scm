#lang racket
(require "top.scm")
(require "globalstack.scm")
(run "let swap = proc (x) proc (y)
                      let temp = x
                      in begin 
                          set x = y;
                          set y = temp
                         end
         in let a = 33
         in let b = 44
         in begin
             ((swap a) b);
             -(a,b)
            end")
(define print-element (lambda (i) (pretty-print i) (display "\n*element*\n")))
(display "\n**split**\n")
(map print-element (get-expstack))
(display "\n**split**\n")
(map print-element (get-envstack))
(display "\n**split**\n")
(map print-element (get-stostack))
