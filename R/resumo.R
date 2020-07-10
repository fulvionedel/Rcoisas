#' Contagem de missings
#' @aliases resumo
#' @description Devo ter copiado do R-Commander, ver isso
#' @param x a vector of class \code{numeric} or \code{factor}
#'
#' @export
#'
resumo <- function (x){
  propmiss = round(sum(is.na(x)) / length(x), 2)
  resvals = unname(summary(x))
  resvals = cbind(rbind(resvals[1:length(resvals)]), propmiss[1])
  # resnames = c(names(summary(x)), "NA(%)")
  # colnames(resvals) = resnames
  colnames(resvals) = c(names(summary(x)), "NA(%)")

  prmatrix(resvals, rowlab = '')
}
