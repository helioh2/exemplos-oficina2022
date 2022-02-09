;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname plural) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; PROBLEMA
;; Projete uma função que, dada uma palavra, retorne o plural da palavra (plural ingênuo)


; plural: String -> String
; Retorna o plural de uma palavra

;stub
;(define (plural p) "")

(define (plural p)
  (string-append p "s"))

; Exemplos (testes):
(check-expect (plural "carro") "carros")
(check-expect (plural "cor") "cors") ;versao inicial. para versão nao ingenua, modificar esse teste
