#' Classificação do estado nutricional de adultos 
#' @aliases enutri 
#' 
#' @description
#' Classifica o estado nutricional da pessoa segundo valores do Índice de Massa Corporal (IMC), usando os pontos de corte propostos pela Organização Mundial da Saúde. Pode ser informado um vetor com valores do IMC ou um vetor com o peso (Kg) e outro com altura (m^2).
#' 
#' @return Um fator com as categorias "Baixo peso", "Eutrófico", "Sobrepeso" ou "Obesidade".
#' 
#' @param data Banco de dados com a(s) variável(is) 
#' @param peso Peso em Kg 
#' @param altura Altura em m
#' @param imc Índice de Massa Corporal 
#' 
#' @examples
#' data("hasdm") 
#' enutri(hasdm) |> 
#'   tabuleiro()
#' 
#' @export 
#' 
enutri <- function(data = NULL, peso, altura, imc = NULL) {
  if(!is.null(data)) {
    peso <- data$peso
    altura <- data$altura
  } else {
    peso <- {{peso}}
    altura <- {{altura}}
  }
  if(is.null(imc)) {
    imc <- peso/altura^2
  }
  enutri <- cut(imc, breaks = c(-Inf, 17, 18.5, 25, 30, Inf), right = FALSE,
                labels = c("Magreza", "Baixo peso", "Eutr\u00f3fico", "Sobrepeso", "Obesidade")
                )
  return(enutri)
}
