
; here be dragons
; what have I done

(defun separate-on-comma (line)
    (loop
        with fields = () 
        with field = (make-array 0 :element-type 'character :adjustable t :fill-pointer 0)
        for x across line
        when (char= x #\,)        
        do (push (copy-seq field) fields)
        and do (setf (fill-pointer field) 0)
        else
        do (vector-push-extend x field)
        finally 
            (push field fields)
            (return fields)
    )
)

(defvar ch)
(defun dir-x (str)
    (setq ch (char str 0))
    (cond 
        ((eql ch #\R) 1)
        ((eql ch #\L) -1)
        (t 0)
    )
)
(defun dir-y (str)
    (setq ch (char str 0))
    (cond 
        ((eql ch #\U) 1)
        ((eql ch #\D) -1)
        (t 0)
    )
)

(defun dist (x y)
    (+ (abs x) (abs y))
)

(defvar c1)
(defvar c2)
(setq c1 (reverse (separate-on-comma (read-line))))
(setq c2 (reverse (separate-on-comma (read-line))))
; (write c1)
; (terpri)
; (write c2)
(terpri)


(defvar x)
(defvar y)
(defvar x_)
(defvar y_)
(defvar n)
; creating myset as an empty list
(defparameter *c1set* ())
(defvar mindist)
(loop
    with x = 0 
    with y = 0 
    for i in c1
    do 
        (setq x_ (dir-x i))
        (setq y_ (dir-y i))
        (setq n (parse-integer (subseq i 1)))
        (loop for j from 1 to n
            do
                (setq x (+ x x_))
                (setq y (+ y y_))
                (pushnew (cons x y) *c1set* :test 'equal)
        )
        (write (cons x y))
        (terpri)
)
(setq mindist 99999)

(loop
    with x = 0 
    with y = 0 
    for i in c2
    do 
        (setq x_ (dir-x i))
        (setq y_ (dir-y i))
        (setq n (parse-integer (subseq i 1)))
        (loop for j from 1 to n
            do
                (setq x (+ x x_))
                (setq y (+ y y_))
                (unless 
                    (null (member (cons x y) *c1set* :test 'equal))
                    (setq mindist (min mindist (dist x y)))
                    (write (cons x y))
                    (write (dist x y))
                    (terpri)
                    (write mindist)
                    (terpri)
                )
        )
    finally
        (write mindist)
)
(terpri)


;adding an existing value
;(pushnew (cons 2 2) *myset* :test 'equal)


