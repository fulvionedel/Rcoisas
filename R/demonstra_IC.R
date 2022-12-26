#' @title Demonstração do intervalo de confiança
#' @aliases demonstra_IC
#' @description Seleciona amostras de uma variável numérica na população e representa as médias e intervalos de confiança de cada amostra em relação à média da população.
#' @param pop População fonte das amostras
#' @param n Nº de unidades amostrais em cada amostra
#' @param r Nº de amostragens
#' @param replace Valor lógico para amostragem com reposição, o padrão é TRUE
#' @param ... argumentos aplicáveis à função \code{\link{t.test}}, útil para a modificação do nível de significância. Veja em 'exemplos' e 'detalhes'
#' 
#' @examples 
#' demonstra_IC(runif(1000))
#' demonstra_IC(rnorm(10000), conf.level = 0.99)
#' 
#' @export
#' 
demonstra_IC <- function(pop, r = 100, replace = TRUE, ...) {
  n <- length(pop)
  amostras <- data.frame(matrix(nrow = n, ncol = r))
  liminf <- limsup <- media <- numeric(length <- r)
  for(i in 1:r) {
    amostras[i] <- sample(pop, n, replace)
    media[i] <- stats::t.test(amostras[i], ...)$estimate
    liminf[i] <- stats::t.test(amostras[i], ...)$conf.int[1]
    limsup[i] <- stats::t.test(amostras[i], ...)$conf.int[2]
  }
  medias <- data.frame(media, liminf, limsup)
  f1 <- ifelse(liminf > mean(pop), 1, 2)
  f2 <- ifelse(limsup < mean(pop), 1, 2)
  medias$fora <- ifelse(f1 == 1 | f2 == 1, 1, 2)
  rm(media, liminf, limsup, i, f1, f2)
  
  requireNamespace("ggplot2")
  fora <- NULL
  grafico <- ggplot2::ggplot(medias, 
                            ggplot2::aes(x = 1:r, y = media, color = fora)) +
    ggplot2::geom_point() +
    ggplot2::geom_errorbar(ggplot2::aes(ymax = limsup, ymin = liminf)) + 
    ggplot2::geom_hline(yintercept = mean(pop)) +
    ggplot2::xlab(label = "amostras") +
    ggplot2::ylab("estimativa central e intervalar de cada amostra\nlinha vertical: m\u00E9dia da popula\U00E7\U00E3o") +
    ggplot2::theme(legend.position="none") +
    ggplot2::coord_flip() 
  
  
  return(list("mediapop" = mean(pop),
              "medias" = medias, 
              "grafico" = grafico, 
              "teste.t" = stats::t.test(medias, ...)))
}
