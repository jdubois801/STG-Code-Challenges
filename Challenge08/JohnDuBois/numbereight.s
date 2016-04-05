(define (modulo a b)
    (- a (* b (floor (/ a b))))
)

(define (last a)
    (list-ref a (- (length a) 1))
)

(define (char->digit a)
    (let ((val (char->integer a)))
        (if (< val 48) #f
        (if (> val 57) #f (- val 48))))
)
        
(define (isdigit a)
    (not (boolean? (char->digit a)))
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

(define (cleanlist a) 
    (let ((head (if (= 0 (length a)) 0 (car a)))
    (tail (if (> 2 (length a)) '() (cdr a))))
        (if (= 0 (length a)) '()
            (if (isdigit head)
                (append (list head) (cleanlist tail))
                (cleanlist tail)
            )
        )
    )
)

(define (even? a) 
    (= 0 (modulo a 2))
)

(define (double->list a) 
    (let* ((d (* 2 a))
        (c (modulo d 10)))
        (if (> d 9) (append (list (floor (/ d 10))) (list c)) (list c))
    )
)

(define (hashdigits a b) 
    (let ((head (if (= 0 (length a)) 0 (car a)))
        (tail (if (> 2 (length a)) '() (cdr a)))
        (nextb (if (= 0 b) 1 0))
    )
        (if (= 0 (length a)) '()
            (if (= 0 b) (append (list head) (hashdigits tail nextb))
                (append (double->list head) (hashdigits tail nextb))
            )
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

(define (validhash? a)
    (let* ((b (string->list a))
        (e (if (even? (length b)) 1 0))
        (d (digit->number (cleanlist b)))
        (h (hashdigits d e))
        (s (list-sum h))
        )
        (= 0 (modulo s 10))
    )
)

(define (visa? a) 
    (and 
        (or (= 13 (string-length a))
            (= 16 (string-length a)))
        (char=? #\4 (string-ref a 0))
    )
)

(define (mastercard? a) 
    (let ((b (string-ref a 0))
        (c (string-ref a 1)))
        (and 
            (= 16 (string-length a))
            (char=? #\5 b)
            (or 
                (char=? #\1 c)
                (char=? #\2 c)
                (char=? #\3 c)
                (char=? #\4 c)
                (char=? #\5 c)
            )
        )
    )
)

(define (amex? a) 
    (and 
        (= 15 (string-length a))
        (char=? #\3 (string-ref a 0))
        (char=? #\7 (string-ref a 1))
    )
)















