;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname vaca) (read-case-sensitive #t) (teachpacks ((lib "testing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "testing.rkt" "teachpack" "htdp")) #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Meu programa mundo  (torne isto mais específico)

;; =================
;; Constantes:

(define ALTURA-CENARIO 600)
(define LARGURA-CENARIO 800)
(define CENARIO (empty-scene LARGURA-CENARIO ALTURA-CENARIO))

(define MEIO (/ LARGURA-CENARIO 2))

(define IMG-VACA (bitmap "vaca.png"))
(define IMG-CC (scale 0.5 (bitmap "chupacabra.jpg")))

(define LIMITE-ESQUERDO (+ 0 (/ (image-width IMG-VACA) 2)))
(define LIMITE-DIREITO (- LARGURA-CENARIO (/ (image-width IMG-VACA) 2)))
(define LIMITE-CIMA (+ 0 (/ (image-height IMG-CC) 2)))
(define LIMITE-BAIXO (- ALTURA-CENARIO (/ (image-height IMG-CC) 2)))


(define Y-VACA (/ ALTURA-CENARIO 2))
(define X-CC (/ LARGURA-CENARIO 2))

(define DX-PADRAO-VACA 3)
(define DY-PADRAO-CC 20)
(define TC-VIRA " ")

;; =================
;; Definições de dados:


(define-struct vaca (x dx))
;; Vaca é (make-vaca Natural Inteiro)
;; interp. posicao da vaca no eixo x e a direção dx, em pixels.
;; se dx>=0, vaca estará apontando para a direita, se dx<0, estará apontando p/ esquerda

;; Exemplos:
(define VACA-INICIO (make-vaca LIMITE-ESQUERDO DX-PADRAO-VACA))
(define VACA-INO (make-vaca MEIO DX-PADRAO-VACA))
(define VACA-LIMITE-DIREITO (make-vaca LIMITE-DIREITO DX-PADRAO-VACA))
(define VACA-VORTANO (make-vaca MEIO (- DX-PADRAO-VACA)))
(define VACA-VORTANO-LIMITE-ESQUERDO (make-vaca LIMITE-ESQUERDO (- DX-PADRAO-VACA)))

;#
(define (fn-para-vaca v)
  (... (vaca-x v)
       (vaca-dx v)))


(define-struct chupacabra (y dy))
;; Chupacabra é (make-chupacabra Natural Inteiro)
;; interp. posicao do chupacabra no eixo y e a direção dy, em pixels.

;; Exemplos:
(define CC-INICIO (make-chupacabra LIMITE-CIMA DY-PADRAO-CC))
(define CC-INO (make-chupacabra MEIO DY-PADRAO-CC))
(define CC-LIMITE-BAIXO (make-chupacabra LIMITE-BAIXO DY-PADRAO-CC))
(define CC-VORTANO (make-chupacabra MEIO (- DY-PADRAO-CC)))
(define CC-VORTANO-LIMITE-CIMA (make-chupacabra LIMITE-CIMA (- DY-PADRAO-CC)))

;#
(define (fn-para-cc cc)
  (... (chupacabra-y cc)
       (chupacabra-dy cc)))


(define-struct jogo (vaca cc mortes game-over?))
;; Jogo é (make-jogo Vaca Chupacabra Natural Boolean)
;; interp. jogo contendo uma vaca e um chupacabra, e uma contagem de mortes, e uma flag
;; que indica se o jogo está em estado de game over ou não

;; Exemplos:
(define JOGO-INICIO (make-jogo VACA-INICIO CC-INICIO 0 #false))
(define JOGO-MEIO (make-jogo VACA-INO CC-VORTANO 0 #false))
(define JOGO-COLIDINDO (make-jogo VACA-INO CC-INO 0 #false))
(define JOGO-GAME-OVER (make-jogo VACA-INO CC-INO 1 #true))
(define JOGO-REINICIADO (make-jogo VACA-INICIO CC-INICIO 1 #false))

;#
(define (fn-para-jogo j)
  (... (jogo-vaca j)
       (jogo-cc j)
       (jogo-mortes j)
       (jogo-game-over? j))
  )

;; =================
;; Funções:

;; --------------------- INICIO FUNCOES DA VACA ------------------

;; Vaca -> Vaca
;; produz o próximo estado da vaca

(define (atualiza-vaca v)
  (cond

    [(> (+ (vaca-x v) (vaca-dx v)) LIMITE-DIREITO)
     (make-vaca LIMITE-DIREITO (- (vaca-dx v)))]

    [(< (+ (vaca-x v) (vaca-dx v)) LIMITE-ESQUERDO)
     (make-vaca LIMITE-ESQUERDO (- (vaca-dx v)))]
    
    [else
     (make-vaca (+ (vaca-x v) (vaca-dx v))  ;novo x
             (vaca-dx v)   ;novo dx
             )
     ]
    )
  )    

;; Testes
; CENARIOS DA VACA ANDANDO DE BOA PARA FRENTE
(check-expect (atualiza-vaca (make-vaca LIMITE-ESQUERDO 3))  ; CHAMADA
              (make-vaca (+ LIMITE-ESQUERDO 3) 3))    ; RESULTADO ESPERADO
(check-expect (atualiza-vaca (make-vaca MEIO 3))  ; CHAMADA
              (make-vaca (+ MEIO 3) 3))  

;; CENARIOS DA VACA BATENDO NA CERCA DA DIREITO
(check-expect (atualiza-vaca (make-vaca LIMITE-DIREITO 3))
              (make-vaca LIMITE-DIREITO -3))
(check-expect (atualiza-vaca (make-vaca (- LIMITE-DIREITO 1) 3))
              (make-vaca LIMITE-DIREITO -3))
(check-expect (atualiza-vaca (make-vaca (- LIMITE-DIREITO 2) 3))
              (make-vaca LIMITE-DIREITO -3))

;; CENARIOS DA VACA ANDANDO DE BOA PARA TRAS
(check-expect (atualiza-vaca (make-vaca MEIO -3)) 
              (make-vaca (- MEIO 3) -3))
(check-expect (atualiza-vaca (make-vaca (+ LIMITE-ESQUERDO 3) -3)) 
              (make-vaca LIMITE-ESQUERDO -3))

;; CENARIOS DA VACA BATENDO NA CERCA DA ESQUERDA
(check-expect (atualiza-vaca (make-vaca LIMITE-ESQUERDO -3))
              (make-vaca LIMITE-ESQUERDO 3))
(check-expect (atualiza-vaca (make-vaca (+ LIMITE-ESQUERDO 1) -3))
              (make-vaca LIMITE-ESQUERDO 3))
(check-expect (atualiza-vaca (make-vaca (+ LIMITE-ESQUERDO 2) -3))
              (make-vaca LIMITE-ESQUERDO 3))   


;; Vaca -> Image
;; desenha a vaca no pasto

(define (desenha-vaca v)
  (cond
    [(< (vaca-dx v) 0)
     (place-image (flip-horizontal IMG-VACA) (vaca-x v) Y-VACA CENARIO)]
    [else
     (place-image IMG-VACA (vaca-x v) Y-VACA CENARIO)]
    )
  )

; Testes
(check-expect (desenha-vaca (make-vaca 0 3))
              (place-image IMG-VACA 0 Y-VACA CENARIO))
  
(check-expect (desenha-vaca (make-vaca MEIO 3))
              (place-image IMG-VACA MEIO Y-VACA CENARIO))
(check-expect (desenha-vaca (make-vaca MEIO -3))
              (place-image (flip-horizontal IMG-VACA) MEIO Y-VACA CENARIO))


;; Vaca KeyEvent -> Vaca
;; quando teclar ESPAÇO vira a vaca (inverte dx)

(define (trata-tecla v ke)
  (cond [(key=? ke " ") (make-vaca (vaca-x v) (- (vaca-dx v)))]
        [else v])
        )


;; Testes
(check-expect (trata-tecla (make-vaca MEIO 3) " ")
              (make-vaca MEIO -3))
(check-expect (trata-tecla (make-vaca MEIO 3) "a")
              (make-vaca MEIO 3))


;; --------------------- INICIO FUNCOES DO CHUPACABRA -----------

;; Chupacabra -> Chupacabra
;; produz o próximo estado do chupacabra
;; !!!

;stub
;(define (atualiza-chupacabra cc) cc)

(define (atualiza-chupacabra cc)
  (cond 
        [(> (chupacabra-y cc) LIMITE-BAIXO)
         (make-chupacabra LIMITE-BAIXO (- (chupacabra-dy cc)))]
        [(< (chupacabra-y cc) LIMITE-CIMA)
         (make-chupacabra LIMITE-CIMA (- (chupacabra-dy cc)))]
        [else
         (make-chupacabra (+ (chupacabra-y cc) (chupacabra-dy cc))
             (chupacabra-dy cc))])
 )


; exemplos / testes
;casos em que ele anda pra baixo sem chegar no limite
(check-expect (atualiza-chupacabra (make-chupacabra LIMITE-CIMA 10))
              (make-chupacabra (+ LIMITE-CIMA 10) 10))
;(check-expect (atualiza-chupacabra CC-INO)
;              (make-chupacabra (+ (/ LIMITE-BAIXO 2) DY-PADRAO-CC)
;                          DY-PADRAO-CC))
; casos em que chega no limite baixo e tem que ccirar
;(check-expect (atualiza-chupacabra CC-ANTES-VIRAR)
;              CC-VIROU)

; caso em que ela anda pra cima sem chegar no limite 
(check-expect (atualiza-chupacabra
               (make-chupacabra (/ LIMITE-BAIXO 2) (- DY-PADRAO-CC)))
              (make-chupacabra (- (/ LIMITE-BAIXO 2) DY-PADRAO-CC)
                                       (- DY-PADRAO-CC)))

; casos em que chega no limite cima e tem que virar
(check-expect (atualiza-chupacabra (make-chupacabra (- LIMITE-CIMA 10) -10))
                            (make-chupacabra LIMITE-CIMA 10))
(check-expect (atualiza-chupacabra (make-chupacabra (- LIMITE-CIMA 20) -50))
                            (make-chupacabra LIMITE-CIMA 50))




;; --------------------- INICIO FUNCOES DO JOGO ------------------

;; Jogo -> Jogo
;; produz o próximo estado do jogo
;; !!!

;stub
;(define (atualiza-jogo j) j)

(define (atualiza-jogo j)
  (make-jogo
   (atualiza-vaca (jogo-vaca j))
   (atualiza-chupacabra (jogo-cc j))
   (jogo-mortes j)
   (jogo-game-over? j))
  )

; Testes
(check-expect (atualiza-jogo JOGO-INICIO)
              (make-jogo
               (make-vaca (+ LIMITE-ESQUERDO DX-PADRAO-VACA) DX-PADRAO-VACA)
               (make-chupacabra (+ LIMITE-CIMA DY-PADRAO-CC) DY-PADRAO-CC)
               0
               #false))
                          
                          


;; Jogo -> Image
;; desenha o jogo com os seus elementos
;; !!!

;stub
(define (desenha-jogo j)
  (place-image IMG-CC X-CC (chupacabra-y (jogo-cc j))
               (desenha-vaca (jogo-vaca j))
  )
  )

; Testes
(check-expect (desenha-jogo JOGO-INICIO)
              (place-image IMG-CC X-CC LIMITE-CIMA
                           (place-image IMG-VACA LIMITE-ESQUERDO Y-VACA CENARIO)))


;; Jogo KeyEvent -> Jogo
;; quando teclar ...  produz ...  <apagar caso não precise usar>
#;
(define (trata-telca-jogo j ke)
  (cond [(key=? ke " ") (... j)]
        [else
         (... j)]))
;stub
(define (trata-tecla-jogo j ke) j)


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
