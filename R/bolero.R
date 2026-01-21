#' Bolero: tabelas 2x2
#' @description Analisa uma tabela 2x2 e apresenta um output com rótulos em português
#' @aliases bolero
#' 
#' @param independente Variável independente
#' @param dependente Variável dependente
#' @param dec No. de decimais
#' @param dnn Nome das variáveis a ser impresso no 'output'
#' 
#' @returns Um objeto da classe `list` com as tabelas de frequências absolutas e relativas, razão de probabilidades e de odds, com seus intervalos de confiança e valores-p.
#' 
#' @examples
#' with(RDRS2019, bolero(SEXO, MORTE))
#' with(RDRS2019, bolero(SEXO, MORTE, dnn = c("Sexo", "Óbito")))
#' 
#' @export
#' 
bolero <- 
function(independente, dependente = NULL, dec = 2, dnn = NULL) {
  if(is.null(dnn)) dnn = c(substitute(independente), substitute(dependente))
  
  if(is.table(independente)) { 
    tab <- independente
  } else {
    tab <- table(independente, dependente, dnn=dnn)
  }
  proptab <- round(prop.table(tab, 1)*100, dec-1)
  
  a <- tab[1,1]; b <- tab[1,2]; c <- tab[2,1]; d <- tab[2,2]
  rp <- (a/(a+b))/(c/(c+d))
  se.log.rp <- sqrt((b/a)/(a+b)+(d/c)/(c+d))
  lci.rp <- exp(log(rp) - 1.96 * se.log.rp)
  uci.rp <- exp(log(rp) + 1.96 * se.log.rp)
  or <- (a/b)/(c/d)
  ft <- stats::fisher.test(tab)
  qui <- stats::chisq.test(tab)
  varexp <- names(as.data.frame(tab))[1]
  vardesf <- names(as.data.frame(tab))[2]
  #### IC exato pra RP, pelo intervalo exato da Odds no teste de Fisher
  #### RP = OR/(1-Pne + Pne * OR)
  pne <- c / (c+d) # proporção nos não expostos
  rp.conf.int <- ft$conf.int/(1-pne + pne*ft$conf.int)
  missings <- length(independente) - sum(tab)
  propmiss <- missings/length(independente)*100
  cat("===============================================================\n")
  cat("                  Tabela 2 por 2"                            ,
      "\n        bolero(independente, dependente, dec=2, dnn)",
      "\n---------------------------------------------------------------", 
      "\nVar. dependente :", names(as.data.frame(tab))[2], "=", colnames(tab)[1], 
      "\nVar. independente:", names(as.data.frame(tab))[1], "=", rownames(tab)[1], "\n")
  cat("Missings: ", Rcoisas::formatL(missings, 0), " (", Rcoisas::formatL(propmiss), "\U0025)\n\n", sep = "")
  print(stats::addmargins(tab)) #, FUN=list(Total=sum)))
  cat('\nPropor\U00E7\u00F5es (%)\n')
  print(proptab)
  #cat("\n  Raz\U00E3o de Probabilidades:", formatC(rr, format="f", dig=dec), 
  #    "\n  IC95%                  :", formatC(c(lci.rr, uci.rr), format="f", dig=dec), "\n")
  #cat("\n  Raz\U00E3o de Odds          :", formatC(or, format="f", dig=dec), 
  #    "\n  IC95%  (exato)         :", formatC(ft$conf.int, format="f", dig=dec), '\n')
  #cat("\n  valor-p(Pearson)       :", ifelse(qui$p.value>=.001, round(qui$p.value, 3), "<0,001"),
  #    "\n  valor-p(Fisher)        :", ifelse(ft$p.value>=.001, round(ft$p.value, 3), "<0,001"), "\n")
  cat("\nRaz\U00E3o de Probabilidades:", formatC(rp, format="f", digits=dec), 
      "; IC95% (assint\U00F3tico):", formatC(c(lci.rp, uci.rp), format="f", digits=dec),
      "\n                                IC95\U0025 (exato)      :", formatC(rp.conf.int, format="f", digits=dec))
  cat("\nRaz\U00E3o de Odds          :", formatC(or, format="f", digits=dec), 
      "; IC95\U0025 (exato)      :", formatC(ft$conf.int, format="f", digits = dec))
  cat("\nValor-p: Pearson, Yates:", ifelse(qui$p.value>=.001, round(qui$p.value, 3), "<0,001"),
      "; Fisher:", ifelse(ft$p.value>=.001, round(ft$p.value, 3), "<0,001"), "\n")
  cat("===============================================================\n")
  
  resumo <- round(as.table(matrix( c(rp, lci.rp, uci.rp, ft$p.value), nrow = 1, dimnames = list(vardesf, c('RP','IC95inf', 'IC95sup', 'p')))), 3)
  resultados <- list(#exposicao=varindep, dependente=vardep, 
                     tab=tab, proptab=proptab, 
                     RP=rp, lci.rp=lci.rp, uci.rp=uci.rp, 
                     OR=or, or.ic=ft$conf.int, lci.or=ft$conf.int[1], uci.or=ft$conf.int[2], 
                     ft=ft, qui2=qui, p.qui2=qui$p.value, p.Fisher=ft$p.value,
                     resumo=resumo)
  #   return(resultados)
}


