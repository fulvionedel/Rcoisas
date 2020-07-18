#' @title Tabela de frequências univariada
#' @author Fúlvio B. Nedel
#' @description Constrói uma tabela com distribuição de frequências brutas, relativas e acumuladas, com rótulos em português
#' @aliases tabuleiro
#' 
#' @param x O vetor a ser tabulado
#' @param digits nº de decimais na tabela
#' @param total TRUE (default) apresenta o total de categorias na tabela
#' @param cum TRUE (default) apresenta as frequências acumuladas das cateogrias
#' @param format Caráter indicando se o formato da tabela é anglo-saxão ("en", default) ou latino ("pt"); se "pt", os decimais serão apresentados depois de vírgula e os milhares separados por ponto # NÃO IMPLEMENTADO -- COLOCAR ISSO NUM MÉTODO PRINT.tabuleiro
#' @param data Optional argument. Data frame containing \code{x}. Defaults to NULL
#' @param ... permite o uso de argumentos da função \code{\link{table}}
#' 
#' @examples 
#' set.seed(1)
#' x <- rbinom(100000, 3, .25)
#' tabuleiro(x)
#' 
#' # Sem o total
#' tabuleiro(x, total = FALSE)[,-3]
#' 
#' # Apenas as frequências absolutas e a % acumulada
#' tabuleiro(x)[,-3]
#' 
#' @export
#' 
tabuleiro <- function(x, digits = 1, total = TRUE, cum = TRUE, format = 'en', data = NULL, ...) {
  if ( !is.null(data) ) {
    x = data[,deparse(substitute(x))]
  } 
  tab <- table(x, ...)
  protoptab <- prop.table(tab)*100
  ptab <- round(protoptab, digits)
  cumtab <- cumsum(tab)
  cumptab <- round(cumsum(protoptab), digits)
  Total <- c(sum(tab), sum(protoptab), sum(tab), sum(protoptab))
  # TALVEZ NUM PRINT, MAS NÃO AQUI
  # if(format == 'pt') {
  #   tab = suppressWarnings(format(tab, big.mark = "."))
  #   ptab = suppressWarnings(format(ptab, decimal.mark = ","))
  #   cumtab = suppressWarnings(format(cumtab, big.mark = "."))
  #   cumptab = suppressWarnings(format(cumptab, decimal.mark = ","))
  #   Total = suppressWarnings(format(Total, big.mark = "."))
  # }
  # miolo <- cbind(tab, ptab, cumtab, cumptab)
  # colnames(miolo) <- c('Freq', '%', 'Freq.acum', '%acum')
  miolo <- cbind(Freq=tab, '%'=ptab, Freq.acum=cumtab, '%acum'=cumptab)
#   tabela <- addmargins(miolo, 1)
#   miolo <- cbind(rownames(miolo), miolo)
#   rownames(miolo) <- NULL
#   colnames(miolo)[1] <- nome
  tabela <- rbind(miolo, Total)
  # if(total == TRUE) return(tabela)
  # if(format == 'pt'){
  #   # colnames(miolo)[2] = format(colnames(miolo)[2], justify = 'c')
  #   # colnames(miolo)[2] = "   %"
  #   miolo = format(miolo, justify = 'c')
  #   tabela = format(tabela, justify = 'c')
  # }
  # else return(miolo)
  if(total == FALSE) tabela <- miolo
  if(cum == FALSE) tabela <- tabela[, 1:2]
  return(tabela)
}
