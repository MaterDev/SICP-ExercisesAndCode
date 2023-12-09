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

;; Section 1.1.2

;; Naming
(define size 2)
size
(* 5 size)

(define pi 3.14159)
(define radius 10)
(* pi (* radius radius))
(define circumfrence (* 2 pi radius))
circumfrence

;; Section 1.1.3

;; Evaluating Combinations
(* (+ 2 (* 4 6 ))
   (+ 3 5 7)) ;; This requires that evaluation rules be applied to four different combinations

;; Section 1.1.4

;; Compound Procedures
(define (square x) (* x x))
(square 3)
(square (+ 2 2))
(square (square 3)) ;; equivalent to (3*3) * (3*3)

;; Using procedures to define other procedures
;; Sum of squares (x^2 + y^2
(define (sum-of-squares x y)
  (+ (square x)
     (square y)))

(sum-of-squares 3 4)

;; Using sum-of-squares to construct further procedures
(define (f a)
  (sum-of-squares (+ a 1)
                   (* a 2)))
(f 5)