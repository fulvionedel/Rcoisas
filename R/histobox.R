#' @title Histograma com boxplot
#' @description Desenha um histograma com boxplot integrado ao mesmo gráfico
#' 
#' @aliases histobox
#' @param x uma variável numérica
#' @param limites limites do eixo x
#' @param col.h = cor do histograma
#' @param col.bx = cor do boxplot
#' @param ... outros parâmetros de \code{\link{hist}} e \code{\link{boxplot}}
#' 
#' @examples 
#' histobox(rnorm(1000))
#' 
#' @export
histobox <-
  function(x, limites = NULL, col.h = 'cyan', col.bx = 'skyblue1', ... )
{
  old.par <- par(no.readonly = TRUE)
  on.exit(par(old.par))
  
  mini <- min(x, na.rm = T) + min(x, na.rm = T)*.1
  maxi <- max(x, na.rm = T) + max(x, na.rm = T)*.1
  if(is.null(limites)) limites <- c(mini, maxi)
  layout(mat = matrix(c(1,2),2,1, byrow=TRUE), heights = c(1,8))
  op <- par(mar = c(0, 3.1, 1.1, 2.1))
  boxplot(x, horizontal = TRUE, xaxt = "n", frame = F, col = col.bx, ylim = limites)
  par(mar = c(4, 3.1, 1.1, 2.1))
  hist(x, xlim = limites, main = NULL, col = col.h, ...) 

  invisible()
}
