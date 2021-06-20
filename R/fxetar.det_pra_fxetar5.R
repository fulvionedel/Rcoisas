#' @title Transforma a "faixa etária detalhada" (DATASUS) em 17 faixas quinquenais.
#' @aliases fxetar.det_pra_fxetar5
#' 
#' @description Reclassifica as idades < 20 anos em faixas etárias quinquenais.
#' 
#' @param x Um vetor com a idade categorizada nas seguintes faixas etárias:
#'  \itemize{
#'    \item anos completos até 19 anos; 
#'    \item faixas quinquenais até 75-79 anos; e 
#'    \item 80 e + anos.
#'  }
#'   
#' @keywords DATASUS
#' 
#' @returns Um vetor com a idade categorizada em 17 faixas etárias: quinquenais de 0 a 79 anos e 80 e + anos de idade.
#' 
#' @details Falar das faixas etárias do tabnet e tabwin
#' 
#' @examples 
#' data("POPBR12")
#' str(POPBR12)
#' POPBR12$FXETAR5 <- fxetar.det_pra_fxetar5(POPBR12$FXETARIA)
#' str(POPBR12)
#' levels(POPBR12$FXETAR5)
#' 
#' @importFrom dplyr case_when
#' @export
#'   
fxetar.det_pra_fxetar5 <- function(x) {
  if(levels(as.factor(x))[1] == "0"   &&
     levels(as.factor(x))[2] == "101" &&
     levels(as.factor(x))[3] == "202") {
    x <- as.factor(
      case_when(x >=    0 & x <=  404 ~ "00-04",
                x >=  505 & x <=  909 ~ "05-09",
                x >= 1010 & x <= 1414 ~ "10-14",
                x >= 1515 & x <= 1919 ~ "15-19",
                x >= 8099 ~ "80e+",
                TRUE ~ paste0(substr(as.character(x), 1,2), 
                              "-", 
                              substr(as.character(x), 3,4))
                )
      )
    x
  }
}
