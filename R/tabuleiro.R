#' @title Tabela de frequências univariada
#' @description Constrói uma tabela com distribuição de frequências brutas, relativas e acumuladas, com rótulos em português.
#' @aliases tabuleiro
#' 
#' @param x O vetor a ser tabulado.
#' @param digits nº de decimais na tabela. O padrão é 1.
#' @param total TRUE (default) apresenta o total de categorias na tabela.
#' @param cum TRUE (default) apresenta as frequências acumuladas das cateogrias.
#' @param data Argumento opcional. Banco de dados contendo \code{x}. O padrão é NULL.
#' @param ... permite o uso de argumentos da função \code{\link{table}}.
#' 
#' @export
#' 
#' @examples 
#' set.seed(1)
#' x <- rbinom(100000, 3, .25)
#' 
#' tabuleiro(x)
#' 
#' # Sem o total
#' tabuleiro(x, total = FALSE)
#' 
#' # Sem as frequências acumuladas
#' tabuleiro(x, cum = FALSE)
#' 
#' # Oculta a frequência acumulada absoluta e mantém a % acumulada
#' tabuleiro(x, total = FALSE)[,-3]
#' 
tabuleiro <- function(x, digits = 1, total = TRUE, cum = TRUE, data = NULL, ...) {
  if ( !is.null(data) ) {
    x = data[,deparse(substitute(x))]
  } 
  tab <- table(x, ...)
  protoptab <- prop.table(tab)*100
  ptab <- round(protoptab, digits)
  cumtab <- cumsum(tab)
  cumptab <- round(cumsum(protoptab), digits)
  Total <- c(sum(tab), sum(protoptab), sum(tab), sum(protoptab))
  miolo <- cbind(Freq=tab, '%'=ptab, Freq.acum=cumtab, '%acum'=cumptab)
  tabela <- rbind(miolo, Total)
  if(total == FALSE) tabela <- miolo
  if(cum == FALSE) tabela <- tabela[, 1:2]
  return(tabela)
}
