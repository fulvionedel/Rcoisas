#' @title Describes a numerical variable
#' @aliases descreve
#' @description Performs a 'complete' description of a numerical variable, continuous or integer, and plots a histogram maybe with lines for mean, median, 1 and 2 sd from and to mean and normal probability curve for the plotted parameters.
#' 
#' @importFrom e1071 skewness kurtosis
#' @import stats graphics 
#' 
#' @param x A numeric vector
#' @param dec The number of digits
#' @param na.rm TRUE (default) removes missings
#' @param data Optional argument. Data frame containing \code{x}. Defaults to NULL.
#' @param histograma TRUE (default) draws a histogram
#' @param breaks number of breaks, according to \code{\link{hist}}; the default method is 'Sturges'
#' @param freq TRUE (default) set y axis to frequency; FAlSE set it to density
#' @param main Graphic title
#' @param xlab Label for x axis
#' @param ylab Label for y axis
#' @param linhas TRUE (default) draws vertical lines with median, mean, and SD +1 position at the histogram
#' @param curva TRUE (default) draws the expected normal curve 
#' @param densidade defaults to FALSE; turn to TRUE to draw the density line
#' @param col.dens colour of density line; defaults to 1 (black)
#' @param col colour of histogram bars; defaults to 'yellow2'
#' @param col.curva colour of normal curve; defaults to 'DarkGreen'
#' @param col.media colour of mean line; defaults to 2 (red)
#' @param col.dp colour of SD lines; defaults to col.media 
#' @param col.mediana colour of median line; defaults to 4 (blue) 
#' @param legenda TRUE (default) draws a legend
#' @param lty.curva line type of normal curve; defaults to 2
#' @param lwd.curva line width of normal curve; defautls to 1
#' @param lty.dens line type of density curve; defaults to 3
#' @param lwd.dens line width of density curve; defaults to 2
#' @param lty line type for the histogram; defaults to NULL
#' @param lwd line width for the histogram; defaults to NULL
#' @param cex font size
#' @param lugar legend position; defaults to 'toprigt'
#' @param ... takes paramters from other functions
#' 
#' @seealso \code{\link{hist}} and \code{\link{par}} for graphic paramters
#' 
#' @importFrom e1071 skewness kurtosis
#' @export

