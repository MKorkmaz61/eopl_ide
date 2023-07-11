(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the PROC language, using the procedural
  ;; representation of procedures.

  ;; The \commentboxes are the latex code for inserting the rules into
  ;; the code in the book. These are too complicated to put here, see
  ;; the text, sorry. 

  (require "drscheme-init.scm")
  (require "globalstack.scm")
  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of)

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  (define value-of-program 
    (lambda (pgm)
      (initialize-allstacks!)
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-env))))))

   (define value-of
    (lambda (exp env)
      (display "exp\n")
      (pretty-print exp)
      (display "\nenv\n")
      (pretty-print env)
      (display "\n\n")
      (display (unparse exp))
      (display "\n")
      (add-to-expstack exp)
      (add-to-envstack env)
      (value-of-old exp env)))
  
  ;; value-of : Exp * Env -> ExpVal
  (define value-of-old
    (lambda (exp env)
      (cases expression exp

        ;\commentbox{ (value-of (const-exp \n{}) \r) = \n{}}
        (const-exp (num) (num-val num))

        ;\commentbox{ (value-of (var-exp \x{}) \r) = (apply-env \r \x{})}
        (var-exp (var) (apply-env env var))

        ;\commentbox{\diffspec}
        (diff-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
                (- num1 num2)))))

        ;\commentbox{\zerotestspec}
        (zero?-exp (exp1)
          (let ((val1 (value-of exp1 env)))
            (let ((num1 (expval->num val1)))
              (if (zero? num1)
                (bool-val #t)
                (bool-val #f)))))
              
        ;\commentbox{\ma{\theifspec}}
        (if-exp (exp1 exp2 exp3)
          (let ((val1 (value-of exp1 env)))
            (if (expval->bool val1)
              (value-of exp2 env)
              (value-of exp3 env))))

        ;\commentbox{\ma{\theletspecsplit}}
        (let-exp (var exp1 body)       
          (let ((val1 (value-of exp1 env)))
            (value-of body
              (extend-env var val1 env))))
        
        (proc-exp (var body)
          (proc-val (procedure var body env)))

        (call-exp (rator rand)
          (let ((proc (expval->proc (value-of rator env)))
                (arg (value-of rand env)))
            (apply-procedure proc arg)))

        )))


  (define unparse
    (lambda (exp)
      (cases expression exp

        (const-exp (num) (number->string num))

        (var-exp (var) (symbol->string var))

        (diff-exp (exp1 exp2)
                  (let ((val1 (unparse exp1)) (val2 (unparse exp2)))
           (string-append "-" "(" val1 "," val2 ")")))

        (zero?-exp (exp1)
          (let ((val (unparse exp1)))
            (string-append "zero?" "(" val ")")))
              
        (if-exp (exp1 exp2 exp3)
          (let ((val1 (unparse exp1))
                (val2 (unparse exp2))
                (val3 (unparse exp3)))
                (string-append "if " val1 " then " val2 " else " val3)))
                  
        (let-exp (var exp1 body)       
          (let ((val1 (unparse exp1)) (val2 (unparse body)))
            (string-append "let " (symbol->string var) " = " val1 " in " val2)))
        
        (proc-exp (var body)
                  (let ((val (unparse body)))
                  (string-append "proc" " (" (symbol->string var) ") " val)))

        (call-exp (rator rand)
          (let ((proc (unparse rator))
                (arg (unparse rand)))
            (string-append "(" proc " " arg ")")))

        )))


  ;; procedure : Var * Exp * Env -> Proc
  ;; Page: 79
  (define procedure
    (lambda (var body env)
      (lambda (val)
        (value-of body (extend-env var val env)))))
  
  ;; apply-procedure : Proc * ExpVal -> ExpVal
  ;; Page: 79
  (define apply-procedure
    (lambda (proc val)
      (proc val)))

  )
