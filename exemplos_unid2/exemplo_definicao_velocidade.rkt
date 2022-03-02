;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exemplo_definicao_velocidade) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Projetar uma função que recebe a velocidade e o tempo e calcula a distância


;; ------ DEFINIÇÕES DE DADOS -------

; Velocidade é um Numero
; pulando passos 1 e 2 pois é um dado atômico
; interp. velocidade de um automovel em km/h

;; Exemplos de dados do tipo Velocidade
(define PARADO 0)
(define NO-LIMITE 80)
(define CORRENDO-QUE-NEM-DOIDO 160)

; Template: template para tipo atômico
#;
;(define (fn-para-velocidade v)
;  (... v))

; ---------

; Tempo é um Numero[>=0]
; interp. tempo em horas

;; Exemplos de dados do tipo Tempo
(define T-INICIAL 0)
(define T-ATUAL 0.5) ; meia hora

; Template:
#;
(define (fn-para-tempo t)
  (cond
    [(< t 0) "ERRO"]
    [else ...]))

; para-minutos: Tempo -> Numero
; converte o empo em horas para minuos

;stub (prototipo bobo)
(define (para-minutos t) t)

;Testes (exemplos)
(check-expect (para-minutos 1) 60)
(check-expect (para-minutos -10) "ERRO")
(check-expect (para-minutos 0) 0)










;; ...





