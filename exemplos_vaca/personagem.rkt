#lang racket

(require 2htdp/image)
(require "constantes.rkt")
(require "utils.rkt")

(provide (all-defined-out))


;; =================
;; Definições de dados:

(define-struct personagem (x y dx dy largura altura) #:transparent)
;; Personagem é (make-personagem Natural Natural Inteiro Inteiro Natural Natural)
;; interp. posicao do personagem nos eixos x e y, em pixels.
;; e dx e dy representando o vetor de deslocamento
;; isto é, direção, sentido e módulo da velocidade
;; largura e altura é o tamanho do personagem

;; Exemplos vaca:
(define VACA-INICIO (make-personagem LIMITE-ESQUERDO Y-PADRAO-VACA DX-PADRAO-VACA DY-PADRAO-VACA LARGURA-VACA ALTURA-VACA))
(define VACA-INICIO-PROX (make-personagem (+ LIMITE-ESQUERDO DX-PADRAO-VACA) (+ Y-PADRAO-VACA DY-PADRAO-VACA) DX-PADRAO-VACA DY-PADRAO-VACA LARGURA-VACA ALTURA-VACA))
(define VACA-INO (make-personagem MEIO-X Y-PADRAO-VACA DX-PADRAO-VACA DY-PADRAO-VACA LARGURA-VACA ALTURA-VACA))
(define VACA-LIMITE-DIREITO (make-personagem LIMITE-DIREITO Y-PADRAO-VACA DX-PADRAO-VACA DY-PADRAO-VACA LARGURA-VACA ALTURA-VACA))
(define VACA-VORTANO (make-personagem MEIO-X Y-PADRAO-VACA (- DX-PADRAO-VACA) DY-PADRAO-VACA LARGURA-VACA ALTURA-VACA))
(define VACA-VORTANO-LIMITE-ESQUERDO (make-personagem LIMITE-ESQUERDO Y-PADRAO-VACA (- DX-PADRAO-VACA) DY-PADRAO-VACA LARGURA-VACA ALTURA-VACA))

; Exemplos chupacabra
(define CC-INICIO (make-personagem X-PADRAO-CC LIMITE-CIMA DX-PADRAO-CC DY-PADRAO-CC LARGURA-CC ALTURA-CC))
(define CC-INICIO-PROX (make-personagem (+ X-PADRAO-CC DX-PADRAO-CC) (+ LIMITE-CIMA DY-PADRAO-CC) DX-PADRAO-CC DY-PADRAO-CC LARGURA-CC ALTURA-CC))
(define CC-INO (make-personagem X-PADRAO-CC MEIO-Y DX-PADRAO-CC DY-PADRAO-CC LARGURA-VACA ALTURA-VACA))
(define CC-INO-PROX (make-personagem (+ X-PADRAO-CC DX-PADRAO-CC) (+ MEIO-Y DY-PADRAO-CC) DX-PADRAO-CC DY-PADRAO-CC LARGURA-VACA ALTURA-VACA))
(define CC-LIMITE-BAIXO (make-personagem X-PADRAO-CC LIMITE-BAIXO DX-PADRAO-CC DY-PADRAO-CC LARGURA-VACA ALTURA-VACA))
(define CC-VORTANO (make-personagem X-PADRAO-CC MEIO-Y DX-PADRAO-CC (- DY-PADRAO-CC) LARGURA-VACA ALTURA-VACA))
(define CC-VORTANO-LIMITE-CIMA (make-personagem X-PADRAO-CC LIMITE-CIMA DX-PADRAO-CC (- DY-PADRAO-CC) LARGURA-VACA ALTURA-VACA))

#;
(define (fn-para-personagem p)
  (... (personagem-x p)
       (personagem-y p)
       (personagem-dx p)
       (personagem-dy p)
       (personagem-largura p)
       (personagem-altura p))
  )


;; List<Personagem> é (cons Personagem List<Personagem>)
;; interp. lista de personagens
; Exemplos
(define LP-VAZIA empty)
(define LP-UM-CC (cons CC-INICIO empty))
(define LP-DOIS-CC (cons CC-VORTANO LP-UM-CC))
(define LP-TRES-CC (list CC-INICIO CC-VORTANO CC-INO))

#;
(define (fn-para-ldp ldp)
  (cond [(empty? ldp) (...)]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (... (first ldp)                 ;String
                   (fn-for-ldp (rest ldp)))])) ;RECURSÃO EM CAUDA


