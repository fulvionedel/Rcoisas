#' Números em formato latino
#'
#' Transforma números em caráter com ponto (.) como separador de milhar e vírgula (,) como separador decimal, alterando os padrões da função \code{\link{formatC}} para \code{big.mark = "."} e \code{decimal.mark = ","}.
#' 
#' @param x Um número ou vetor com números
#' @param digits Número de decimais
#' @param format Formato numérico (ver \code{\link{formatC}})
#' @param ... Permite outros argumentos da função \code{\link{formatC}}
#' 
#' @export
#' 
#' @seealso \code{\link{formatC}}, \code{\link{format}}
#' 
#' @examples 
#' formatL(1234.5678)
#' formatL(rnorm(5), digits = 2)

formatL <- function(x, digits = 1, format = "f", ...) {
  if(!is.numeric(x)) { x <- as.numeric(x) }
  formatC(x, digits = digits, format = format, decimal.mark = ",", big.mark = ".")
}
