#lang racket

(provide (all-defined-out))

;; distancia: Natural Natural Natural Natural -> Numero
;; calcula a distancia euclidiana entre dois pontos
(define (distancia x1 y1 x2 y2)
  (sqrt (+ (sqr (- x2 x1)) (sqr (- y2 y1)))))