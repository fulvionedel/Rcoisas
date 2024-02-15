#' @title Totais de colunas em uma tabela
#' @aliases adissoma
#' 
#' @description Em uma tabela, acrescenta uma linha com o total das colunas, ou soma dos valores das colunas em linhas selecionadas.
#' 
#' @param tabela Objeto de estrutura matricial de no mínimo duas linhas e duas colunas
#' @param rotulo Rótulo para a linha da soma, o padrão é "Total".
#' 
#' @returns A tabela (de classe \code{data.frame}) com a linha da soma ao final.
#' 
#' @examples
#' tabela <- "'Faixa Etária det'	Masc	 Fem Ign	Total
#'                  '0 a 6 dias'   361   257   5   623
#'                 '7 a 27 dias'   156   111   -   267
#'               '28 a 364 dias'   155   148   1   304
#'                  '1 a 4 anos'   144    88   -   232
#'                  '5 a 9 anos'    64    46   -   110
#'                '10 a 14 anos'    83    68   -   151
#'                '15 a 19 anos'   462   141   -   603
#'                '20 a 24 anos'   817   271   -  1088
#'                '25 a 29 anos'   880   393   -  1273
#'                '30 a 34 anos'  1155   561   -  1716
#'                '35 a 39 anos'  1508   870   1  2379
#'                '40 a 44 anos'  1954  1190   -  3144
#'                '45 a 49 anos'  2514  1681   -  4195
#'                '50 a 54 anos'  3488  2175   2  5665
#'                '55 a 59 anos'  5170  3265   2  8437
#'                '60 a 64 anos'  6557  4240   2 10799
#'                '65 a 69 anos'  7566  5370   1 12937
#'                '70 a 74 anos'  7989  6181   3 14173
#'                '75 a 79 anos'  7438  6508   4 13950
#'              '80 anos e mais' 14444 21159   7 35610"
#' tabela <- read.table(header = TRUE, na.strings = "-", text = tabela)
#' adissoma(tabela)
#' 
#' rbind(adissoma(tabela[1:4,], rotulo = "0 a 4 anos")[5,],
#'       tabela[-c(1:4),]
#'       ) |>
#'   adissoma()
# 
# x <- xtabs(~ fxetar.det + sexo, obitosRS2019) 
# x
# x |>
#   unclass() |>
#   # tidyr::as_tibble() |>
#   data.frame() #|>
#   adissoma()
# 
# class(x)
#' 
#' @importFrom dplyr across bind_rows summarise where
#' 
#' @export
#' 
adissoma <- function(tabela, rotulo = "Total") {
  x <- bind_rows(tabela,
            summarise(tabela, across(where(is.numeric), sum, na.rm = TRUE),
                      across(where(is.character), ~ rotulo),
                      across(where(is.factor), ~ rotulo)))
  row.names(x) <- NULL
  x
}

fxetarinf <- function(x) {
  # Dicionário de variáveis em  https://ccvisat.ufba.br/wp-content/uploads/2019/10/Estrutura-do-SIM-para-o-CD-ROM.pdf
  tempo <- substr(x, 1, 1)
  idade <- as.numeric(substr(x, 2, 3))
  idade <- ifelse(as.numeric(x) <= 206, 1, 
                  ifelse(tempo == 2 & idade < 28, 2,
                         ifelse((tempo == 2 & idade >= 28) | tempo == 3, 3, NA))) |>
    factor(labels = c("Neonatal precoce", "Neonatal tardia", "P\U00F3s neonatal"))
}
