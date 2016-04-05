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

(define (hash10 a b)
    (let ((head (if (= 0 (length a)) 0 (car a)))
    (tail (if (> 2 (length a)) '() (cdr a)))) 
        (if (= 0 (length a)) 0
            (+ (* b head) (hash tail (- b 1)))
        )
    )
)

(define (hash13 a b)
    (let ((head (if (= 0 (length a)) 0 (car a)))
        (tail (if (> 2 (length a)) '() (cdr a)))
        (nextweight (if (= 1 b) 3 1))
    )
    (if (= 0 (length a)) 0
        (+ (* b head) (hash13 tail nextweight)))
    )
)

(define (validisbn10? a)
    (let* ((charlist (string->list a))
        (xval (if (char=? #\X (last charlist)) 10 0))
        (digitlist (digit->number (cleanlist charlist)))
        (dlen (length digitlist))
        (hashval (+ xval (hash10 digitlist 10)))
        (zval (= 0 (modulo hashval 11))) )
        (if (= 10 dlen) zval
            (and (= 9 dlen) (= 10 xval) zval)
        )
    )
)

(define (validisbn13? a)
    (let* (
        (charlist (string->list a))
        (ldigit (last charlist))
        (lval (char->digit ldigit))
        (sstring (substring a 0 (- (string-length a) 1)))
        (cval (modulo (checkdigit13 sstring) 10))
        )
        (= lval cval)
    )
)

(define random
  (let ((a 69069) (c 1) (m (expt 2 32)) (seed 19380110))
    (lambda new-seed
      (if (pair? new-seed)
          (set! seed (car new-seed))
          (set! seed (modulo (+ (* seed a) c) m)))
      (/ seed m))))
      
(define (randint . args)
  (cond ((= (length args) 1)
          (floor (* (random) (car args))))
        ((= (length args) 2)
          (+ (car args) (floor (* (random) (- (cadr args) (car args))))))
        (else (error 'randint "usage: (randint [lo] hi)"))))
        
        
(define (checkdigit a)
    (let (
        (modval (modulo (hash10 (digit->number (string->list a)) 10) 11))
    )
        (if (= 10 modval)
            #\X
            (integer->char (+ 48 (- 11 modval)))
        )
    )
)

(define (append-checkdigit a)
    (string-append a (string (checkdigit a)))
)

(define (genisbn10)
    (append-checkdigit
        (number->string (randint 1000000000))
    )
)

(define (genisbn13)
    (let* ((str13 (string-append "978" (genisbn10)))
        (str12 (substring str13 0 (- (string-length str13) 1)))
        (cval (number->string (checkdigit13 str12))) )
        (string-append str12 cval)
    )
)







