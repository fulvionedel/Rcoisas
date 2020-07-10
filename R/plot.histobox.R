#' Método para histobox
#' porque ele parece que pede
#' 
#' @aliases plot.histobox
#' @param x Uma variável numérica
#' @param ... Permite a inclusão de argumentos para \code{\link{hist}}
#' @export 
plot.histobox <- function(x, ...) {
  UseMethod("plot.histobox")
}
#' @export
plot.histobox <-
  function(x, ... )
  {
    # par(mar=c(5.1, 4.1, 1.1, 2.1))
    par(mar=c(3.1, 4.1, 1.1, 2.1))
    hist(x, ...)
    axis(2)
    par(mar=c(1.5, 4.1, 21, 2.1),new=T)
    boxplot(x, horizontal=TRUE, outline=TRUE)
  }
