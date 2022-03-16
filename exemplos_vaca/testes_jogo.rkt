#lang racket

(require rackunit)
(require "constantes.rkt")
(require "jogo.rkt")
(require "personagem.rkt")

;; Testes trata-tecla
(check-equal? (trata-tecla-vaca (make-personagem MEIO-X Y-PADRAO-VACA 3 5   30 40) " ")
              (make-personagem MEIO-X Y-PADRAO-VACA -3 -5   30 40))
(check-equal? (trata-tecla-vaca (make-personagem MEIO-X Y-PADRAO-VACA 3 5   30 40) "a")
              (make-personagem MEIO-X Y-PADRAO-VACA 3 5   30 40))




;; Testes atualiza-jogo
; CASO NORMAL
(check-equal? (atualiza-jogo JOGO-INICIO) JOGO-INICIO-PROX)
                          
; CASO COLISAO
(check-equal? (atualiza-jogo JOGO-COLIDINDO1)
              (make-jogo
               (make-personagem (- MEIO-X 15 25) Y-PADRAO-VACA 3 0  30 40)
               (make-personagem X-PADRAO-CC MEIO-Y 0 10   50 60)                  
                1 #true)
              )


; Testes desenha-jogo
;(check-equal? (desenha-jogo JOGO-INICIO)
;              (place-image IMG-CC X-CC LIMITE-CIMA
;

;(check-equal? (desenha-jogo JOGO-GAME-OVER)
;              (place-image (text "GAME OVER" 50 "red") MEIO-X MEIO-Y CENARIO))