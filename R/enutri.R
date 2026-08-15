#' Classificação do estado nutricional de adultos 
#' @aliases enutri 
#' 
#' @description
#' Classifica o estado nutricional da pessoa segundo valores do Índice de Massa Corporal (IMC), usando os pontos de corte propostos pela Organização Mundial da Saúde. Pode ser informado um vetor com valores do IMC ou um vetor com o peso (Kg) e outro com altura (m^2).
#' 
#' @return Um fator com a classificação do IMC segundo as categorias definidas. 
#' 
#' @param data Banco de dados com a(s) variável(is). Argumento opcional.
#' @param peso Peso em Kg. Argumento obrigatório se não for informado o argumento \code{imc}.
#' @param altura Altura em metros (m). Argumento obrigatório se não for informado o argumento \code{imc}.
#' @param imc Índice de Massa Corporal. Argumento obrigatório se não forem informados os argumentos \code{peso} e \code{altura}.
#' @param cortes Categorias (pontos de corte) do estado nutricional. 
#'   - "\code{MS}" (padrão) utiliza as definidas pelo Ministério da Saúde brasileiro (Abaixo do peso", Eutrófico, Sobrepeso, Obesidade grau I, Obesidade grau II e Obesidade grau III);  
#'   - "\code{OMS}" utiliza as definidas pela Organização mundial da Saúde (Magreza, Baixo peso, Eutrófico, Sobrepeso e Obesidade); 
#'   - "\code{3cat}" agrupa o peso baixo e o eutrófico em peso normal e identifica o sobrepeso e obesidade.
#' @param idoso Argumento lógico. Adaptar a definição de eutrofia para idoso? O padrão é \code{FALSE}. 
#' 
#' @examples
#' data("hasdm") 
#' enutri(hasdm) |> 
#'   tabuleiro()
#' hasdm |> 
#'   enutri(cortes = "OMS") |> 
#'    tabuleiro()
#' enutri(hasdm, idoso = TRUE) |> 
#'    tabuleiro()
#'  
#' @export 
#' 
enutri <- function(data = NULL, peso, altura, imc = NULL, cortes = "MS", idoso = FALSE) {
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
  if(cortes == "MS") {
    cortes <- c(-Inf, 18.5, 25, 30, 35, 40, Inf)
    if(isTRUE(idoso)) {
      cortes[2] <- 22
      cortes[3] <- 27 
    }
    rotulos <- c("Abaixo do peso", "Eutr\u00f3fico", "Sobrepeso", "Obesidade I", "Obesidade II", "Obesidade III")
  } else if(cortes == "OMS") {
    cortes <- c(-Inf, 17, 18.5, 25, 30, Inf)
    if(isTRUE(idoso)) {
      cortes[3] <- 22
      cortes[4] <- 27 
    }
    rotulos <- c("Magreza", "Baixo peso", "Eutr\u00f3fico", "Sobrepeso", "Obesidade")
  } else if(cortes == "3cat") {
    cortes <- c(-Inf, 25, 30, Inf)
    if(isTRUE(idoso)) { cortes[2] <- 27 }
    rotulos <- c("Peso normal", "Sobrepeso", "Obesidade")
  }
  
  enutri <- cut(imc, breaks = cortes, right = FALSE, labels = rotulos) 
  return(enutri)
}
