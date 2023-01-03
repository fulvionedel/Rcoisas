NULL

#' Arquivos da AIH
#' 
#' Internações hospitalares pagas pelo SUS no RS em 2019.
#' 
#' @format Banco de dados com amostra aleatória de 10\% dos registros dos "arquivos reduzidos" (RD*.DBC) das Autorizações de Internação Hospitalar (AIH) pagas pelo SUS em hospitais do RS em 2019 ("ano de competência" = 2019). O banco é formado pela junção (adição de linhas) de cada um dos arquivos RDRS1901.DBC, ..., RDRS1912.DBC.
#' @source Bases de Dados do Sistema de Informações Hospitalares do SUS (BD-SIH/SUS)
"RDRS2019"

#' Registros de óbito
#' 
#' Declarações de óbito (DO) de residentes do RS, 2019.
#' 
#' @format Banco de dados com amostra aleatória de 10\% das DO de residentes do RS ocorridas em 2019, registrados no Sistema de Informação de Mortalidade (SIM). O banco foi previamente trabalhado para a decodificação da idade, de modo que a idade represente a idade em anos completos (0 para < 1 ano), e para a definição de missings e rótulos no campo sexo.
#' @source Sistema de Informações sobre Mortalidade (SIM)
"obitosRS2019"

#' População brasileira
#' 
#' População por sexo e faixa etária. Municípios brasileiros, 2012.
#' 
#' @format Banco de dados com estimativas populacionais por sexo e faixa etária para os municípios brasileiros em 2012. Salvo engano que espero ser corrigido, é o último arquivo com estimativas populacionais a esse nível de detalhamento publicado no repositório FTP do DATASUS. O banco é apresentado na forma em que foi baixado de ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/POPBR12.zip. 
"POPBR12"