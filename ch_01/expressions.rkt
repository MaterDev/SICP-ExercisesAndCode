#lang sicp

;;; Section 1.1
;;; A base 10 number as an expression
33
;;; Primative procedures
;;; Each is an expression composed of a delimited list of expressions called a combination
(+ 33 33)
(- 33 33)
(* 33 33)
(/ 33 33)
(+ 3.3 3.3)

;;; Arbitrary number of arguments
(+ 8 6 7 5 3 0 9)

;;; Nested combinations
(+ (* 3 3) (- 33 3))

;; More appropriate way to indent
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))

;; Naming
(define size 2)
size
(* 5 size)