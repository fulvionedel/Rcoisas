#' Escreve números em texto, em português 
#' @aliases numescrito
#' 
#' @description
#' Dado um número entre 0 e 12, devolve seu valor em texto em português.
#' 
#' @details
#' Para números negativos ou maiores de 12
#' 
#' @param x Número a ser convertido
#' @param genero Gênero do número. Se "fem" ou "f" o número será escrito no feminino.
#' 
#' @examples
#' numescrito(0)
#' numescrito(1)
#' numescrito(1, genero = 'fem')
#' paste(numescrito(2, 'f'), "+", numescrito(3), "=", numescrito(2+3))
#' paste(numescrito(3), "-", numescrito(2, 'f'), "=", numescrito(3-2, 'f'))
#' # Limitações: 0<x<12
#' numescrito(-2)
#' numescrito(13)
#' numescrito(20)
#' paste(numescrito(6), "+", numescrito(7), "=", numescrito(6+7))
#' paste(numescrito(13), "-", numescrito(6), "=", numescrito(13-6))
#' 
#' @export 
#' 
numescrito <- function(x, genero = "masc") {
  texto = c("um", "dois", "tr\u00eas", "quatro", "cinco", "seis", "sete", "oito", "nove", "dez", "onze", "doze")
  if (genero %in% c("fem", "f")) { texto[1:2] = c("uma", "duas") }
  if(x == 0) return("zero")
  if(x %in% 1:12) {
    v = texto[x]
  } else v = x
  v
}
