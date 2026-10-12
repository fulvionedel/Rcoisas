#' Classificação do estado nutricional de adultos 
#' @aliases enutri 
#' 
#' @description
#' Classifica o estado nutricional da pessoa segundo valores do Índice de Massa Corporal (IMC), usando os pontos de corte propostos pela Organização Mundial da Saúde. Pode ser informado um vetor com valores do IMC ou um vetor com o peso (Kg) e outro com a altura (m\eqn{^2}).
#' 
#' @return Um fator com a classificação do IMC segundo as categorias definidas. 
#' 
#' @param data Banco de dados com a(s) variável(is). Argumento opcional.
#' @param peso Peso em Kg. Argumento obrigatório se não for informado o argumento \code{imc}.
#' @param altura Altura em metros (m). Argumento obrigatório se não for informado o argumento \code{imc}.
#' @param imc Índice de Massa Corporal. Argumento obrigatório se não forem informados os argumentos \code{peso} e \code{altura}.
#' @param cortes Categorias (pontos de corte) do estado nutricional. 
#'   - "\code{MS}" (padrão) utiliza as definidas pelo Ministério da Saúde brasileiro (Abaixo do peso, Eutrófico, Sobrepeso, Obesidade grau I, Obesidade grau II e Obesidade grau III);  
#'   - "\code{OMS}" utiliza as definidas pela Organização mundial da Saúde (Magreza, Baixo peso, Eutrófico, Sobrepeso e Obesidade); 
#'   - "\code{3cat}" agrupa o peso baixo e o eutrófico em peso normal e identifica o sobrepeso e obesidade.
#' @param idoso Argumento lógico. Adaptar a definição de eutrofia para idoso? O padrão é \code{FALSE};
#' @param idade Argumento opcional. Permite a classificação de adultos e idosos com a definição de eutrofia e sobrepeso específica para cada faixa etária, num banco de dados com a variável idade. Indicar entre aspas o nome da variável. Se definido, o argumento \code{idoso} é considerado \code{TRUE};
#' @param categorias Argumento válido apenas para a apresentação dos intervalos de classificação (pontos de corte do IMC) e rótulos das categorias, para cada classificação utilizada. Pode ser uma \code{"lista"} (padrão) ou uma \code{"matriz"} com duas colunas. Ver \emph{details} e \emph{examples}. 
#' 
#' @examples
#' data("hasdm") 
#' enutri(hasdm) |> 
#'   tabuleiro()
#' enutri(hasdm, cortes = "OMS") |> 
#'   tabuleiro()
#'   
#' # Se a população fosse toda idosa, poderíamos usar o argumento 'idoso = TRUE' 
#' # para uma classificação mais acurada.
#'  hasdm |> 
#'    enutri(idoso = TRUE) |> 
#'    tabuleiro()
#'    
#' # Entretanto, a mediana de idade da população está em 64 anos. Melhor usar o 
#' # argumento 'idade' para ajustar a classificação de acordo com o grupo etário.
#' hasdm |> 
#'   enutri(idade = "idade") |> 
#'   tabuleiro()
#' 
#' # Se a variável no banco tiver outro nome, digite-o entre aspas: 
#' names(hasdm)[3:5] <- c("age", "weight", "height")
#' hasdm |> 
#'   enutri('weight', 'height', idade = 'age') |> 
#'   tabuleiro()
#' 
#' # Só as categorias utilizadas: 
#' enutri() 
#' enutri(cortes = "OMS")
#' enutri(cortes = "3cat")
#' # Se a pessoa é idosa:
#' enutri(idoso = TRUE) 
#' # Apresentando numa matriz: 
#' enutri(cortes = "OMS", idoso = TRUE, categorias = "matriz")
#' 
#' @references 
#'  - Brasil, MS. [Linhas de cuidado: definição de obesidade no adulto.](https://linhasdecuidado.saude.gov.br/portal/obesidade-no-adulto/definicao-obesidade-no-adulto/)   
#'  - WHO Consultation on Obesity. Obesity: preventeng and managing the global epidemic: report of a WHO consultation. [WHO techical report series; 894. Geneva, 2000.](https://iris.who.int/bitstreams/72fe01f6-8c54-4a64-984e-7e20f4700b44/download) 
#'  
#' @export 
#' 
enutri <- function(data, peso = 'peso', altura = 'altura', imc = NULL, cortes = "MS", idoso = FALSE, idade = NULL, categorias = "lista") {

  # Cortes 
  # ----------
  if(cortes == "MS") {
    cortes <- cortesadulto <- c(-Inf, 18.5, 25, 30, 35, 40, Inf)
    if(isTRUE(idoso) | !is.null(idade)) {
      cortesidoso <- cortes
      cortesidoso[2] <- 22
      cortesidoso[3] <- 27 
      cortes <- cortesidoso
    }
    rotulos <- c("Abaixo do peso", "Eutr\u00f3fico", "Sobrepeso", "Obesidade I", "Obesidade II", "Obesidade III")
  } else if(cortes == "OMS") {
    cortes <- cortesadulto <- c(-Inf, 17, 18.5, 25, 30, Inf)
    if(isTRUE(idoso) | !is.null(idade)) {
      cortesidoso <- cortes
      cortesidoso[3] <- 22
      cortesidoso[4] <- 27
      cortes <- cortesidoso
    }
    rotulos <- c("Magreza", "Baixo peso", "Eutr\u00f3fico", "Sobrepeso", "Obesidade")
  } else if(cortes == "3cat") {
    cortes <- cortesadulto <- c(-Inf, 25, 30, Inf)
    if(isTRUE(idoso) | !is.null(idade)) {
      cortesidoso <- cortes
      cortesidoso[2] <- 27
      cortes <- cortesidoso
    }
    rotulos <- c("Sem sobrepeso", "Sobrepeso", "Obesidade")
  }
  
  if(missing(data) && missing(peso) && missing(altura) && missing(imc)) {
    cortes2 <- cortes[-1]
    cortes2[1] <- paste("<", cortes[[2]])
    cortes2[2] <- paste(cortes[[2]], "|-", cortes[[3]])
    if(length(cortes2) > 3) {
      cortes2[3:5] <- paste(cortes[3:5], "|-", cortes[4:6])      
    }
    cortes2[length(cortes2)] <- paste(">=", utils::tail(cortes, 2)[1])
    
    if(categorias == "matriz") {
      classifica <- matrix(cortes2, nrow = length(cortes2),
                           dimnames = list(Intervalo = rotulos, "Categoria"))
    } else {
      classifica <- list(intervalos = cortes2, rotulos = rotulos)
    }
    return(classifica)
  }
  
  if(missing(data)) { data <- NULL }
  if(!is.null(data)) {
    if(is.null(imc)) {
      if(!exists(peso, data)) { 
        stop(paste0('A vari\u00e1vel "', peso, '" n\u00e3o foi encontrada.'))
      }
      if(!exists(altura, data)) {
        stop(paste0('A vari\u00e1vel "', altura, '" n\u00e3o foi encontrada.'))
      }
      imc <- data[[peso]] / data[[altura]]^2
    } else {
      if(!exists(imc, data)) { 
        stop(paste0('A vari\u00e1vel "', imc, ' "n\u003o foi encontrada.'))
      } 
      imc <- data[[imc]]
    }
  } else {
    if(is.null(imc)) imc <- peso / altura^2 
    else imc <- imc 
    }

  # Classificar de segundo a idade - Lipschitz para idosos
  # ------------------------------------------------------
  if(!is.null(idade)) {
    enutri <- dplyr::if_else(data[[idade]] < 60, 
                             cut(imc, right = FALSE, 
                                 breaks = cortesadulto, 
                                 labels = rotulos), 
                             cut(imc, right = FALSE, 
                                 breaks = cortesidoso, 
                                 labels = rotulos))
  } else { 
    enutri <- cut(imc, breaks = cortes, right = FALSE, labels = rotulos) 
  }
  
  return(enutri)
}
