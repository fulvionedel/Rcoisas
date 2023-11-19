#' Números em formato latino
#'
#' Apresenta números em formato latino, com ponto (.) como separador de milhar e vírgula (,) como separador decimal, mudando a classe do objeto de \code{numeric} para \code{character}. A função simplesmente altera os padrões de \code{\link{formatC}} para \code{big.mark = "."} e \code{decimal.mark = ","}.
#' 
#' @param x Um número ou vetor com números
#' @param digits Número de decimais
#' @param format Formato numérico (ver \code{\link{formatC}})
#' @param ... Permite outros argumentos da função \code{\link{formatC}}
#' 
#' @returns Um vetor de classe \code{character} com os valores formatados para impressão.
#' 
#' @seealso \code{\link{formatC}}, \code{\link{format}}
#' 
#' @examples 
#' formatL(1234.5678)
#' formatL(rnorm(5), digits = 2)
#' set.seed(1)
#' x <- c(rnorm(5, 30, 10), rep(20, 2), 25)
#' x
#' formatL(x)
#' formatL(x, format = "fg", digits = 3) 
#' \dontrun{
#'  > formatL(x, format = "fg", digits = 3) |>
#'  +   stringr::str_trim() 
#'  [1] "23,7" "31,8" "21,6" "46"   "33,3" "20"   "20"   "25"   
#'  }
#'  
#' @export
#' 
formatL <- function(x, digits = 1, format = "f", ...) {
  if(!is.numeric(x)) { x <- as.numeric(x) }
  formatC(x, digits = digits, format = format, decimal.mark = ",", big.mark = ".")
}
