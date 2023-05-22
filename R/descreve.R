#' @title Descreve uma variável numérica
#' @aliases descreve
#' @description Executa a descrição "completa" de uma variável numérica, contínua ou discreta, e desenha um histograma, possivelmente com linhas para a média, mediana e distância da média até 1 ou 2 desvios-padrão, além da curva de probabilidade Normal para os parâmetros apresentados.
#' 
#' @param x Um vetor numérico
#' @param by tentar incluir esse argumento
#' @param dec Número de dígitos
#' @param na.rm TRUE (default) remove os missings
#' @param data Argumento opcional. Banco de dados contendo \code{x}. O padrão é NULL.
#' @param histograma TRUE (default) desenha um histograma
#' @param breaks Número de divisões, de acordo com \code{\link{hist}}; o método padrão é Sturges'
#' @param freq TRUE (default) define o eixo y como frequência; FAlSE o define como densidade
#' @param main Título do gráfico
#' @param xlab Rótulo do eixo x
#' @param ylab Rótulo do eixo y
#' @param linhas TRUE (default) desenha linhas verticais com a média, mediana e média + 1 ou 2 DP 
#' @param curva TRUE (default) desenha a curva normal esperada 
#' @param densidade O padrão é FALSE; passe para TRUE para desenhar a curva de densidade da distribuição
#' @param col.dens Cor da curva de densidade; o padrão é 'black'
#' @param col Cor das barras do histograma; o padrão é 'yellow2'
#' @param col.curva Cor da curva normal; o padrão é 'DarkGreen'
#' @param col.media Cor da linha da média; o padrão é 'red'
#' @param col.dp Cor das linhas do SP; por padrão é a mesma que col.media ('red')
#' @param col.mediana Cor da linha da mediana; o padrão é 'blue' 
#' @param legenda TRUE (default) desenha a legenda
#' @param lty.curva Tipo da linha da curva normal; padrão é 2
#' @param lwd.curva Largura da linha da curva normal; padrão é 1
#' @param lty.dens Tipo da linha da curva de densidade; padrão é 3
#' @param lwd.dens Largura da linha da curva de densidade; padrão é 2
#' @param lty Tipo da linha para o histograma; padrão é NULL
#' @param lwd Largura da linha para o histograma; padrão é NULL
#' @param cex Tamanho da fonte
#' @param lugar Posição da legenda; padrão é 'toprigt'
#' @param print Modo de apresentação; \code{print = "tabela"} retorna uma tabela com as estatísticas
#' @param ... Toma parâmetros de outras funções utilizadas
#' 
#' @seealso \code{\link{hist}} and \code{\link{par}} para os parâmetros gráficos
#' 
#' @examples 
#' banco <- data.frame(idade = runif(100))
#' descreve(rnorm(100))
#' descreve(rnorm(100), breaks = 'Scott')
#' descreve(rnorm(100), linhas = FALSE, densidade = TRUE, col = 'skyblue') 
#' descreve(rnorm(100), print = "tabela")
#' 
#'  
descreve <- function(x, print = "output", ...) {
  UseMethod("print.descreve")
}
#' 
#' 
#' @importFrom e1071 skewness kurtosis
#' @import graphics stats 
#' 
#' @export

descreve <- function (x, by = NULL, dec = 2, na.rm = TRUE, data = NULL, histograma = TRUE, breaks='Sturges', freq = TRUE , main = NULL, xlab = NULL, ylab= NULL, linhas=2, curva=TRUE, densidade=FALSE, col.dens=1, col='yellow2', col.curva='DarkGreen', col.media=2, col.dp=col.media, col.mediana=4, legenda = TRUE, lugar='topright', lty.curva = 2, lwd.curva = 1, lty.dens = 3, lwd.dens = 2, lty = NULL, lwd = NULL, cex = NULL, print = "output", ...) 
  {
  # nuntius errorum
  # ---------------
    if(!is.null(by)) {
      if(!is.factor(by)) { 
        stop("by deve ser da classe factor") 
      }
    }
    recipiens <- deparse(substitute(x))
    if ( !is.null(data) ) {
      x <- data[,deparse(substitute(x))]
      # by <- data[,deparse(substitute(by))]
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
    descr <- list(variavel = recipiens,
                  n = n, validos = val, miss = miss, p.miss = p.miss, 
                  menor = menor, maior = maior, amplitude = amplitude,
                  soma = soma, media = media, variancia = vari, dp = dp, cv = cv, 
                  assimetria = assimetria, curtose = curtose, 
                  quantis = quantis, iiq = iiq)
# 
    # class(descr) <- append(class(descr), 'descreve')
    
    
    ############################
    # O GRÁFICO
    ###########################
    if (histograma == T) {
      if(is.null(main)){
        titulo <- paste("Histograma de\n", recipiens)
      } else
        titulo <- main
      if(is.null(xlab)){
        x.lab <- recipiens
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

    
###############################################################################
# by()
###############################################################################
    if(!is.null(by)) {
      ncats <- nlevels(by)
      linhas = 1
      colunas = ncats
      div = 2
      if(ncats > 3) {
        linhas = ncats/div
        colunas = ncats/2
      }
      par(mfrow = c(linhas, colunas))
      # descr <- vector(mode='list', length=ncats)
      descr <- NULL
      for(i in 1:ncats) {
        titulo <- paste(deparse(substitute(x)), "em\n",
                        deparse(substitute(by)), "==", levels(by)[i])
        descr[[i]] <- descreve(x[by == levels(by)[i]],
                               main = titulo,
                               xlab = deparse(substitute(x)), 
                               col = col,
                               ...)
        descr[[i]]$variavel <- levels(by)[i]
      }
    }
###############################################################################
    
    class(descr) <- append(class(descr), 'descreve')
    
    if(print == "tabela") {
      # if(is.null(by)) 
        print.descreve(descr, print = "tabela")
      # else if(!is.null(by)) {
      #   for(i in 1:ncats) {
      #     cbind(print.descreve(descr[i], print = 'tabela'))
      #   }
      # }
    } else if(print == FALSE) {
      invisible(unclass(descr))
    } else if(print == "output") {
      print.descreve(descr, print = "output")
      invisible(descr)
    }
}
