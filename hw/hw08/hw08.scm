(define (square n) (* n n))

(define (pow base exp) 
  (cond 
    ((= base 1) 1)
    ((not (= exp 0)) (* base (pow base (- exp 1))))
    (else 1)       
)
)
(define (repeatedly-cube n x)
  (if (zero? n)
      x
      (let ((y (repeatedly-cube (- n 1) x)))
        (* y y y))))

(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cdr(cdr s))))


