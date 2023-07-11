#lang racket
(require "top.scm")
(require "lang.scm")
(scan&parse "letrec f(x) = -(x,1) in (f 33)")