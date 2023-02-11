#' Pirâmides populacionais 
#' @aliases ggplot_pir
#' 
#' @import ggplot2
#' @importFrom dplyr %>% group_by summarise
#' 
#' @param banco Um \code{data frame} com população ou casos por sexo e faixa etária.
#' @param idade Nome da variável com a idade ou faixa etária.
#' @param sexo Nome da variável com o sexo; deve ser um \code{factor}.
#' @param populacao Nome da variável com a população ou casos, se houver; por padrão é \code{NULL}, isto é, a função espera um banco de registros individuais e calcula a frequência por sexo e faixa etária indicada.
#' @param catsexo Vetor com o nome das categorias da variável sexo; padrão é \code{c("masc", "fem")}; o sexo masculino deve ser a primeira categoria.
#' @param cores Cores das barras, para as categorias masculino e feminino. O padrão é \code{c("darkblue", "violetred")}.
#' @param nsize Tamanho do texto com o nº total de habitantes. O padrão é 3.5.
#' 
#' @examples 
#' data("POPBR12")
#' str(POPBR12)
#' # "SEXO" é da classe 'integer'; 
#' # além disso, os primeiros 19 anos de idade estão em faixas anuais 
#' # e os demais (até 80) em faixas quinquenais.
#' \dontrun{
#' ggplot_pir(POPBR12, "FXETARIA", "SEXO", "POPULACAO")
#' }
#' # não dá o gráfico desejado.
#' 
#' # Transformando o sexo em fator e reclassificando a faixa etária:
#' require(dplyr)
#' POPBR12 <- POPBR12 %>% 
#'   mutate(SEXO = factor(SEXO, labels = c("masc", "fem")),
#'          FXETAR5 = fxetar.det_pra_fxetar5(FXETARIA)) 
#' ggplot_pir(POPBR12, "FXETAR5", "SEXO", "POPULACAO")
#' 
#' # Cerro Largo, RS
#' ggplot_pir(POPBR12[POPBR12$MUNIC_RES==430520, ], 
#'            "FXETAR5", "SEXO", "POPULACAO")
#' 
#' 
#' ## Mortalidade por anos completos de vida
#' 
#' Se o banco é de registros individuais, sem uma variável com a 
#' contagem da população, a função conta as frequências em cada 
#' sexo e faixa etária específicos. 
#' 
#' data("obitosRS2019")
#' str(obitosRS2019)
#' 
#' obitosRS2019 %>%
#'  mutate(sexo = factor(sexo, levels = c("masc", "fem"))) %>% 
#'  ggplot_pir("idade", "sexo")
#'  
#' O comando acima devolve o mesmo gráfico que o comando abaixo: 
#' 
#' obitosRS2019 %>%
#'  mutate(sexo = factor(sexo, levels = c("masc", "fem"))) %>%
#'  count(idade, sexo) %>% # linha desnecessária
#'  ggplot_pir("idade", "sexo", "n")
#' 
#' @export
#' 
ggplot_pir <- function(banco, idade, sexo, populacao = NULL, catsexo = c("masc", "fem"), cores = c("steelblue", "hotpink"), nsize = 3.5) {
  prop <- NULL
  if(is.null(populacao)) {
    graf <- ggplot(banco, aes(x = .data[[idade]], fill = .data[[sexo]])) +
      geom_bar(data = subset(banco, sexo == catsexo[1]), aes(y = after_stat(prop)*(-1))) +
      geom_bar(data = subset(banco, sexo == catsexo[2]), aes(y=after_stat(prop)))  
    nmasc <- table(banco[[sexo]] == catsexo[1])['TRUE']
    nfem  <- table(banco[[sexo]] == catsexo[2])['TRUE']
  } 
  if(!is.null(populacao)) {
    graf <- ggplot(banco, 
                   aes(x = .data[[idade]],
                       y = ifelse(.data[[sexo]] == catsexo[1],  
                                  -(.data[[populacao]]/sum(.data[[populacao]])*100),
                                  .data[[populacao]]/sum(.data[[populacao]])*100),
                       fill = .data[[sexo]])) +
      geom_col()
    n <- banco %>% 
      group_by(.data[[sexo]]) %>% 
      summarise(n = sum(.data[[populacao]]))
    nmasc <- as.numeric(n[1, 2])
    nfem  <- as.numeric(n[2, 2])
  }
  ggnmasc <- ggpp::geom_text_npc(aes(npcx = .98, npcy = 0.05,
                               label = paste("N =",
                                             suppressWarnings(
                                               formatC(nmasc, format = "fg", big.mark = ".")))),
                           col = cores[1], size = nsize)
  ggnfem <- ggpp::geom_text_npc(aes(npcx = 0.98, npcy = 0.95,
                              label = paste("N =",
                                            suppressWarnings(
                                              formatC(nfem, format = "fg", big.mark = ".")))),
                          col = cores[2], size = nsize)
  graf <- graf +
    ylab(NULL) +
    coord_flip() +
    theme(legend.position = "bottom") +
    scale_fill_manual(values = cores) +
    ggnmasc +
    ggnfem
  if(is.null(populacao)) {
    graf <- graf +
      lemon::scale_y_symmetric(labels = function (x) paste(abs(x)*100,"%"))
  } else {
    graf <- graf +
      lemon::scale_y_symmetric(labels = function (x) paste(abs(x),"%")) 
  }
  graf
}
