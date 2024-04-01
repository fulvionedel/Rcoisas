#' Escreve números em texto, em português 
#' @aliases numescrito
#' 
#' @description
#' Dado um número entre 0 e 12, devolve seu valor em texto em português.
#' 
#' @param x Número a ser convertido
#' 
#' @examples
#' numescrito(0)
#' numescrito(3)
#' numescrito(-2)
#' numescrito(20)
#' paste(numescrito(2), "+", numescrito(3), "=", numescrito(2+3))
#' 
#' @export 
#' 
numescrito <- function(x) {
  texto = c("um", "dois", "tr\u00eas", "quatro", "cinco", "seis", "sete", "oito", "nove", "dez", "onze", "doze")
  if(x == 0) return("zero")
  if(x %in% 1:12) {
    v = texto[x]
  } else v = x
  v
}
