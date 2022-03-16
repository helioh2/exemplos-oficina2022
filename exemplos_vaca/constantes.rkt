#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(provide (all-defined-out))


;; Meu programa mundo  (torne isto mais específico)

;; =================
;; Constantes:

(define ALTURA-CENARIO 600)
(define LARGURA-CENARIO 800)
(define CENARIO (empty-scene LARGURA-CENARIO ALTURA-CENARIO))

(define MEIO-X (/ LARGURA-CENARIO 2))
(define MEIO-Y (/ ALTURA-CENARIO 2))

(define IMG-VACA (bitmap "vaca.png"))
(define IMG-CC (scale 0.5 (bitmap "chupacabra.jpg")))

(define LARGURA-VACA (image-width IMG-VACA))
(define ALTURA-VACA (image-height IMG-VACA))
(define LARGURA-CC (image-width IMG-CC))
(define ALTURA-CC (image-height IMG-CC))

(define METADE-L-VACA (/ LARGURA-VACA 2))
(define METADE-L-CC (/ ALTURA-VACA 2))

(define LIMITE-ESQUERDO (+ 0 (/ (image-width IMG-VACA) 2)))
(define LIMITE-DIREITO (- LARGURA-CENARIO (/ (image-width IMG-VACA) 2)))
(define LIMITE-CIMA (+ 0 (/ (image-height IMG-CC) 2)))
(define LIMITE-BAIXO (- ALTURA-CENARIO (/ (image-height IMG-CC) 2)))

(define Y-PADRAO-VACA (/ ALTURA-CENARIO 2))
(define X-PADRAO-CC (/ LARGURA-CENARIO 2))

(define DX-PADRAO-VACA 3)
(define DY-PADRAO-VACA 0)
(define DX-PADRAO-CC 0)
(define DY-PADRAO-CC 20)

(define TC-VIRA " ")
