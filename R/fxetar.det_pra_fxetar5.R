#' @title Transforma a "faixa etária detalhada" (DATASUS) em 17 faixas quinquenais.
#' @aliases fxetar.det_pra_fxetar5
#' @keywords DATASUS
#' 
#' @description Reclassifica as idades < 20 anos em faixas etárias quinquenais.
#' 
#' @param x Um vetor com a idade categorizada segundo: (1) os arquivos de população "POPBR??.DBF" (até o ano 2012) disponibilizados pelo DATASUS, ou (2) um \code{data.frame} com o resultado de uma tabulação com a opção "Faixa etária detalhada" no TABNET ou TabWin (v. detalhes)
#' @param tipo Argumento obrigatório indicando a origem dos dados, se um arquivo de população do DATASUS  ou uma tabulação do TABNET ou TabWin (\code{tipo = "tabela"}). O padrão é \code{tipo = "POPBR"}. V. detalhes.
#'   
#' @details
#' Os arquivos "POPBR??.DBF" têm a idade em anos completos até 19 anos, faixas quinquenais de 20-24 até 75-79 anos e 80 e + anos.   
#' A "faixa etária detalhada" é uma opção de tabulação dos dados de mortalidade nos aplicativos TABNET (https://datasus.saude.gov.br/informacoes-de-saude-tabnet/) e TabWin, do DATASUS. A idade é detalhada nos componentes da Taxa de Mortalidade Infantil, < 1 ano não especificado, 1-4 anos, faixas quinquenais dos 5 aos 79 anos e 80 e mais. Nas opções de tabulação on-line da "morbidade hospitalar", esses mesmos cortes são usados para a definição da "Faixa Etária 2".
#' 
#' @returns Se \code{tipo = "POPBR"}, um vetor da classe \code{character} com a idade categorizada em 17 faixas etárias: quinquenais de 0 a 79 anos e 80 e + anos de idade. Se \code{tipo = "tabela"}, uma tabela (de classe \code{data.frame}) com a "faixa etária detalhada" agregada nessas 17 faixas etárias.
#' 
#' @examples 
#' data("POPBR12")
#' str(POPBR12)
#' xtabs(POPULACAO ~ FXETARIA + SEXO, POPBR12)
#' POPBR12$FXETAR5 <- fxetar.det_pra_fxetar5(POPBR12$FXETARIA)
#' str(POPBR12)
#' xtabs(POPULACAO ~ FXETAR5 + SEXO, POPBR12)
#' # Um arquivo csv de uma tabulação da Declaração de Óbito no TABNET 
#' # (residentes no RS, 2021):
#' \dontrun{
#' df <- read.csv2("sim_cnv_obt10rs195350189_4_122_229.csv", 
#'                 skip = 3, nrows = 21, encoding = "latin1") |>
#'   dplyr::select(-Ign) |> 
#'   fxetar.det_pra_fxetar5(tipo = 'tabela')
#' }
#' # Os valores são os seguintes:
#' dors21 <- data.frame(
#'  fxetar.det = c("0 a 6 dias", "7 a 27 dias", "28 a 364 dias", "1 a 4 anos",
#'            "5 a 9 anos", "10 a 14 anos", "15 a 19 anos", "20 a 24 anos",	
#'            "25 a 29 anos", "30 a 34 anos", "35 a 39 anos", "40 a 44 anos",	
#'            "45 a 49 anos",	"50 a 54 anos",	"55 a 59 anos", "60 a 64 anos",	
#'            "65 a 69 anos", "70 a 74 anos", "75 a 79 anos", "80 anos e mais"), 
#'   masc = c(361, 156, 155, 144, 64, 83, 462, 817, 880, 1155, 1508, 1954, 2514,
#'            3488, 5170, 6557, 7566, 7989, 7438, 14444),
#'   fem = c(257, 111, 148, 88, 46, 68, 141, 271, 393, 561, 870, 1190, 1681, 
#'           2175, 3265, 4240, 5370, 6181, 6508, 21159))
#' dors21
#' fxetar.det_pra_fxetar5(dors21, tipo = "tabela")
#' 
#' dors21$total <- dors21$masc + dors21$fem
#' fxetar.det_pra_fxetar5(dors21, tipo = "tabela")
#' 
#' @importFrom dplyr case_when mutate %>% group_by across
#' @export
#'   
fxetar.det_pra_fxetar5 <- function(x, tipo = "POPBR") {
  if(tipo == "POPBR") {
    # temp <- levels(as.factor(x))
    if(!is.integer(x)) x <- as.integer(x)
    # if(temp[1] == "0"   &&
       # temp[2] == "101" &&
       # temp[3] == "202") {
      x <- case_when(x >=    0 & x <=  404 ~ "00-04",
                     x >=  505 & x <=  909 ~ "05-09",
                     x >= 1010 & x <= 1414 ~ "10-14",
                     x >= 1515 & x <= 1919 ~ "15-19",
                     x >= 8099 ~ "80e+",
                     TRUE ~ paste0(substr(x, 1,2), "-", substr(x, 3,4))
      )
    # }
  } else if (tipo == "tabela"){
    vars <- names(x)
    niveis <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80e+")
    fxetar5 <- NULL
    x <- x %>%
      dplyr::mutate(fxetar5 = case_when(stringr::str_detect(x[,1], "dias")
                                        ~ "0-4",
                                        x == "1 a 4 anos" ~ "0-4",
                                        x == "5 a 9 anos" ~ "05-9",
                                        x == "Idade ignorada" ~ NA,
                                        TRUE ~ x[,1]) |> factor(labels = niveis)
                    ) %>% 
      dplyr::group_by(fxetar5) %>% 
      summarise(dplyr::across(vars[-1], sum))
    x <- x[1:17,]
  }
  x
}

