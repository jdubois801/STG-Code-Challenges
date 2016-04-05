(define (next-pow a)
    (+ 1 (floor (/ (log a) (log 10))))
)

(define (next-factor a)
    (floor (exp (* (next-pow a) (log 10))))
)

(define (char->digit a)
    (let ((val (char->integer a)))
        (if (< val 48) #f 
            (if (> val 57) #f (- val 48)))))
            
(define (isdigit a)
    (not (boolean? (char->digit a))))
    
(define (isletter a)
    (let ((v (char->integer a)))
        (or
        (and (> v 64) (< v 91))
        (and (> v 96) (< v 123))
        )
    ))
    
(define (clean a)
    (if (= 0 (length a)) '()
        (if (= 1 (length a))
            (if (number? (car a)) a '())
            (append (clean (list (car a))) (clean (cdr a)))
        )
    )
)

(define (list-count-letters a)
    (if (= 0 (length a)) 0
        (if (= 1 (length a))
            (if (isletter (car a)) 1 0)
            (+ (list-count-letters (list (car a))) (list-count-letters (cdr a)))
        )
    )
)

(define (list-sum a)
    (if (= 0 (length a)) 0
        (if (= 1 (length a))
            (car a)
            (+ (car a) (list-sum (cdr a)))            
        )
    )
)

(define (digit->number a) 
    (let ((head (if (= 0 (length a)) 0 (car a)))
    (tail (if (> 2 (length a)) '() (cdr a)))) 
        (if (= 0 (length a)) '()
            (if (isdigit head) (append (list (char->digit head)) (digit->number tail))
                (append (list head) (digit->number tail))
            )
        )
    )
)

(define (combine-digits a) 
    (let ((head (if (= 0 (length a)) 0 (car a)))
    (tail (if (> 2 (length a)) '() (cdr a)))) 
        (if (> 2 (length a)) a
            (if (number? head)
                (if (number? (car tail))
                    (combine-digits (append (list (+ (* 10 head) (car tail))) (cdr tail)))
                    (append (list head) (combine-digits tail))
                )
                (append (list head) (combine-digits tail))
            )
        )
    )
)

(define (parse-numbers a)
    (combine-digits (digit->number a))
)

(define (parse-int-consts a) 
    (let ((head (if (= 0 (length a)) 0 (car a)))
    (tail (if (> 2 (length a)) '() (cdr a))))     
        (if (> 2 (length a)) a
            (if (number? head) (append (list head) (parse-int-consts tail))
                (if (char=? #\+ head)
                    (if (number? (car tail))
                        (parse-int-consts tail)
                        (append (list head) (parse-int-consts tail))
                    )
                    (if (char=? #\- head)
                        (if (number? (car tail))
                            (append (list (* -1 (car tail))) (parse-int-consts (cdr tail)))
                            (append (list head) (parse-int-consts tail))
                        )
                        (append (list head) (parse-int-consts tail))
                    )
                )
            )
        )
    )
)

(define (challenge-three a)
    (let* ((ll (string->list a))
        (c (clean (parse-int-consts (parse-numbers ll))))
        (l (list-count-letters ll))
        (s (list-sum c)))
        (round (/ s l))
    ))
        




            