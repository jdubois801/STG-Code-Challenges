(define (bubble-sort x gt?)
  (letrec
    ((fix (lambda (f i)
       (if (equal? i (f i))
           i
           (fix f (f i)))))
 
     (sort-step (lambda (l)
        (if (or (null? l) (null? (cdr l)))
            l
            (if (gt? (car l) (cadr l))
                (cons (cadr l) (sort-step (cons (car l) (cddr l))))
                (cons (car  l) (sort-step (cdr l))))))))
 
  (fix sort-step x)))
  
  
(define (string-tail a b)
    (if (> b (string-length a)) "" (substring a b (string-length a))))

(define (string-min-cust a b)
    (if (char=? (string-ref a 0) (string-ref b 0))
        (>
        	(string->number
				(string-tail a 1))
			(string->number
				(string-tail b 1)))
		(char>? (string-ref a 0) (string-ref b 0)) ))

    
(define (code-challenge-one a)
    (bubble-sort a string-min-cust))
    
