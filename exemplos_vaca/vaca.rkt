;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname vaca) (read-case-sensitive #t) (teachpacks ((lib "testing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "testing.rkt" "teachpack" "htdp")) #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Meu programa mundo  (torne isto mais específico)

;; =================
;; Constantes:

(define ALTURA-CENARIO 300)
(define LARGURA-CENARIO 400)
(define CENARIO (empty-scene LARGURA-CENARIO ALTURA-CENARIO))

(define MEIO (/ LARGURA-CENARIO 2))

(define IMG-VACA (bitmap "vaca.png"))

(define LIMITE-ESQUERDO (+ 0 (/ (image-width IMG-VACA) 2)))
(define LIMITE-DIREITO (- LARGURA-CENARIO (/ (image-width IMG-VACA) 2)))

(define Y (/ ALTURA-CENARIO 2))


(define DX-PADRAO 3)
(define TC-VIRA " ")

;; =================
;; Definições de dados:

(define-struct vaca (x dx))
;; Vaca é (make-vaca Natural Inteiro)
;; interp. posicao da vaca no eixo x e a direção dx, em pixels.
;; se dx>=0, vaca estará apontando para a direita, se dx<0, estará apontando p/ esquerda

;; Exemplos:
(define VACA-INICIO (make-vaca LIMITE-ESQUERDO DX-PADRAO))
(define VACA-INO (make-vaca MEIO DX-PADRAO))
(define VACA-LIMITE-DIREITO (make-vaca LIMITE-DIREITO DX-PADRAO))
(define VACA-VORTANO (make-vaca MEIO (- DX-PADRAO)))
(define VACA-VORTANO-LIMITE-ESQUERDO (make-vaca LIMITE-ESQUERDO (- DX-PADRAO)))

;#
(define (fn-para-vaca v)
  (... (vaca-x v)
       (vaca-dx v)))

;; =================
;; Funções:


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
     (place-image (flip-horizontal IMG-VACA) (vaca-x v) Y CENARIO)]
    [else
     (place-image IMG-VACA (vaca-x v) Y CENARIO)]
    )
  )

; Testes
(check-expect (desenha-vaca (make-vaca 0 3))
              (place-image IMG-VACA 0 Y CENARIO))
  
(check-expect (desenha-vaca (make-vaca MEIO 3))
              (place-image IMG-VACA MEIO Y CENARIO))
(check-expect (desenha-vaca (make-vaca MEIO -3))
              (place-image (flip-horizontal IMG-VACA) MEIO Y CENARIO))


;; Vaca KeyEvent -> Vaca
;; quando teclar ESPAÇO vira a vaca (inverte dx)
; !!! (TODO)

(define (trata-tecla v ke)
  (cond [(key=? ke " ") (make-vaca (vaca-x v) (- (vaca-dx v)))]
        [else v])
        )


;; Testes
(check-expect (trata-tecla (make-vaca MEIO 3) " ")
              (make-vaca MEIO -3))
(check-expect (trata-tecla (make-vaca MEIO 3) "a")
              (make-vaca MEIO 3))

;; Vaca -> Vaca
;; inicie o mundo com (main VACA-INICIO)
;; 
(define (main v)
  (big-bang v               ; Vaca   (estado inicial do mundo)
            (on-tick   atualiza-vaca)     ; Vaca -> Vaca    
                                   ;(retorna um novo estado do mundo dado o atual a cada tick do clock)
            (to-draw   desenha-vaca)   ; Vaca -> Image   
                                          ;(retorna uma imagem que representa o estado atual do mundo)
            (on-key    trata-tecla)))    ; Vaca KeyEvent -> Vaca
                                    ;(retorna um novo estado do mundo dado o estado atual e uma interação com o teclado)