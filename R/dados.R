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
#' @format Banco de dados com amostra aleatória de 10.000 DO de 2019 de residentes do RS, registrados no Sistema de Informação de Mortalidade (SIM). O banco foi previamente trabalhado para a decodificação da idade, de modo que a idade represente a idade em anos completos (0 para < 1 ano), e para a definição de missings e rótulos no campo sexo.
#' @source Sistema de Informações sobre Mortalidade (SIM)
"obitosRS2019"

#' População brasileira, 2012
#' 
#' População por sexo e faixa etária. Municípios brasileiros, 2012.
#' 
#' @format Banco de dados com estimativas populacionais por sexo e faixa etária para os municípios brasileiros em 2012. Salvo engano que espero ser corrigido, é o último arquivo com estimativas populacionais a esse nível de detalhamento publicado no repositório FTP do DATASUS. O banco é apresentado na forma em que foi baixado de ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/POPBR12.zip. 
"POPBR12"

#' População por sexo e faixa etária. Municípios gaúchos, 2019.
#' 
#' @format Banco de dados com estimativas populacionais por sexo e faixa etária para os municípios do Rio Grande do Sul em 2019. Criado com a função \code{\link[csapAIH]{popbr2000_2021}}, que por sua vez usa os dados tabulados do DATASUS e importados pelo pacote \code{brpop}, de Raphael Saldanha. 
"POPRS2019"
