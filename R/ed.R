#' Seleciona as últimas colunas de um banco de dados
#' @aliases ed
#' 
#' @description
#'  Enquanto \code{\link{tail}} mostra as últimas linhas de uma matriz ou "data frame", \code{ed()} mostra as últimas colunas de uma matriz ou "data frame".
#' 
#' @param x Banco de dados (objeto da classe \code{data.frame}, \code{matrix} ou \code{table})
#' @param n Número de colunas a selecionar (por padrão são 5)
#'
#' @examples
#' ed(RDRS2019) |> # As últimas 5 colunas do banco
#'   head()
#' ed(RDRS2019, 8) |> # As últimas 8 colunas do banco
#'   head() 
#'
#' @export
#'
ed <- function(x, n = 5) {
  x[, (ncol(x)-n):ncol(x)]
}
