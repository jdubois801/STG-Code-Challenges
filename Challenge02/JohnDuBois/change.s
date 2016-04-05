(define (quotient a b)
    (floor (/ a b)))
    
(define (remainder a b)
    (- a (* b (quotient a b))))

(define (test-change a b c)
    (let ((r (remainder (car a) b))(q (quotient (car a) b)))
        (append
            (append (list r) (cdr a))
            (list (string-append (number->string q) " " c)))))
        
(define (make-change a)
    (test-change
        (test-change
            (test-change
                (test-change
                    (test-change
                        (test-change
                            (test-change
                               (test-change
                                    (test-change 
                                        (test-change (list a) 
                                        100 "100 dollar bills") 
                                    50 "50 dollar bills")
                                20 "20 dollar bills")
                            10 "10 dollar bills")
                        5 "5 dollar bills")
                    1 "1 dollar bills")
                0.25 "quarters")
            0.10 "dimes")
        0.05 "nickels")
    0.01 "pennies")
)