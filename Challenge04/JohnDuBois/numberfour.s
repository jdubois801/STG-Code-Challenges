
(define (char->digit a)
    (let ((val (char->integer a)))
        (if (< val 48) #f
        (if (> val 57) #f (- val 48)))))
        
(define (isdigit a)
    (not (boolean? (char->digit a))))
    
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

;(arf (list #\2 #\3 #\a))
;(arf (string->list "(10002-1001)(1006/201)"))
; "(12-11)(16/21)"


    
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


(parse-int-consts (parse-numbers (string->list "+(102a")))

    