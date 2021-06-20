#' @title Apresenta uma tabela n x 2
#' @description Apresenta uma tabela n x 2
#' @param independente Variavel independente
#' @param dependente Variavel dependente
#' @param dec no. de decimais
#' @param nomes nomes para as filas e colunas
#' @param p.value ?????????????
#' @export
tango <-
function(independente, dependente, dec=2, 
         nomes = c(substitute(independente), substitute(dependente)),
         p.value = trend)
{
x <- table(independente, dependente, dnn=nomes)
px <- prop.table(table(independente,dependente),1)
rp1 <- px[1]/px[3]
se.log.rp1 <- sqrt((x[4]/x[1]) / (x[1]+x[4]) + (x[6]/x[3]) / (x[3]+x[6]))
icinf.rp1 <- exp(log(rp1) - 1.96 * se.log.rp1)
icsup.rp1 <- exp(log(rp1) + 1.96 * se.log.rp1)
rp2 <- px[2]/px[3]
se.log.rp2 <- sqrt((x[5]/x[2]) / (x[2]+x[5]) + (x[6]/x[3]) / (x[3]+x[6]))
icinf.rp2 <- exp(log(rp2) - 1.96 * se.log.rp2)
icsup.rp2 <- exp(log(rp2) + 1.96 * se.log.rp2)
odds1 <- px[1]/px[4]
odds2 <- px[2]/px[5]
oddsref <- px[3]/px[6]
or1 <- odds1/oddsref
se.log.or1 <- sqrt(1 / x[1]+1 / x[4]+1 / x[3]+1 /x[6])
icinf.or1 <- exp(log(or1) - 1.96 * se.log.or1)
icsup.or1 <- exp(log(or1) + 1.96 * se.log.or1)
or2 <- odds2/oddsref
se.log.or2 <- sqrt(1 / x[2]+1 / x[5]+1 / x[3]+1 /x[6])
icinf.or2 <- exp(log(or2) - 1.96 * se.log.or2)
icsup.or2 <- exp(log(or2) + 1.96 * se.log.or2)
fisher <- fisher.test(x, ,workspace=2e+07,hybrid=TRUE)$p.value
trend <- prop.trend.test(x[,1], table(independente))$p.value

cat("-----------------------------------------------------------------\n",
    "n\u00EDvel\t    \t\t  RP\t    IC95\u0025\t     OR \t  IC95\u0025     p(chi trend)", 
    "\n-----------------------------------------------------------------\n",
    names(as.data.frame(x)[1]), "                                          ",
    ifelse(p.value>=.001, round(p.value, 3), "<0,001"), "\n",
    "", row.names(x)[1], "  ", formatC(rp1, format="f", digits=dec), "",
                               formatC(icinf.rp1, format="f", digits=dec), "-",
                               formatC(icsup.rp1, format="f", digits=dec), "\t",
                               formatC(or1, format="f", digits=dec), "",
                               formatC(icinf.or1, format="f", digits=dec), "-",
                               formatC(icsup.or1, format="f", digits=dec), "\n",
    "", row.names(x)[2], "\t  ", formatC(rp2, format="f", digits=dec), "",
                               formatC(icinf.rp2, format="f", digits=dec), "-",
                               formatC(icsup.rp2, format="f", digits=dec), "\t",
                               formatC(or2, format="f", digits=dec), "",
                               formatC(icinf.or2, format="f", digits=dec), "-",
                               formatC(icsup.or2, format="f", digits=dec), "\n",
    "", row.names(x)[3], "  ", "1", "   refer\u00EAncia", "\t", " 1", "   refer\u00eancia",
    "\n-----------------------------------------------------------------\n")
}
