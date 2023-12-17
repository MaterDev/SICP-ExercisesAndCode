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

