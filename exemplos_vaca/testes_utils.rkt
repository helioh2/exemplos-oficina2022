#lang racket
(require rackunit)

(require "utils.rkt")

; Testes distancia
(check-equal? (distancia 0 0 3 4) 5)
(check-equal? (distancia 2 3 5 3) 3)
(check-equal? (distancia 1 1 4 5) 5)
(check-equal? (distancia 2 3 2 3) 0)
(check-within (distancia 5 7 10 20) (sqrt (+ (sqr (- 10 5)) (sqr (- 20 7)))) 0.01)
;(check-equal? (distancia (- MEIO-X METADE-L-VACA METADE-L-CC) Y-VACA X-CC MEIO-Y)
;              (- MEIO-X (- MEIO-X METADE-L-VACA METADE-L-CC)))

