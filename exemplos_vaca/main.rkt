#lang racket

(require 2htdp/universe)

(require "constantes.rkt")
(require "jogo.rkt")


;; Jogo -> Jogo
;; inicie o mundo com (main JOGO-INICIO)
;; 
(define (main v)
  (big-bang v               ; Jogo   (estado inicial do mundo)
            (on-tick   atualiza-jogo)     ; Jogo -> Jogo    
                                   ;(retorna um novo estado do mundo dado o atual a cada tick do clock)
            (to-draw   desenha-jogo)   ; Jogo -> Image   
                                          ;(retorna uma imagem que representa o estado atual do mundo)
            (on-key    trata-tecla-jogo)))    ; Jogo KeyEvent -> Jogo
                                    ;(retorna um novo estado do mundo dado o estado atual e uma interação com o teclado)
