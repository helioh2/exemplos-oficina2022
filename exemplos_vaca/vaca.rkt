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

(define LIMITE-ESQUERDO 0)
(define LIMITE-DIREITO LARGURA-CENARIO)

(define Y (/ ALTURA-CENARIO 2))
(define IMG-VACA (bitmap "vaca.png"))

(define DX-PADRAO 3)
(define TC-VIRA " ")

;; =================
;; Definições de dados:

(define-struct vaca (x dx))
;; Vaca é (make-vaca Natural Inteiro)
;; interp. posicao da vaca no eixo x e a direção dx, em pixels

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


;; EstadoMundo -> EstadoMundo
;; produz o próximo ...
;; !!!
#;
(define (tock estado) ...)


;; EstadoMundo -> Image
;; desenha 
;; !!!
#;
(define (desenha-mundo estado) ...)


;; EstadoMundo KeyEvent -> EstadoMundo
;; quando teclar ...  produz ...  <apagar caso não precise usar>
#;
(define (handle-key estado ke)
  (cond [(key=? ke " ") (... estado)]
        [else
         (... estado)]))

;; EstadoMundo Integer Integer MouseEvent -> EstadoMundo
;; Quando fazer ... nas posições x y no mouse produz ...   <apagar caso não precise usar>
#;
(define (handle-mouse estado x y me)
(cond [(mouse=? me "button-down") (... estado x y)]
      [else
       (... estado x y)]))




;; EstadoMundo -> EstadoMundo
;; inicie o mundo com ...
;; 
#;
(define (main estado)
  (big-bang estado               ; EstadoMundo   (estado inicial do mundo)
            (on-tick   tock)     ; EstadoMundo -> EstadoMundo    
                                   ;(retorna um novo estado do mundo dado o atual a cada tick do clock)
            (to-draw   desenha-mundo)   ; EstadoMundo -> Image   
                                          ;(retorna uma imagem que representa o estado atual do mundo)
            (stop-when ...)      ; EstadoMundo -> Boolean    
                                    ;(retorna true se o programa deve terminar e false se deve continuar)
            (on-mouse  ...)      ; EstadoMundo Integer Integer MouseEvent -> EstadoMundo    
                                    ;(retorna um novo estado do mundo dado o estado atual e uma interação com o mouse)
            (on-key    ...)))    ; EstadoMundo KeyEvent -> EstadoMundo
                                    ;(retorna um novo estado do mundo dado o estado atual e uma interação com o teclado)