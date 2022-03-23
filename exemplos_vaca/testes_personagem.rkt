#lang racket

(require rackunit)
(require 2htdp/image)

(require "constantes.rkt")
(require "personagem.rkt")


; CENARIOS DA VACA ANDANDO DE BOA
(check-equal? (move-personagem (make-personagem MEIO-X MEIO-Y 3 4    40 30)) 
              (make-personagem (+ MEIO-X 3) (+ MEIO-Y 4) 3 4    40 30)) 

;; CENARIOS DA VACA BATENDO NA CERCA DA DIREITO
(check-equal? (move-personagem (make-personagem LIMITE-DIREITO MEIO-Y 3 0    40 30))
              (make-personagem LIMITE-DIREITO MEIO-Y -3 0    40 30))
(check-equal? (move-personagem (make-personagem (- LIMITE-DIREITO 1) MEIO-Y 3 0    40 30))
              (make-personagem LIMITE-DIREITO MEIO-Y -3 0    40 30))

;; CENARIOS DA VACA ANDANDO DE BOA PARA TRAS
(check-equal? (move-personagem (make-personagem MEIO-X MEIO-Y -3 0    40 30)) 
              (make-personagem (- MEIO-X 3) MEIO-Y -3 0    40 30))
(check-equal? (move-personagem (make-personagem (+ LIMITE-ESQUERDO 3) MEIO-Y -3 0    40 30)) 
              (make-personagem LIMITE-ESQUERDO MEIO-Y -3 0    40 30))

;; CENARIOS DA VACA BATENDO NA CERCA DA ESQUERDA
(check-equal? (move-personagem (make-personagem LIMITE-ESQUERDO MEIO-Y -3 0  40 30))
              (make-personagem LIMITE-ESQUERDO MEIO-Y 3 0  40 30))
(check-equal? (move-personagem (make-personagem (+ LIMITE-ESQUERDO 1) MEIO-Y -3 0  40 30))
              (make-personagem LIMITE-ESQUERDO MEIO-Y 3 0  40 30))


; CENARIOS DA VACA ANDANDO DE BOA PARA BAIXO
(check-equal? (move-personagem (make-personagem MEIO-X LIMITE-CIMA 0 3  40 30))  ; CHAMADA
              (make-personagem MEIO-X (+ LIMITE-CIMA 3) 0 3  40 30))   ; RESULTADO ESPERADO

; CENARIOS DA VACA ANDANDO DE BOA PARA CIMA
(check-equal? (move-personagem (make-personagem MEIO-X LIMITE-BAIXO 0 -3  40 30))  ; CHAMADA
              (make-personagem MEIO-X (- LIMITE-BAIXO 3) 0 -3  40 30))    ; RESULTADO ESPERADO

;; CENARIOS DA VACA BATENDO NA CERCA DE CIMA
(check-equal? (move-personagem (make-personagem MEIO-X (+ LIMITE-CIMA 1) 0 -3  40 30))
              (make-personagem MEIO-X LIMITE-CIMA 0 3  40 30))

;; CENARIOS DA VACA BATENDO NA CERCA DE BAIXO
(check-equal? (move-personagem (make-personagem MEIO-X (- LIMITE-BAIXO 1) 0 3  40 30))
              (make-personagem MEIO-X LIMITE-BAIXO 0 -3  40 30))



;; Testes do colidindo?
(check-equal? (colidindo? VACA-INICIO CC-INICIO)  #false)

(check-equal? (colidindo?
               (make-personagem (- MEIO-X 15 25) Y-PADRAO-VACA 3 0  30 40)
               (make-personagem X-PADRAO-CC MEIO-Y 0 10   50 60))        
              #true)


;; Testes do colidindo-com-algum?
(check-equal? (colidindo-com-algum? VACA-INICIO (list CC-INICIO CC-INO))
              #false)
(check-equal? (colidindo-com-algum? (make-personagem (- MEIO-X 15 25) Y-PADRAO-VACA 3 0  30 40)
                                    (list (make-personagem X-PADRAO-CC MEIO-Y 0 10   50 60)
                                          CC-INICIO ))                                      
              #true)

(check-equal? (colidindo-com-algum? (make-personagem (- MEIO-X 15 25) Y-PADRAO-VACA 3 0  30 40)
                                    (list CC-INICIO
                                          (make-personagem X-PADRAO-CC MEIO-Y 0 10   50 60)
                                          ))
              
              #true)
(check-equal? (colidindo-com-algum? VACA-INICIO empty) #false)


;; Testes do move-personagens
(check-equal? (move-personagens (list CC-INICIO CC-INO))
              (list CC-INICIO-PROX CC-INO-PROX))
(check-equal? (move-personagens (list CC-INO CC-INICIO))
              (list CC-INO-PROX CC-INICIO-PROX))
(check-equal? (move-personagens empty) empty)

                                    