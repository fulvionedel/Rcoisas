#' Tabela de frequências semelhante ao SPSS
#' @aliases spss.tabela
#' @param varcat Uma variável categórica
#' @param digits No. de digits *(em \code{\link{round}}, mudar pra formatC*)
#' 
spss.tabela <-
structure(function (varcat, digits = 1) 
{
    x <- table(varcat)
    y <- round(prop.table(table(varcat)) * 100, digits = digits)
    z <- round(table(varcat)/length(varcat) * 100, digits = digits)
    w <- round(cumsum(prop.table(table(varcat)) * 100), digits = digits)
    tabela <- data.frame(cbind(x, y, z, w))
    colnames(tabela) <- c("Frec", "\U0025 ", "\U0025 v\U00e1lido", "\U0025 acumulado")
    validos <- table(is.na(varcat)[is.na(varcat) == "FALSE"])
    pcval <- round(validos/length(varcat) * 100, digits = digits)
    xx <- table(is.na(varcat)[is.na(varcat) == "TRUE"])
    yy <- round(xx/length(varcat) * 100, digits = digits)
    tabela <- rbind(tabela, 'Total v\U00e1lidos' = c(validos, pcval, 
        "100", "- "), Perdidos = c(xx, yy, "- ", "- "), Total = c(length(varcat), 
        "100", "- ", "- "))
    tabela
}, source = c("function(varcat, digits=1)", "{", "x <- table(varcat)", 
"y <- round(prop.table(table(varcat))*100, digits=digits) # \U0025 v\U00e1lido", 
"z <- round(table(varcat)/length(varcat)*100, digits=digits) # \U0025 incluye NA", 
"w <- round(cumsum(prop.table(table(varcat))*100), digits=digits) # \U0025 acumulado", 
"tabela <- data.frame(cbind(x, y, z, w))", "colnames(tabela) <- c(\"Frec\", \"\U0025 \", \"\U0025 v\U00e1lido\", \"\U0025 acumulado\")", 
"validos <- table(is.na(varcat)[is.na(varcat)==\"FALSE\"])", 
"pcval <- round(validos/length(varcat)*100, digits=digits)", 
"xx <- table(is.na(varcat)[is.na(varcat)==\"TRUE\"])", "yy <- round(xx/length(varcat)*100, digits=digits)", 
"tabela <- rbind(tabela,", "                \"Total v\U00e1lidos\"=c(validos, pcval, \"100\", \"- \"),", 
"                \"Perdidos\"=c(xx, yy, \"- \", \"- \"),", "                \"Total\"=c(length(varcat), \"100\", \"- \", \"- \"))", 
"tabela", "}"))
