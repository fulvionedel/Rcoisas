#' Gráfico da probababilidade de pertencer a uma área da curva Normal
#' @aliases plotZ
#' 
#' @param x valor a comparar com a média
#' @param mu média
#' @param dp desvio-padrão
#' @param p probabilidade
#' @param z escore-z
#' @param cor cor do preenchimento da área sob a curva
#' @param main título
#' @param sub subtítulo
#' @param area "abaixo" (padrão) calcula e desenha a probabilidade de um valor menor ou igual a x, p ou z; "acima" calcula e desenha a probabilidade de um valor maior que x, p ou z
#' @param cex.main tamanho da fonte do título
#' @param cex.sub  tamanho da fonte do subtítulo
#' @param cex.axis tamanho da fonte do eixo
#' @param ... Permite o uso de outros parâmetros gráficos (veja o uso de `density`, nos exemplos)
#' 
#' @examples 
#' \dontrun{
#' plotZ(p = .975)
#' plotZ(p = .025)
#' plotZ(z = 1.96, density = 20)
#' plotZ(z = -1.96, density = 40)
#' plotZ(x = 10, mu = 4.7, dp = 2.7, cor = "yellow")
#' plotZ(x = 10, mu = 4.7, dp = 2.7, area = "acima")
#' plotZ(p =  .975, area = "acima")
#' plotZ(p =  .025, area = "acima")
#' plotZ(z =  1.96, area = "acima")
#' plotZ(z = -1.96, area = "acima")
#' plotZ(x = c(8, 10), mu = 4.7, dp = 2.7)
#' }
#' 
#' @export
#' 
plotZ <- function(x = NULL, mu = 0, dp = 1, p = NULL, z = NULL, 
                  cor = 2, main = NULL, sub = NULL, 
                  area = 'abaixo', 
                  cex.main = 2, cex.sub = 1.5, cex.axis = 1.3,
                  ...) {
  # if(!is.null(p) & (p<0 | p>1)) {
  #   cat("ERRO:\tA probabilidade deve estar entre 0 e 1.")
  #   return()
  #   }
  titulo.abaixo <- bquote(P(X <= .(x), 
                         italic(N(bar(x)==.(formatC(mu, decimal.mark = ",")), 
                         s==.(formatC(dp, decimal.mark = ",")))))
                         )
  titulo.acima <- bquote(P(X > .(x), 
                         italic(N(bar(x)==.(formatC(mu, decimal.mark = ",")), 
                         s==.(formatC(dp, decimal.mark = ",")))))
                         )
  
  if(!is.null(x)) { 
    zp <- z <- (x - mu)/dp
    if(is.null(main)) {
      if(area == "abaixo") { 
        main <- titulo.abaixo
      } else if(area == "acima") {
        main <- titulo.acima
      }
    }
  }
  
  if(!is.null(p)) {
    zp = qnorm(p) 
  } else if(!is.null(z)) {
    zp = z
    # if(is.null(x)) main = ""
  }
  
  if(is.null(main)) {
    main <- expression(italic(N(mu==0, sigma==1)))
  }

  if(is.null(sub)) {
    if(area == 'abaixo') {
      if(!is.null(p)) { 
        prob <- bquote(P(X <= .(formatC(qnorm(p), 3, format = "fg", decimal.mark = ","))) == .(formatC(p, 3, format = "f", decimal.mark = ",")))
        # prob <- bquote(P(X <= .(p)) == .(round(qnorm(p), 3)))
      } else if(!is.null(z)) {
        prob <- bquote(P(Z <= 
                         .(formatC(z, 2, format = "f", decimal.mark = ","))) ==
                         .(formatC(pnorm(z), 3, format = "fg", decimal.mark = ",")))
        }
      } else if (area == 'acima') {
          if(!is.null(p)) {
            prob <- bquote(P(X > .(formatC(1-qnorm(p), 3, format = "f", decimal.mark = ","))) == .(p))
          } else if(!is.null(z)) {
            prob <- bquote(P(Z > .(formatC(z, 2, format = "f", decimal.mark = ","))) == .(formatC(1-pnorm(z), 3, format = "f", decimal.mark = ",")))
          }
      } else if (area == "intervalo"){
          prob <- paste("falta isso")
        }
  } else 
    prob <- sub

  d <- rnorm(1000000)
  plot(density(d), lwd=2, xlim = c(-3.5,3.5),
       axes = F, cex.lab = 1.3,
       xlab = expression(italic(Z)), ylab = "",
       main = main,
       cex.main = cex.main)
  axis(1, -4:4, cex.axis = cex.axis)
  mtext(prob, 3, -.25, cex = cex.sub)
  # polygon(c(-4, seq(-4,4, .1), 4), c(0, dnorm(seq(-4, 4, .1)), 0), col = 0)
  if (area == "intervalo") {
    # return(zp)
    x.val <- c(zp[1], seq(zp[1], 4, 0.01), zp[1])
    y.val <- c(0, dnorm(seq(zp[1], 4, 0.01)), 0)
    polygon(x.val, y.val, col = cor, border = NA, ...)
    # x.val <- c(zp[2], seq(zp[2], 4, 0.01), zp[2]) 
    # y.val <- c(0, dnorm(seq(zp[2], 4, 0.01)), 0)
    # polygon(x.val, y.val, col = 0, border = NA, ...)
    x.val <- c(zp[2], seq(zp[2], 4, 0.01), zp[2])
    y.val <- c(0, dnorm(seq(zp[2], 4, 0.01)), 0)
    polygon(x.val, y.val, col = 4, border = NA, ...)
    return()
  } else if(area == 'abaixo') {
    x.val <- c(-4, seq(-4, zp, 0.01), zp) 
    y.val <- c(0, dnorm(seq(-4, zp, 0.01)), 0)
  } else if (area == 'acima') {
    x.val <- c(zp, seq(zp, 4, 0.01), zp) 
    y.val <- c(0, dnorm(seq(zp, 4, 0.01)), 0)
  } 
  polygon(x.val, y.val, col = cor, border = NA)#, ...)
}
