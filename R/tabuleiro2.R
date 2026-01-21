#' @title Tabela de frequências univariada
#' @aliases tabuleiro2
#' 
#' @description Constrói uma tabela com distribuição de frequências brutas, relativas e acumuladas, semelhante às do SPSS, com separadores latinos.
#' 
#' @param varcat Uma variável categórica
#' @param digits No. de decimais
#' 
#' @examples 
#' # criar uma variável politômica
#' x <- cut(rnorm(1000), 3) # sem missings
#' tabuleiro2(x)
#' x[1:100] <- NA # gerar missings
#' tabuleiro2(x)
#' 
#' \dontrun{
#' knitr::kable(tabuleiro2(x), align = rep("r", 4))
#' }
#' 
#' @export
#' 
tabuleiro2 <- function (varcat, digits = 1) 
{
    xsna <- table(varcat) # validos
    xcna <- table(varcat, useNA = "ifany")
    pcna <- prop.table(xcna)*100
    pval <- prop.table(xsna)*100
    pval.form <- suppressWarnings(formatC(pval, digits, format = "f", decimal.mark = ","))
    acum <- cumsum(pval)
    acum.form <- suppressWarnings(formatC(acum, digits, format = "f", decimal.mark = ","))
    acum.form[length(xsna)] <- "100"
    acum.form <- c(acum.form, rep(paste("\U002D7"), 3))
    
    tabela <- addmargins(cbind(xsna, 
                               pcna = pcna[1:length(xsna)]), 
                         margin = 1)
    Missing <- c(xcna[length(xcna)], pcna[length(pcna)])
    Total <- c(sum(xcna), sum(pcna))
    tabela <- rbind(tabela, Missing, Total)
    freq <- suppressWarnings(formatC(tabela[,1], format = "fg", big.mark = "."))
    tabela[,2] <- suppressWarnings(formatC(tabela[,2], digits, format = "f", decimal.mark = ","))
    tabela[length(tabela[,2]),2] <- "100"
    tabela[,1] <- freq
    pval.form <- c(pval.form, 100, rep("\U02D7", 2))
    tabela <- cbind(tabela, pval.form, acum.form)
    colnames(tabela) <- c("Freq", "\U0025(+NA)", "\U0025 v\U00e1lido", "\U0025 acum")
    
    if(length(xcna) != length(xsna)){
        rownames(tabela)[length(xcna)] <- "Total v\U00e1lidos"
        } else 
        if(length(xcna) == length(xsna)) {
            tabela <- tabela[c(1:length(xsna), length(tabela[,1])), -3]
        }
    tabela[,1] <- formatC(tabela[,1])
    
    tabela
}
