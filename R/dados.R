NULL

#' Arquivo da AIH - RS, 2019
#' 
#' Internações hospitalares pagas pelo SUS no RS em 2019.
#' 
#' @format Banco de dados com amostra aleatória de 10.000 internações dos "arquivos reduzidos" (RD*.DBC) das Autorizações de Internação Hospitalar (AIH) pagas pelo SUS em hospitais do RS em 2019 ("ano de competência" = 2019). O banco é formado pela junção (adição de linhas) de cada um dos arquivos RDRS1901.DBC, ..., RDRS1912.DBC.
#' @source Bases de Dados do Sistema de Informações Hospitalares do SUS (BD-SIH/SUS)
"RDRS2019"

#' Registros de óbito
#' 
#' Amostra de Declarações de Óbito (DO) de residentes no RS, 2019.
#' 
#' @format Banco de dados com amostra aleatória de 10.000 DO de 2019 de residentes do RS, registrados no Sistema de Informação de Mortalidade (SIM). O banco foi previamente trabalhado para a decodificação da idade, de modo que a idade represente a idade em anos completos (0 para < 1 ano), e para a definição de missings e rótulos no campo sexo. Essas variáveis foram acrescentadas (com nome em letra minúscula, `idade` e `sexo`), sendo mantidas as originais (`IDADE`, `SEXO`).
#' @source Sistema de Informações sobre Mortalidade (SIM)
"obitosRS2019"

#' População brasileira, 2012
#' 
#' População por sexo e faixa etária. Municípios brasileiros, 2012.
#' 
#' @format Banco de dados com estimativas populacionais por sexo e faixa etária para os municípios brasileiros em 2012. É o último arquivo com estimativas populacionais a esse nível de detalhamento publicado no repositório FTP do DATASUS. O banco é apresentado na forma em que foi baixado de ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/POPBR12.zip. 
"POPBR12"

#' População por sexo e faixa etária. Municípios gaúchos, 2019.
#' 
#' @format Banco de dados com estimativas populacionais por sexo e faixa etária para os municípios do Rio Grande do Sul em 2019. Criado com a função \code{\link[csapAIH]{popbr2000_2021}}, que por sua vez usa os dados tabulados do DATASUS e importados pelo pacote \code{brpop}, de Raphael Saldanha. 
"POPRS2019"

#' População por sexo e faixa etária. Municípios gaúchos, 1980, 2010, 2020.
#' 
#' @format Banco de dados com estimativas populacionais por sexo e faixa etária para os municípios do Rio Grande do Sul em 1980, 2010 e 2020. Criado com as funções \code{\link[csapAIH]{ler_popbr}} \code{\link[csapAIH]{popbr2000_2021}}. 
"poprs"

#' Procedimentos Ambulatoriais do SUS
#' 
#' @format Banco de dados de exemplo de um arquivo "PA" do SIASUS. Contém uma amostra aleatória de 1.000 registros do arquivo "PASC2512.dbc" com os procedimentos do Acre no mês de competência 12/2025.
"PASC2512"

#' Usuários da APS com hipertensão ou diabete 
#' 
#' @details
#' ```{r}
#'  Rcoisas::hasdm |> names()
#'  ````
# Rcoisas::sacamostras(hasdm, 384, suffixes = 1)
# hasdm <- hasdm_amostra1
# attr(hasdm$nquest, which = "label") <- "n\U00BA do question\U00E1rio"
# attr(hasdm$peso, which = "label") <- "Peso informado"
# attr(hasdm$altura, which = "label") <- "Altura informada"
# attr(hasdm$has, which = "label") <- "O(A) Sr(a). usa rem\u00E9dio para press\U00E4o alta, ou algum m\u00E9dico j\U00E1 lhe disse que o(a) Sr(a). tem problema de press\U00E4o alta\U003F"
# attr(hasdm$dm, which = "label") <- "O(A) Sr(a). usa rem\u00E9dio para diabete ou a\U00E7\u00FAcar alto no sangue, ou algum m\u00E9dico já lhe disse que o(a) Sr(a). tem problema de diabete ou a\U00E7\u00FAcar alto no sangue\U003F"
# attr(hasdm$escola2, which = "label") <- "Nível de ensino"
# usethis::use_data(hasdm, overwrite = TRUE)
"hasdm"
