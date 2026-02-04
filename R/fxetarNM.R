#' Faixa etária nas categorias de Nelson de Moraes
#'
#' @aliases fxetarNM
#'
#' @description Recodifica vetores com a idade em números inteiros ou em faixas etárias quinquenais em três grandes faixas etárias: 0-14, 15-59 e 60 e + anos.
#'
#' @param idade Vetor numérico representando a idade em valores contínuos ou inteiros.
#' @param fxetardet Vetor da classe \code{factor} ou \code{character} com diferentes categorizações de faixa etária disponíveis para tabulação no TABNET ("faixa etária detalhada", e outras formas com detalhamento de < 1 ano, 1 a 4 anos e faixas quinquenais ou decenais que permitem o cálculo )  representando 17 faixas etárias quinquenais, rotuladas conforme o resultado da função \code{csapAIH::fxetar_quinq} (números separados por hífen, sem espaços: "0-4", ..., "75-79", "80 e +").
#' @param grafico Vetor lógico, FALSE por padrão. Se TRUE, desenha o gráfico da curva.
#' @param ... Permite a definição de outros parâmetros gráficos.
#'
#' @returns \emph{Se fornecida a idade}, devolve um fator com as frequências observada em cada faixa etária; \emph{se fornecida a faixa etária}, devolve um vetor da classe caractere com as frequências de cada faixa etária; \emph{se não são fornecidas nem a idade nem a faixa etária} -- com `fxetarNM()` --, a função devolve um vetor com os nomes das faixas etárias.
#'
#' @examples
#' # Apenas citar os grupos:
#' fxetarNM()
#'
#' # Observar a curva na amostra de óbitos no RS em 2019:
#' ## a idade já foi computada, com a função \code{idadeSUS}, do pacote \code{csapAIH}, com
#' ## csapAIH::idadeSUS(obitosRS2019, sis = "SIM")
#' ## Computar as faixas etárias de Nelson de Moraes
#' fxetarNM(obitosRS2019$idade) |> table()
#' 
#' ## Desenhar a curva (podem-se usar os parâmetros gráficos)
#' fxetarNM(obitosRS2019$idade, grafico = TRUE, 
#'          col.sub = 4, font.sub = 3, cex.sub = .8, cex.main = .95,
#'          main = "Curva de Nelson de Moraes. RS, 2019.", 
#'          sub = "\nAmostra aleatória de 10.000 óbitos.")
#' 
#' 
#' # ## Tabela do TABNET
#' # Os óbitos de residentes do RS em 2021 por faixa etária detalhada podem ser tabulados no TABNET, 
#' # em http://tabnet.datasus.gov.br/cgi/deftohtm.exe?sim/cnv/obt10rs.def, resultando (em 21/05/2023) 
#' # na seguinte tabela (http://tabnet.datasus.gov.br/cgi/tabcgi.exe?sim/cnv/obt10rs.def) 
#' obitosRS2021 <- data.frame(
#'   fxetar = c("0 a 6 dias", "7 a 27 dias", "28 a 364 dias", "1 a 4 anos", "5 a 9 anos", 
#'              "10 a 14 anos", "15 a 19 anos", "20 a 24 anos", "25 a 29 anos", "30 a 34 anos", 
#'              "35 a 39 anos", "40 a 44 anos", "45 a 49 anos", "50 a 54 anos", "55 a 59 anos", 
#'              "60 a 64 anos", "65 a 69 anos", "70 a 74 anos", "75 a 79 anos", "80 anos e mais", 
#'              "Idade ignorada"),
#'   casos = c(623, 267, 304, 232, 110, 151, 603, 1088, 1273, 1716, 2379, 3144, 4195, 5665, 8437, 
#'             10799, 12937, 14173, 13950, 35610, 66)
#' )
#' # Se no TABNET a tabela for salva com a opção "copia como CSV", e depois salva em formato .xlsx, 
#' # poderia ser lida com o comando
#' \dontrun{
#'   obitosRS <- readxl::read_excel("~/Downloads/teste-fxetardet.xlsx", range = "A4:B25")
#' }  
#' # Com essa tabela, os seguintes comandos desenham a curva de Nelson de Moraes:
#' xtabs(casos/sum(casos)*100 ~ fxetarNM(fxetardet = obitosRS2021$fxetar), data = obitosRS2021) |>
#' plot(type = 'l', main = "Curva de Nelson de Moraes.\nRio Grande do Sul, 2021.", 
#' xlab = "Faixa etária (anos)", ylab = "% dos óbitos")
#' 
#' @export

fxetarNM <- function(idade = NULL, fxetardet = NULL, grafico = FALSE, ...) {
  rotulos <- c("< 1", "1-4", "5-19", "20-49", "50 e +")
  if(is.null(idade) & is.null(fxetardet)) {
    return(rotulos)
  }

  if(!is.null(idade)) {
    fxetarNM <- cut(idade, c(0, 1, 5, 20, 50, Inf),
                    labels = rotulos,
                    right = FALSE)
  }
  if(!is.null(fxetardet)){
    if(!is.character(fxetardet)) {fxetardet <- as.character(fxetardet)}
    fxetarNM <- dplyr::case_when(fxetardet %in% "Idade ignorada" ~ NA,
                                 fxetardet %in% c("0 a 6 dias",
                                                  "7 a 27 dias",
                                                  "28 a 364 dias",
                                                  "Menor 1 ano (ign)",
                                                  "Menor 1 ano") ~ "< 1",
                                 fxetardet %in%    "1 a 4 anos" ~ "1-4",
                                 fxetardet %in%  c("5 a 9 anos", "10 a 14 anos", "15 a 19 anos")  ~ "5-19",
                                 fxetardet  %in% c("20 a 24 anos",
                                                   "25 a 29 anos",
                                                   "30 a 34 anos",
                                                   "35 a 39 anos",
                                                   "40 a 44 anos",
                                                   "45 a 49 anos",
                                                   "20 a 29 anos",
                                                   "30 a 39 anos",
                                                   "40 a 49 anos") ~ "20-49",
                                 fxetardet >= "50 a 54 anos" ~ "50 e +",
                                 TRUE ~ fxetardet) |>
      factor(levels = rotulos)
  }
  if(isTRUE(grafico)) {
    plot(prop.table(table(fxetarNM))*100,
         type = 'l', ylab = "\u0025", xlab = "faixa et\u00e1ria", 
         ...) 
  }
  fxetarNM
}