descreve <-
  function (x, dec = 2, na.rm = TRUE, data = NULL,
            histograma = TRUE, breaks='Sturges', freq = TRUE ,
            main = NULL, xlab = NULL, ylab= NULL,
            linhas=2, curva=TRUE, densidade=FALSE, col.dens=1,
            col='yellow2', col.curva='DarkGreen', col.media=2, col.dp=col.media, col.mediana=4,
            legenda = TRUE, lugar='topright',
            lty.curva = 2, lwd.curva = 1, lty.dens = 3, lwd.dens = 2,
            lty = NULL, lwd = NULL, cex = NULL, ...) 
  {
    destinatio <- deparse(substitute(x))
    if ( !is.null(data) ) {
      x <- data[,deparse(substitute(x))]
    } 
    n <- round(length(x))
    miss <- round(sum(is.na(x)))
    val <- round(n - miss)
    p.miss <- miss/n * 100
    soma <- round(sum(x, na.rm = na.rm), dec)
    media <- mean(x, na.rm = na.rm)
    vari <- var(x, na.rm = na.rm)
    dp <- sd(x, na.rm = na.rm)
    cv <- dp/abs(media) * 100
    assimetria <- skewness(x, na.rm = na.rm)
    curtose <- kurtosis(x, na.rm = na.rm) + 3
    quantis <- quantile(x, probs=c(.025,.05,.25,.5,.75,.95,.975), na.rm=na.rm)
    p25 <- quantile(x, probs = 0.25, na.rm = T)
    p50 <- quantile(x, probs = 0.5, na.rm = T)
    p75 <- quantile(x, probs = 0.75, na.rm = T)
    iiq <- p75 - p25 ; names(iiq) <- NULL
    menor <- min(x, na.rm = T)
    maior <- max(x, na.rm = T)
    amplitude <- maior - menor
    # 
    # Arredondamento
    p.miss <- round(p.miss, dec)
    media <- round(media, dec)
    vari <- round(vari, dec)
    dp <- round(dp, dec)
    cv <- round(cv, digits=dec)
    assimetria <- round(assimetria, dec)
    curtose <- round(curtose, dec)
    quantis <- round(quantis, dec)
    # p25 <- 
    p50 <- round(p50, dec)
    # p75 <- 
    iiq <- round(iiq, dec)
    menor <- round(menor, dec)
    maior <- round(maior, dec)
    amplitude <- round(amplitude, dec)
    #
    descr <- list(variavel = destinatio,
                  n=n, validos=val, miss=miss, p.miss=p.miss, 
                  menor=menor, maior=maior, amplitude=amplitude,
                  soma=soma, media=media, variancia=vari, dp=dp, cv=cv, 
                  assimetria=assimetria, curtose=curtose, 
                  quantis=quantis, iiq=iiq)
    class(descr) <- "descreve"
    # class(descr) <- c('descreve', 'descreve2')
    #    return(descr)
    ############################
    # O GRÁFICO
    ###########################
    if (histograma == T) {
      if(is.null(main)){
        titulo <- paste("Histograma de", destinatio)
      } else
        titulo <- main
      if(is.null(xlab)){
        x.lab <- destinatio
      } else
        x.lab <- xlab
      if(is.null(ylab)){
        if(freq == TRUE) y.lab <- 'Frequ\U00EAncia'
        else
          if(freq == FALSE) y.lab <- "Densidade"
      } 
      else
        y.lab <- ylab
      
      hist(x, freq = freq, main = titulo, xlab = x.lab, ylab = y.lab, breaks=breaks, border=0, ...)
      par(new = T)
      hist(x, freq = F, axes = F, xlab = "", ylab = "", main = "", breaks=breaks, col=col, ...)
      if(is.null(cex)) cex = .8
      if (curva == T) {
        if( linhas == 3 & !is.null(lty) ) lty.curva = lty
        if( linhas == 3 & !is.null(lwd) ) lwd.curva = lwd
        curve(dnorm(x, media, dp), add = T, 
              lty = lty.curva, lwd = lwd.curva, col = col.curva)
      }
      if (linhas != 0) {
        if(is.null(lty)) {
          if (linhas == 2) meulty = c(1, 1, 2, 2)
          if (linhas == 1) meulty = c(1, 1)
        } else { meulty = lty }
        if(is.null(lwd)) { 
          if (linhas == 2) meulwd = c(2, 2, 2, 2)
          if (linhas == 1) meulwd = c(2, 2)
        } else { meulwd = lwd }
        if (linhas == 2) {
          abline(v = c(media, p50, media - dp, media + dp), 
                 col = c(col.media, col.mediana, col.dp, col.dp), 
                 lty = meulty, lwd = meulwd, ...)
        }
        if (linhas == 1) { 
          abline(v = c(media, p50), 
                 col = c(col.media, col.mediana), 
                 lty = meulty, lwd = meulwd, ...)
        }
      }
      if (densidade ==  T) {
        par(new=T)
        plot(density(x, na.rm=na.rm), lty = lty.dens, lwd=lwd.dens, 
             axes=F, main='', ylab='', xlab='', col=col.dens, ...)
      }
      if (legenda == T) {
        if(curva==T & linhas == 2 & densidade == T){
          legend(lugar,
                 legend = c("M\u00E9dia", "Mediana", "1 DP da m\u00E9dia", 'normalidade', 'densidade'),
                 col = c(col.media, col.mediana, col.dp, col.curva, col.dens),
                 lty = c(meulty[-4], lty.curva, lty.dens), 
                 lwd = c(meulwd[-4], lwd.curva, lwd.dens), 
                 cex = cex)
        }
        if(curva==T & linhas == 1 & densidade == T){
          legend(lugar,
                 legend = c("M\u00E9dia", 
                            "Mediana", 
                            'normalidade', 
                            'densidade'),
                 col = c(col.media, col.mediana, col.curva, col.dens),
                 lty = c(meulty, lty.curva, lty.dens), 
                 lwd = c(meulwd, lwd.curva, lwd.dens), 
                 cex = cex)
        }
        if(curva==T & linhas == 2 & densidade == F){
          legend(lugar,
                 legend = c("M\u00E9dia", 
                            "Mediana", 
                            "1 DP da m\u00E9dia", 
                            'normalidade'),
                 col = c(col.media, col.mediana, col.dp, col.curva),
                 lty = c(meulty[-4], lty.curva), 
                 lwd = c(meulwd[-4], lwd.curva), 
                 cex = cex)
        }
        if(curva==T & linhas == 1 & densidade == F){
          legend(lugar,
                 legend = c("M\u00E9dia", 
                            "Mediana", 
                            'normalidade'),
                 col = c(col.media, col.mediana, col.curva),
                 lty = c(meulty, lty.curva), 
                 lwd = c(meulwd, lwd.curva), 
                 cex = cex)
        }
        if(curva==T & linhas == 0 & densidade == T){
          legend(lugar,
                 legend = c('normalidade', 
                            'densidade'),
                 col = c(col.curva, col.dens),
                 lty = c(lty.curva, lty.dens),
                 lwd = c(lwd.curva, lwd.dens),
                 cex = cex)
        }
        if(curva==T & linhas == 0 & densidade == F){
          legend(lugar, 
                 legend = c('normalidade'),
                 col = col.curva,
                 lty = lty.curva,
                 lwd = lwd.curva,
                 cex = cex
          )
        }
        if(curva==F & linhas == 2 & densidade == F){
          legend(lugar,
                 legend = c("M\u00E9dia", 
                            "Mediana", 
                            "1 DP da m\u00E9dia"),
                 col = c(col.media, col.mediana, col.dp),
                 lty = meulty, lwd = meulwd, cex = cex)
        }
        if(curva==F & linhas == 1 & densidade == F){
          legend(lugar,
                 legend = c("M\u00E9dia", "Mediana"),
                 col = c(col.media, col.mediana),
                 lwd = meulwd, cex = cex)
        }
      }
    }
    return(descr)
  }
