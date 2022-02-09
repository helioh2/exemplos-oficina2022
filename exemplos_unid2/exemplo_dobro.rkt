;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exemplo_dobro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; PROBLEMA:
;; Projete uma função que consome um número e produz o numero vezes dois.
;; Vamos chamar essa função de 'dobro'. Vamos seguir a receita.


; dobro: Numero -> Numero
; Retorna o dobro do valor passado

;stub
;(define (dobro n) 0)

(define (dobro n)
  (* n 2))

; Exemplos (testes):
(check-expect (dobro 10) 20) ; compara valor real com valor esperado
(check-expect (dobro 0) 0)
(check-expect (dobro -10) -20)
(check-expect (dobro 1.5) 3)

;template utilizado:
#;
(define (fn-para-numero x)
  (... x))



