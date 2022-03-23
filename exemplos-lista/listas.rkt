#lang racket

(require rackunit)

(define L1 empty)

(define L2 (cons "ARROZ" empty))   ;(cons Elemento ListaElemento)  ;(cons PRIMEIRO-ELEMENTO RESTO-LISTA)
(define L3 (cons "FEIJAO" (cons "ARROZ" empty)))
(define L3-ALT (cons "FEIJAO" L2))

(define L4 '("ARROZ" "FEIJAO" "MACARRAO"))
(define L5 (list "ARROZ" "FEIJAO" "MACARRAO"))

;(define L-SPRITES '(SPRITE1 SPRITE2 SPRITE3))


#;
(define (fn-para-lps lps)
  (cond [(empty? lps) (...)]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (... (first lps)                 ;String
                   (fn-for-lps (rest lps)))])) ;RECURSÃO EM CAUDA


;; comprar: String -> String
;; Marca um elemento como "comprado"

(define (comprar str)
  (string-append str " (comprado)"))


;; comprar-todos: List<String> -> List<String>
;; Marcar todos os elementos como "(comprado)"

;stub
;(define (comprar-todos lds) lds)

(define (comprar-todos lds)
  (cond [(empty? lds) empty]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (cons (comprar (first lds))               ;String
                   (comprar-todos (rest lds)))])) ;RECURSÃO EM CAUDA

;; Testes
(check-equal? (comprar-todos empty) empty)
(check-equal? (comprar-todos (list "ARROZ")) (list "ARROZ (comprado)"))
(check-equal? (comprar-todos (list "ARROZ" "FEIJAO")) (list "ARROZ (comprado)" "FEIJAO (comprado)"))


;; comprar-todos2: List<String> -> List<String>
;; Marcar todos os elementos como "(comprado)"

(define (comprar-todos2 lds)
  (map comprar lds))


;; somatoria: List<Numero> -> Numero
;; SOma todos os numeros na lista

;stub
;(define (somatoria ldn) 0)

(define (somatoria ldn)
  (cond [(empty? ldn) 0]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (+ (first ldn)                 ;Number
                   (somatoria (rest ldn)))])) ;RECURSÃO EM CAUDA

;; Testes
(check-equal? (somatoria empty) 0)
(check-equal? (somatoria (cons 1 empty)) 1)
(check-equal? (somatoria (cons 2 (cons 1 empty))) 3)


(define (somatoria2 ldn)
  (foldl + 0 ldn))




(define (fat n)
  (cond
    [(or (= n 0) (= n 1)) 1] ;CASO BASE
    [else (* n (fat (- n 1)))]
    ))



