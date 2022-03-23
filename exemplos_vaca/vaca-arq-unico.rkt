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

(define MEIO-X (/ LARGURA-CENARIO 2))
(define MEIO-Y (/ ALTURA-CENARIO 2))

(define IMG-VACA (bitmap "vaca.png"))
(define IMG-CC (scale 0.5 (bitmap "chupacabra.jpg")))

(define METADE-L-VACA (/ (image-width IMG-VACA) 2))
(define METADE-L-CC (/ (image-width IMG-CC) 2))

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
(check-expect (atualiza-vaca (make-vaca MEIO-X 3))  ; CHAMADA
              (make-vaca (+ MEIO-X 3) 3))  

;; CENARIOS DA VACA BATENDO NA CERCA DA DIREITO
(check-expect (atualiza-vaca (make-vaca LIMITE-DIREITO 3))
              (make-vaca LIMITE-DIREITO -3))
(check-expect (atualiza-vaca (make-vaca (- LIMITE-DIREITO 1) 3))
              (make-vaca LIMITE-DIREITO -3))
(check-expect (atualiza-vaca (make-vaca (- LIMITE-DIREITO 2) 3))
              (make-vaca LIMITE-DIREITO -3))

;; CENARIOS DA VACA ANDANDO DE BOA PARA TRAS
(check-expect (atualiza-vaca (make-vaca MEIO-X -3)) 
              (make-vaca (- MEIO-X 3) -3))
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
  
(check-expect (desenha-vaca (make-vaca MEIO-X 3))
              (place-image IMG-VACA MEIO-X Y-VACA CENARIO))
(check-expect (desenha-vaca (make-vaca MEIO-X -3))
              (place-image (flip-horizontal IMG-VACA) MEIO-X Y-VACA CENARIO))


;; Vaca KeyEvent -> Vaca
;; quando teclar ESPAÇO vira a vaca (inverte dx)

(define (trata-tecla v ke)
  (cond [(key=? ke " ") (make-vaca (vaca-x v) (- (vaca-dx v)))]
        [else v])
        )


;; Testes
(check-expect (trata-tecla (make-vaca MEIO-X 3) " ")
              (make-vaca MEIO-X -3))
(check-expect (trata-tecla (make-vaca MEIO-X 3) "a")
              (make-vaca MEIO-X 3))


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


;; distancia: Natural Natural Natural Natural -> Numero
;; calcula a distancia euclidiana entre dois pontos
; !!!

;stub
(define (distancia x1 y1 x2 y2)
  (sqrt (+ (sqr (- x2 x1)) (sqr (- y2 y1)))))

; Testes
(check-expect (distancia 0 0 3 4) 5)
(check-expect (distancia 2 3 5 3) 3)
(check-expect (distancia 1 1 4 5) 5)
(check-expect (distancia 2 3 2 3) 0)
(check-within (distancia 5 7 10 20) (sqrt (+ (sqr (- 10 5)) (sqr (- 20 7)))) 0.01)
(check-expect (distancia (- MEIO-X METADE-L-VACA METADE-L-CC) Y-VACA X-CC MEIO-Y)
              (- MEIO-X (- MEIO-X METADE-L-VACA METADE-L-CC)))

;; colidindo-vaca-cc?: Vaca, Chupacabra -> Boolean
;; Retorna true se vaca e cc estiverem colidindo, ou false caso contrário
;; !!!

;stub
;(define (colidindo-vaca-cc? v cc) #false)

(define (colidindo-vaca-cc? v cc)
    (<= (distancia (vaca-x v) Y-VACA X-CC (chupacabra-y cc))
      (+ METADE-L-VACA METADE-L-CC))
  )


;; Testes
(check-expect (colidindo-vaca-cc?
               (make-vaca LIMITE-ESQUERDO 3)
               (make-chupacabra MEIO-Y 10))
              #false)

(check-expect (colidindo-vaca-cc?
               (make-vaca (- MEIO-X METADE-L-VACA METADE-L-CC) 3)
               (make-chupacabra MEIO-Y 10))
              #true)





;; Jogo -> Jogo
;; produz o próximo estado do jogo
;; !!!

;stub
;(define (atualiza-jogo j) j)

(define (atualiza-jogo j)
  (cond
    [(colidindo-vaca-cc? (jogo-vaca j) (jogo-cc j))
     (make-jogo
      (jogo-vaca j)
      (jogo-cc j)
      (+ (jogo-mortes j) 1)
      #true)]
    [else
     (make-jogo
      (atualiza-vaca (jogo-vaca j))
      (atualiza-chupacabra (jogo-cc j))
      (jogo-mortes j)
      (jogo-game-over? j))]
    )
  )
  

;; Testes
; CASO NORMAL
(check-expect (atualiza-jogo JOGO-INICIO-ANTIGO) 
              (make-jogo
               (make-vaca (+ LIMITE-ESQUERDO DX-PADRAO-VACA) DX-PADRAO-VACA)
               (make-chupacabra (+ LIMITE-CIMA DY-PADRAO-CC) DY-PADRAO-CC)
               0
               #false))
                          
; CASOS COLISAO
(check-expect (atualiza-jogo JOGO-COLIDINDO1)
              (make-jogo
               (make-vaca (- MEIO-X METADE-L-VACA METADE-L-CC) 3)
               (make-chupacabra MEIO-Y 10)                 
                1 #true)
              )

(check-expect (atualiza-jogo JOGO-COLIDINDO2)
              (make-jogo
               (make-vaca (+ (- MEIO-X METADE-L-VACA METADE-L-CC) 3) 3)
               (make-chupacabra MEIO-Y 10)                 
                1 #true)
              )



;; Jogo -> Image
;; desenha o jogo com os seus elementos
;; !!!

;stub
(define (desenha-jogo j)
  (place-image (text (string-append "mortes: " (number->string (jogo-mortes j))) 25 "blue")
               (- LARGURA-CENARIO 80) 30 
               (cond
                 [(jogo-game-over? j)
                  (place-image (text "GAME OVER" 50 "red") MEIO-X MEIO-Y CENARIO)]
                 [else
                  (place-image IMG-CC X-CC (chupacabra-y (jogo-cc j))
                               (desenha-vaca (jogo-vaca j))
                               )]
                 )
               )
  )

; Testes
;(define JOGO-GAME-OVER (make-jogo
;                        (make-vaca (- MEIO-X METADE-L-VACA METADE-L-CC) 3)
;                        (make-chupacabra MEIO-Y 10)                 
;                        1 #true))


(check-expect (desenha-jogo JOGO-INICIO-ANTIGO) 
              (place-image IMG-CC X-CC LIMITE-CIMA
                           (place-image IMG-VACA LIMITE-ESQUERDO Y-VACA CENARIO)))

(check-expect (desenha-jogo JOGO-GAME-OVER)
              (place-image (text "GAME OVER" 50 "red") MEIO-X MEIO-Y CENARIO))


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
;; inicie o mundo com (main JOGO-INICIO-ANTIGO) 
;; 
(define (main v)
  (big-bang v               ; Jogo   (estado inicial do mundo)
            (on-tick   atualiza-jogo)     ; Jogo -> Jogo    
                                   ;(retorna um novo estado do mundo dado o atual a cada tick do clock)
            (to-draw   desenha-jogo)   ; Jogo -> Image   
                                          ;(retorna uma imagem que representa o estado atual do mundo)
            (on-key    trata-tecla-jogo)))    ; Jogo KeyEvent -> Jogo
                                    ;(retorna um novo estado do mundo dado o estado atual e uma interação com o teclado)
