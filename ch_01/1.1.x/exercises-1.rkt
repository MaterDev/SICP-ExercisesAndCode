#lang sicp

;;; Exercises

;;; 1.1

10 ; 10
(+ 5 3 4) ; 12
(- 9 1) ; 8
(/ 6 2) ; 3
(+ (* 2 4) (- 4 6)) ; 6

(define a 3)
(define b (+ a 1))
(+ a b (* a b)) ; 19
(= a b) ; false

(if (and (> b a) (< b (* a b)))
    b
    a) ; 4

(cond 
    ((= a 4) 6) 
    ((= b 4) (+ 6 7 a)) ; 16
    (else 25))

(+ 2 (if (> b a) b a)) ; 6

(* (cond
        ((> a b) a)
        ((< a b) b) ; 4 * 4 = 16
        (else -1))
    (+ a 1))

;;; 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7))) ; ✅

;;; 1.3
 
(define (square x) (* x x))
; check square
(square 2)

(define (sum x y) (+ x y))
; check sum
(sum 2 4)

#|
Combinations ab, ac, bc

- Check ab against ac
  - if ab < ac
    - check ac against bc
      - if ac < bc
        ... use bc
      - if ac > bc
        ... use ac
  - if ab > ac
    - check ab against bc
      - if ab > bc
        ... use ab
      - if bc > ab
        ... use bc
|#

(define (myFun a b c)
  (cond
    ((and (< (+ a c) (+ b c)) (> (+ b c) (+ a b))) (+ b c)) ; Handles for if b, c is largest combo
    ((and (> (+ a c) (+ b c)) (> (+ a c) (+ a b)) (+ a c))) ; handles if a, c is the largest
    ((+ a b))
    ))

; Check every pair
(myFun 5 4 3) ; should be a, b (9)
(myFun 4 5 3) ; should be a, b (9)

(myFun 5 3 6) ; should be a, c (11)
(myFun 6 3 5) ; should be a, c (11)

(myFun 3 7 5) ; should be b, c (12)
(myFun 3 5 7) ; should be b, c (12)

(define (myFinalFun a b c)
  (cond
    ((and
      (< (+ a c) (+ b c))
      (> (+ b c) (+ a b)))
     (sum (square b) (square c))) ; Handles for if b, c is largest combo
    ((and
      (> (+ a c) (+ b c))
      (> (+ a c) (+ a b)))
     (sum (square a) (square c))) ; handles if a, c is the largest
    (
     (sum (square a) (square b))) ; fall-through for a, b
    ))

(myFinalFun 5 4 3) ; a, b = 41 ✅
(myFinalFun 4 5 3) ; a, b = 41 ✅

(myFinalFun 5 3 6) ; a, c = 61 ✅
(myFinalFun 6 3 5) ; a, c = 61 ✅

(myFinalFun 3 7 5) ; b, c = 74 ✅
(myFinalFun 3 5 7) ; b, c = 74 ✅

;;; 1.4

#|
Defines a function, which takes in two arguments
If b > 0, then a + b
If b < 0, then a - b

Because of the if logic, b will always be treated as a positive number.
|#
(define (a-plus-abs-b a b) ((if (> b 0) + -) a b))

(a-plus-abs-b 5 10) ; 15
(a-plus-abs-b 5 -10) ; -15 (because `a - -b` is `a + b`)
(a-plus-abs-b 5 0) ; 5
(a-plus-abs-b -5 10) ; 5
(a-plus-abs-b 0 10) ; 10

;;; 1.5

(define (p) (p)) ;; p will return itself?

(define (test x y)
  (if (= x 0) 0 y))

;;; (test 0 3) ; is 0
;;; (test 1 3) ; is 3
;;; (test 0 (p))
;;; (p)

#|
Applicative: If applicative then the interpreter will run an endless loop if x is 0, because it will continuously try to evaluate p.✅
    (Won't finish or show a result)  ✅
    (p) is an infinite loop ✅

Normal-Order: will always evaluate to 0, because test will evaluate the x = 0 and return 0
    Only evaluates operands when they are "needed", (p) is never needed
|#

;;; 1.6

;; A function that that takes in some condition to test, and the results to produce for the true/false results.
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5) ; output: 5
(new-if (= 1 1) 0 5) ; output: 0

;; Write square-root program with new-if instead of build-in if

(define (sqrt-iter2 guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough?2 guess x)
  (< (abs (- (square guess) x)) 0.001))

; Using a default guess of 1
(define (sqrt2 x)
  (sqrt-iter2 1.0 x))

; ---------

;(sqrt 9) ; Output: 3.00009155413138

;; This will break and the app will run out of memory. * new-if does not use normal order evaluation, it uses applicative order evaluation

#|
The act of re-defining a special form using generic arguments effectively "De-Special Forms" it. **It then becomes subject to applicative-order evaluation**, such that any expressions within the consequent or alternate portions are evaluated regardless of the predicate.
|#

;;; 1.7

#|
Explain these statements, with examples showing how the test fails for small and large numbers.

An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess.

Design a square-root procedure that uses this kind of end test. Does this work beer for small and large numbers?
|#

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; Using a default guess of 1
(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 99999999999999999999999999999999999999999999999999) ; Output: 3.00009155413138