;; =================
;; Funções:

;; --------------------- INICIO FUNCOES DA VACA ------------------

;; Personagem -> Personagem
;; move o personagem de acordo com seu valor dx e dy

(define (move-personagem p)
  (let* (
      [novo-x (+ (personagem-x p) (personagem-dx p))]
      [novo-y (+ (personagem-y p) (personagem-dy p))]
      [bateu-no-limite-direito? (> novo-x LIMITE-DIREITO)]
      [bateu-no-limite-esquerdo? (< novo-x LIMITE-ESQUERDO)]
      [bateu-no-limite-baixo? (> novo-y LIMITE-BAIXO)]
      [bateu-no-limite-cima? (< novo-y LIMITE-CIMA)]
      )
    
  (make-personagem
   ;x:
   ;; possivel refatoração: (gera-novo-x novo-x)
   (cond
     [bateu-no-limite-direito? LIMITE-DIREITO]
     [bateu-no-limite-esquerdo? LIMITE-ESQUERDO]
     [else novo-x]
   )
   ;y:
   (cond
     [bateu-no-limite-cima? LIMITE-CIMA]
     [bateu-no-limite-baixo? LIMITE-BAIXO]
     [else novo-y]
   )
   ;dx
   (if (or bateu-no-limite-direito? bateu-no-limite-esquerdo?)
       (- (personagem-dx p)) ;then
       (personagem-dx p))  ;else
   ;dy
   (if (or bateu-no-limite-cima? bateu-no-limite-baixo?)
       (- (personagem-dy p)) ;then
       (personagem-dy p))  ;else

   ;largura e altura (se mantêm)
   (personagem-largura p) (personagem-altura p)
   )
    )
  )


;; move-personagens: List<Personagem> -> List<Personagem>
;; Move todos os personagens de uma lista

;stub
;(define (move-personagens ldp) ldp)

;(define (move-personagens ldp)
;  (cond [(empty? ldp) empty]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;        [else (cons (move-personagem (first ldp))                 ;String
;                   (move-personagens (rest ldp)))])) ;RECURSÃO EM CAUDA

(define (move-personagens ldp)
  (map move-personagem ldp)
  )


;; colidindo?: Personagem Personagem -> Boolean
;; Retorna true se par de personagens estiverem colidindo, ou false caso contrário

;stub
;(define (colidindo? v cc) #false)

(define (colidindo? p1 p2)
  (let* (
         [soma-dos-raios-dos-personagens (+ (/ (personagem-largura p1) 2) (/ (personagem-largura p2) 2))]
         )
    (<= (distancia (personagem-x p1) (personagem-y p1) (personagem-x p2) (personagem-y p2))
        soma-dos-raios-dos-personagens)
      )
  )



;; colidindo-com-algum?: Personagem List<Personagem> -> Boolean
;; retorna true se o primeiro personagem colide com algum dos outros personagens

;stub
;(define (colidindo-com-algum? p ldp) #false)


;(define (colidindo-com-algum? p ldp)
;  (cond [(empty? ldp) #false]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;        [else (or (colidindo? p (first ldp))                 ;String
;                   (colidindo-com-algum? p (rest ldp)))])) ;RECURSÃO EM CAUDA

(define (colidindo-com-algum? p ldp)
  (ormap (lambda (p1) (colidindo? p p1)) ldp)
 )



;; Personagem Image Image -> Image
;; desenha o personagem
(define (desenha-personagem p img fundo)
  (let* (
         ;[scale-x (/ (personagem-largura p) (image-width img))]
         ;[scale-y (/ (personagem-altura p) (image-height img))]
         ;[imagem-direcao-correta (if (< (personagem-dx p) 0) (flip-horizontal img) img)]
         ;[imagem-redimensionada-e-na-direcao-correta (scale/xy scale-x scale-y imagem-direcao-correta)]       
         )
  (place-image img
               (personagem-x p)
               (personagem-y p)
               fundo)
    )
  )


;; desenha-personagens: List<Personagem> Image Image -> Image
;; desenha varios personagens

;(define (desenha-personagens ldp img fundo)
(define (desenha-personagens  ldp img fundo)
  (cond [(empty? ldp) fundo]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (desenha-personagem (first ldp) img                 ;String
                   (desenha-personagens (rest ldp) img fundo))]))