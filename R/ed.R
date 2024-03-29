#' Seleciona as últimas colunas de um banco de dados
#' @aliases ed
#' 
#' @description
#'  Enquanto \code{\link{tail}} mostra as últimas linhas de uma matriz ou "data frame", \code{ed()} mostra as últimas colunas de uma matriz ou "data frame".
#' 
#' @param x Banco de dados (objeto da classe \code{data.frame}, \code{matrix} ou \code{table})
#' @param n Número de colunas a selecionar (por padrão são 5)
#' 
#' @returns Um objeto de classe \code{data.frame} com as últimas colunas selecionadas de uma matriz ou banco de dados.
#' 
#' @examples
#' ed(RDRS2019) |> # As últimas 5 colunas do banco
#'   head()
#' ed(RDRS2019, 8) |> # As últimas 8 colunas do banco
#'   head() 
#' ed(RDRS2019, 1) |> # A última coluna do banco
#'   head() 
#'
#' @export
#'
ed <- function(x, n = 5) {
  n <- n-1
  x[, (ncol(x)-n):ncol(x), drop = FALSE]
}
