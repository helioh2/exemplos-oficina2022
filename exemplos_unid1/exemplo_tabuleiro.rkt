;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exemplo_tabuleiro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; (square <lado> <modo> <cor>)
;; (beside <img1> <img2> <img3> ...)
;; (above <img1> <img2> <img3> ...)

(define (quadrado-xadrez tam cor)
  (square (/ tam 8) "solid" cor))


(define (quatro-imagens img)
  (above (beside img img)
         (beside img img)))

(define (padrao-xadrez tam cor1 cor2)
  (above (beside (quadrado-xadrez tam cor1) (quadrado-xadrez tam cor2))
         (beside (quadrado-xadrez tam cor2) (quadrado-xadrez tam cor1))))

(define (quadrante tam cor1 cor2)
  (quatro-imagens (padrao-xadrez tam cor1 cor2)))

;(define (metade-tabuleiro tam cor1 cor2)
;  (beside (quadrante tam cor1 cor2) (quadrante tam cor1 cor2)))

;(define (tabuleiro tam cor1 cor2)
;  (above (metade-tabuleiro tam cor1 cor2) (metade-tabuleiro tam cor1 cor2))
;  )

(define (tabuleiro tam cor1 cor2)
  (quatro-imagens (quadrante tam cor1 cor2))
  )


(tabuleiro 600 "blue" "yellow")
