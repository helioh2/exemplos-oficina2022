#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require rackunit)

(require "constantes.rkt")
(require "personagem.rkt")

(provide (all-defined-out))

;; =================
;; Definições de dados:

(define-struct jogo (vaca cc mortes game-over?) #:transparent)
;; Jogo é (make-jogo Personagem Chupacabra Natural Boolean)
;; interp. jogo contendo uma vaca e um chupacabra, e uma contagem de mortes, e uma flag
;; que indica se o jogo está em estado de game over ou não

;; Exemplos:
(define JOGO-INICIO (make-jogo VACA-INICIO CC-INICIO 0 #false))
(define JOGO-INICIO-PROX (make-jogo VACA-INICIO-PROX CC-INICIO-PROX 0 #false))
(define JOGO-MEIO (make-jogo VACA-INO CC-VORTANO 0 #false))
(define JOGO-REINICIADO (make-jogo VACA-INICIO CC-INICIO 1 #false))

(define JOGO-INICIO2
    (make-jogo
                        (make-personagem LIMITE-ESQUERDO Y-PADRAO-VACA 3 0  120 90)
                        (make-personagem X-PADRAO-CC LIMITE-CIMA 0 10   150 120)                 
                        0 #false))

(define JOGO-COLIDINDO1 (make-jogo
                        (make-personagem (- MEIO-X 15 25) Y-PADRAO-VACA 3 0  30 40)
                        (make-personagem X-PADRAO-CC MEIO-Y 0 10   50 60)                 
                        0 #false))
(define JOGO-COLIDINDO2 (make-jogo
                        (make-personagem (+ (- MEIO-X 15 25) 3) Y-PADRAO-VACA 3 0    30 40)
                        (make-personagem X-PADRAO-CC MEIO-Y 0 10     50 60)                 
                        0 #false))

(define JOGO-GAME-OVER (make-jogo
                        (make-personagem (- MEIO-X 15 25) Y-PADRAO-VACA 3 0  30 40)
                        (make-personagem X-PADRAO-CC MEIO-Y 0 10   50 60)                  
                        1 #true))

#;
(define (fn-para-jogo j)
  (... (jogo-vaca j)
       (jogo-cc j)
       (jogo-mortes j)
       (jogo-game-over? j))
  )


;; =================
;; Funções:


;; Jogo -> Jogo
;; produz o próximo estado do jogo
;; !!!

;stub
;(define (atualiza-jogo j) j)

(define (atualiza-jogo j)
  (cond
    [(colidindo? (jogo-vaca j) (jogo-cc j))
     (make-jogo
      (jogo-vaca j)
      (jogo-cc j)
      (+ (jogo-mortes j) 1)
      #true)]
    [else
     (make-jogo
      (move-personagem (jogo-vaca j))
      (move-personagem (jogo-cc j))
      (jogo-mortes j)
      (jogo-game-over? j))]
    )
  )
  


;; Personagem KeyEvent ->  Personagem
;; quando teclar ESPAÇO vira a vaca (inverte dx)

(define (trata-tecla-vaca v ke)
  (cond [(key=? ke " ")
         (make-personagem (personagem-x v) (personagem-y v) (- (personagem-dx v)) (- (personagem-dy v)) (personagem-largura v)  (personagem-altura v))]
        [else v])
        )



;; Jogo -> Image
;; desenha o jogo com os seus elementos
;; !!!

;stub
(define (desenha-jogo j)
  (let* ([contagem-mortes (text (string-append "mortes: " (number->string (jogo-mortes j))) 25 "blue")])
    
    (place-image contagem-mortes (- LARGURA-CENARIO 80) 30 
               (if (jogo-game-over? j)
                   (place-image (text "GAME OVER" 50 "red") MEIO-X MEIO-Y CENARIO)
                   (desenha-personagem (jogo-vaca j) IMG-VACA
                                      (desenha-personagem (jogo-cc j) IMG-CC CENARIO)
                                      )              
                 )
               )
    )
  )

;; Jogo KeyEvent -> Jogo
;; quando teclar ...  produz ...  <apagar caso não precise usar>
#;
(define (trata-telca-jogo j ke)
  (cond [(key=? ke " ") (... j)]
        [else
         (... j)]))
;stub
(define (trata-tecla-jogo j ke) j)