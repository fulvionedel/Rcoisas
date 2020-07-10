#' @title Função para desenhar histogramas com boxplot integrado
#' @description os eixos são centrados
#' 
#' @aliases histobox
#' @param x uma variável numérica
#' @param limites limites do eixo x **Tem de arrumar, não funciona como opção**
#' @param col.h = cor do histograma
#' @param col.bx = cor do boxplot
#' @param ... outros parâmetros de \code{\link{hist}} e \code{\link{boxplot}}
#' 
#' @export
histobox <-
  function(x, limites, col.h='cyan', col.bx='skyblue1', ... )
  {
    nf <- layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  heights = c(4,1))
    mini <- min(x, na.rm=T) + min(x, na.rm=T)*.1
    maxi <- max(x, na.rm=T) + max(x, na.rm=T)*.1
    limites <- c(mini, maxi)
    # par(mar=c(5.1, 4.1, 1.1, 2.1))
    par(mar=c(3.1, 4.1, 1.1, 2.1))
    hist(x, axes=F, xlim=limites, xlab='', col=col.h, ...)
    axis(2)
    par(mar=c(1.5, 4.1, 21, 2.1),new=T)
    boxplot(x, horizontal=TRUE, outline=TRUE, frame=F, col=col.bx, ylim=limites)
  }
