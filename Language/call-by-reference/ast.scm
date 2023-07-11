#lang racket
(require "top.scm")
(require "lang.scm")
(scan&parse "let x = -(4,1) in -(x,1)")