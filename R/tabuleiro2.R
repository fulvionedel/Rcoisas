#' Tabela de frequências semelhante ao output do SPSS
#' @aliases tabuleiro2
#' @param varcat Uma variável categórica
#' @param digits No. de decimais
#' 
#' @examples 
#' data("iris") 
#' varcat <- iris$Species
#' varcat[1:7] <- NA # criar missings
#' tabuleiro2(varcat)
#' 
#' @export
#' 
tabuleiro2 <- function (varcat, digits = 1) 
{
    x <- table(varcat) # validos
    y <- x/length(varcat) * 100 # com missings
    z <- prop.table(x) * 100    # validos
    w <- cumsum(z)
    tabela <- data.frame(cbind(x, y, z, w))
    colnames(tabela) <- c("Frec", "\U0025(+NA)", "\U0025 v\U00e1lido", "\U0025 acumulado")
    validos <- table(is.na(varcat))[["FALSE"]]
    pcval <- round(validos/length(varcat) * 100, digits)
    xx <- table(is.na(varcat)[is.na(varcat) == "TRUE"])
    yy <- round(xx/length(varcat) * 100, digits)
    tabela <- round(tabela, digits = rep(digits, 3))
    tabela <- rbind(tabela, 
                    tvalidos = c(validos, pcval, "100", "- "), 
                    Missing = c(xx, yy, "- ", "- "), 
                    Total = c(length(varcat), "100", "- ", "- "))
    rownames(tabela)[rownames(tabela) == "tvalidos"] <- "Total v\U00e1lidos"
    tabela
}
