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
(check-equal? (atualiza-jogo JOGO-INICIO-ANTIGO)  JOGO-INICIO-PROX)
(check-equal? (atualiza-jogo
               (make-jogo VACA-INICIO (list CC-INICIO CC-INO) 0 #false))

              (make-jogo VACA-INICIO-PROX
                         (list CC-INICIO-PROX
                               CC-INO-PROX)
                         0 #false)
              )
                          
; CASO COLISAO

(define JOGO-COLIDINDO1-POS-GAME-OVER (make-jogo
                                       (make-personagem (- MEIO-X 15 25) Y-PADRAO-VACA 3 0  30 40)
                                       (list (make-personagem X-PADRAO-CC MEIO-Y 0 10   50 60) )                 
                                       1 #true)
  )


(check-equal? (atualiza-jogo JOGO-COLIDINDO1)
              JOGO-COLIDINDO1-POS-GAME-OVER              
              )

; CASO JÁ EM GAME-OVER

(check-equal? (atualiza-jogo JOGO-COLIDINDO1-POS-GAME-OVER)
              JOGO-COLIDINDO1-POS-GAME-OVER)
                             

; Testes desenha-jogo
;(check-equal? (desenha-jogo JOGO-INICIO-ANTIGO) 
;              (place-image IMG-CC X-CC LIMITE-CIMA
;

;(check-equal? (desenha-jogo JOGO-GAME-OVER)
;              (place-image (text "GAME OVER" 50 "red") MEIO-X MEIO-Y CENARIO))



;; Testes trata-tecla-jogo
(check-equal? (trata-tecla-jogo
               (make-jogo VACA-INO (list CC-INICIO CC-LIMITE-BAIXO) #false 0)
               TC-VIRA
               )
              (make-jogo VACA-VORTANO (list CC-INICIO CC-LIMITE-BAIXO) #false 0)
              )

(define JOGO-COLIDINDO1-POS-GAME-OVER-REINICIO (make-jogo
                                       (jogo-vaca JOGO-INICIO)
                                       (jogo-lcc JOGO-INICIO)
                                       1
                                       #false)
  )
  

(check-equal? (trata-tecla-jogo JOGO-COLIDINDO1-POS-GAME-OVER TC-REINICIO)
              JOGO-COLIDINDO1-POS-GAME-OVER-REINICIO)


;; Testes trata-mouse-jogo
(check-equal? (trata-mouse-jogo JOGO-INICIO (/ LARGURA-CENARIO 4) (/ ALTURA-CENARIO 4) "move")
                (make-jogo (make-personagem (/ LARGURA-CENARIO 4) (/ ALTURA-CENARIO 4) 0 0 LARGURA-VACA ALTURA-VACA)
                           (list CC-INICIO
                              (make-personagem X-PADRAO-CC LIMITE-CIMA 10 10   150 120) ) 0 #false)
                )
              