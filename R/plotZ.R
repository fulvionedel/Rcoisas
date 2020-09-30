#' Gráfico da probababilidade de pertencer a uma área da curva Normal
#' @aliases plotZ
#' 
#' @examples 
#' plotZ(p = .975)
#' plotZ(p = .025)
#' plotZ(z = 1.96)
#' plotZ(z = -1.96)
#' plotZ(p =  .975, sentido = "maior")
#' plotZ(p =  .025, sentido = "maior")
#' plotZ(z =  1.96, sentido = "maior")
#' plotZ(z = -1.96, sentido = "maior")
#' 
#' @export
#' 
plotZ <- function(x = NULL, mu = 0, dp = 1, p = NULL, z = NULL, 
                  cor = 2, main = NULL, sub = NULL, 
                  sentido = 'menor', 
                  cex.main = 2, cex.sub = 1.5, cex.axis = 1.3,
                  ...) {
  # if(!is.null(p) & (p<0 | p>1)) {
  #   cat("ERRO:\tA probabilidade deve estar entre 0 e 1.")
  #   return()
  #   }
  
  # z <- (x - mu)/dp
  
  if(!is.null(p)) {
    zp = qnorm(p) 
  } else if(!is.null(z)) {
    zp = z
    main = ""
  }
  
  if(is.null(main)) {
    main <- expression(italic(N(mu==0, sigma==1)))
  }
  if(is.null(sub)) {
    if(sentido == 'menor') {
      if(!is.null(p)) { 
        prob <- bquote(P(X <= .(round(qnorm(p), 3))) == .(p))
        # prob <- bquote(P(X <= .(p)) == .(round(qnorm(p), 3)))
      } else if(!is.null(z)) {
        prob <- bquote(P(Z <= .(z)) == .(round(pnorm(z), 3)))
        }
      } else if (sentido == 'maior') {
          if(!is.null(p)) {
            prob <- bquote(P(X > .(1-round(qnorm(p), 3))) == .(p))
          } else if(!is.null(z)) {
            prob <- bquote(P(Z > .(z)) == .(1-round(pnorm(z), 3)))
          }
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
  if(sentido == 'menor') {
    x.val <- c(-4, seq(-4, zp, 0.01), zp) 
    y.val <- c(0, dnorm(seq(-4, zp, 0.01)), 0)
  } else if (sentido == 'maior') {
    x.val <- c(zp, seq(zp, 4, 0.01), zp) 
    y.val <- c(0, dnorm(seq(zp, 4, 0.01)), 0)
  }
  polygon(x.val, y.val, col = cor, border = NA, ...)
}


#' 