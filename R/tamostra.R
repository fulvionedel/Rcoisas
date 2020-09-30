#' @title Funcoes para calcular o tamanho de amostra
#' @name tamostra
#' @description Calcula o tamanho de amostra para estimar médias e proporções e para comparar duas proporções
#' @details Veja o caso de cada função específica
#' @aliases tamostra.zmedia
#' @aliases tamostra.tmedia
#' @aliases tamostra.prop
NULL

#' mensagem.erro
mensagem.erro = 
  gettext("You cannot dream about certainty, error must be greater than zero" )
#' mensagem.erro.prop
mensagem.erro.prop = 
  gettext("You cannot dream about certainty, neither ignore it, error must be greater than zero and less then 100\U0025" )
#' mensagem.alfa
mensagem.alfa = 
  gettext("You cannot dream about certainty, significance may not be 0, neither 100\U0025" )
#' 
#' @param dp desvio-padrão; argumento apenas nas estimações de média
#' @param erro erro aceitável, em valor absoluto nas estimações de média e em proporção (0 -- 1) ou em pontos percentuais (1 -- 100) nas estimações de proporção de uma medida na população; veja \code{detalhes}
#' @details Quando o valor de \code{erro} é menor que um, é entendido como proporção; quando maior ou igual a um, é entendido como pontos percentuais; \code{erro >= 100} retorna erro
#' @param perdas fator de correção para perdas, em proporção (default = 0)
#' @param alfa nível de significância, (1 - confiança); 0 < alfa < 1 (deve ser maior que zero e menor que um); default = 0,05
#' 
#' @title tamostra.zmedia
#' @description tamostra.zmedia Estimar médias com variância conhecida (teste Z)
#' @describeIn tamostra Estimar médias com variância conhecida (teste Z)
tamostra.zmedia <- function(dp, erro, alfa=.05, perdas=0) {
  if(erro <= 0) stop(mensagem.erro)
  if(alfa >= 1) stop(mensagem.alfa)
  if(alfa <= 0) stop(mensagem.alfa)
  
  z <- qnorm(alfa/2, lower.tail = F)
  n = (z^2 * dp^2) / erro^2
  return(ceiling(n + n*perdas))
}
#' 
#' @title tamostra.tmedia
#' @description tamostra.tmedia Estimar médias com variância desconhecida (teste t)
#' @param pop tamanho da população (default = 10000)
#' @details  ### Precisa esta linha? ###
#' @describeIn tamostra Estimar médias com variância desconhecida (teste t)
tamostra.tmedia <- function(dp, erro, pop=10000, alfa=.05, perdas=0) {
  if(erro <= 0) stop(mensagem.erro)
  if(erro >= 1) stop(mensagem.erro.prop)
  if(alfa >= 1) stop(mensagem.alfa)
  if(alfa <= 0) stop(mensagem.alfa)
  
  t <- qt(alfa/2, df = pop-1, lower.tail = F)
  n = (t^2 * dp^2) / erro^2
  return(
    cat('Tamanho de amostra para estimar uma m\U00e9dia (teste t)',
        '\n--------------------------------------------------',
        '\nDP: ', dp, '; ', pop-1, ' gl',
        '\nErro: ', erro,
        '\nalfa: ', alfa*100, "%",
        '\nn = ', ceiling(n + n*perdas),
        sep='')
  )
}
#' 
#' @title tamostra.prop
#' @description tamostra.prop Estimar proporções
#' @param prop proporção esperada
#' @details ### Precisa esta linha? ###
#' @describeIn tamostra Estimar proporções
tamostra.prop <- function(prop, erro, alfa=.05, perdas=0) {
  if(erro <= 0) stop(mensagem.erro)
  if(erro >= 100) stop(mensagem.erro.prop)
  if(alfa >= 1) stop(mensagem.alfa)
  if(alfa <= 0) stop(mensagem.alfa)
  
  if(erro < 1) errof = erro
  if(erro >= 1) errof = erro/100
  z <- qnorm(alfa/2)
  p <- prop ; q <- 1-p
  n = (z^2 * p * q) / errof^2
  return(ceiling(n + n*perdas))
}
#' 
#' 
#' @title tamostra.2prop
#' @description Comparar duas proporções
#' @describeIn tamostra Comparar duas proporções
#' @param beta probabilidade de erro tipo II (1-poder)
#' @param p1 proporção na população 1
#' @param p2 proporção na população 2
#' @details ### Precisa esta linha? ###
tamostra.2prop <- function(p1, p2, alfa = 0.05, beta = 0.2, perdas = 0){
  za = qnorm(alfa/2)
  zb = qnorm(beta)
  q1 = 1-p1
  q2 = 1-p2
  n = (za + zb)^2 * (p1*q1 + p2*q2) / (p1-p2)^2
  return(ceiling(n + n*perdas))
  
  return(n)
}
#' @export
#' @examples 
#' tamostra.zmedia(8,5)
#' tamostra.tmedia(8,5)
#' tamostra.prop(.3,.03)

