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
;; Sum of squares (x^2 + y^2)
(define (sum-of-squares x y)
  (+ (square x)
     (square y)))

(sum-of-squares 3 4)

;; Using sum-of-squares to construct further procedures
(define (f a)
  (sum-of-squares (+ a 1)
                   (* a 2)))
(f 5)

;; Section 1.1.6

;; Conditional expressions
;; Get the absolute value of x
(define (abs x)
  (cond ((> x 0) x) ;; If x is greater than 0, return x
        ((= x 0) 0) ;; If x is 0, return 0
        ((< x 0) (- x)))) ;; If x is less than zero (negative number), return -x
(abs -10)

;; Alternate absolute-value procedure (with else)
(define (absAltElse x)
  (cond ((< x 0) (- x))
        (else x)))
(absAltElse -5)

;; Another absolute-value procedure (with special form of if)
(define (absAltIf x)
  (if (< x 0) ;; if x is less than 0, return 0; otherwise return x
      (- x)
      x))
(absAltIf -3)

;; If one number is greater than or equal to another
(define (>= x y)
  (or (> x y)
      (= x y)))
(>= 4 2) ; true
(>= 2 2) ; true
(>= 1 2) ; false

;; Alternative to test if one number is greater than or equal to another
(define (>=Alt x y)
  (not (< x y))) ;; if x is less than y, expression will be true an `not` will return false.
(>=Alt 4 2) ; true
(>=Alt 2 2) ; true
(>=Alt 1 2) ; false

;; Section 1.1.7

#|
Define a function that takes in a guess and the number that should be squared.
  
  - If the difference between guess^2 and x is < 0.0.1, then return the guess.

  - Otherwise, run `improve`, which will average the guess with the quotient
    - Then run the next iteration of the square-root procedure against this outcome and re-test using `good-enough?`
|#
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; Using a default guess of 1
(define (sqrt x)
  (sqrt-iter 1.0 x))

; -----

(sqrt 9) ; Output: 3.00009155413138
(sqrt (+ 100 37)) ; Output: 11.704699917758145
(sqrt (+ (sqrt 2) (sqrt 3))) ; Output: 1.7739279023207892
(square (sqrt 100)) ; Output: 100.00000000279795

