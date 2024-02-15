#' Desenha um calendário
#'
#' Útil para visualizar cronogramas de aulas
#'
#' @param inicio Data em formato YYYYMMDD (em caractere ou numeral) com o primeiro dia de aulas.
#' @param fim Data em formato YYYYMMDD (em caractere ou numeral) com o último dia do calendário.
#' @param semanas Número de semanas letivas. Por padrão são 18.
#' @param diasem Dias da semana das aulas, abreviados e em minúsculas.
#' @param feriados Vetor com uma lista de datas para marcar feriados e dias não letivos.
#' @param lang Idioma para os dias da semana, "pt" (padrão) para português ou "es" para castelhano.
#' @param size Tamanho da letra do dia no gráfico.
#' @param coraula Cor de fundo para os dias de aula.
#' @param corfer Cor de fundo para os feriados e dias não letivos.
#' @param corfimde Cor de fundo para os fins-de-semana.
#' @param corNA Cor de fundo para o período não letivo.
#'
#' @returns Objeto ggplot2 com o desenho do calendário.
#'
#' @examples
#' folhinha(inicio = 20250305, diasem = c("seg", "qua", "sex"))
#' folhinha(inicio = 20250311, fim = 20250725, diasem = c("ter", "qui"))
#' folhinha(inicio = 20250304, sem = 15,
#'    feriados = c("20250418", "2025/05/01", "2025-06-19"),
#'    diasem = c("mar", "jue"), lang = "es",
#'    size = 2.5, coraula = "yellow", corfer = "tomato3", corfimde = "white")
#'
#' @export
#'
folhinha <- function(inicio, fim = NULL, semanas = 18, diasem, feriados = NULL, lang = "pt", size = 3, coraula = "steelblue", corfer = "antiquewhite1", corfimde = "antiquewhite2", corNA = "white") {
#
  inicio <- lubridate::ymd(inicio)
  mesini <- ifelse(lubridate::month(inicio) < 10,
                   paste0("0", lubridate::month(inicio)),
                   lubridate::month(inicio))
  inisem <- paste0(lubridate::year(inicio), mesini, "01") |> lubridate::ymd()
  if(!is.null(fim)) {
    fim    <- lubridate::ymd(fim)
  } else if(is.null(fim)) {
    fim <- inicio + 7*semanas
    fim <- lubridate::ymd(fim)
  }

  mesfim <- ifelse(lubridate::month(fim) < 10,
                   paste0("0", lubridate::month(fim)),
                   lubridate::month(fim))
  diafim <- ifelse(mesfim %in% c("01", "03", "05", "07", "08", "10", "12"), "31",
                   ifelse(mesfim %in% "02", "28", "30"))
  fimsem <- paste0(lubridate::year(fim), mesfim, diafim) |> lubridate::ymd()
  feriados <- lubridate::ymd(feriados)

  # Definir variáveis globais
  datas <- wkdy <- category <- week <- day <- NULL
  niveis <- c("dom", "seg", "ter", "qua", "qui", "sex", "sab")

  if(lang == "pt") {
    rotulos <- niveis
    } else if (lang == "es") {
      rotulos <- c("dom", "lun", "mar", "mie", "jue", "vie", "sab")
    }

  folha <- data.frame(datas = seq(inisem, fimsem, by=1))  |>
    dplyr::mutate(mon = lubridate::month(datas, label = TRUE),
           wkdy = weekdays(datas, abbreviate=T) |>
             iconv(to="ASCII//TRANSLIT") |>
             factor(levels = niveis, labels = rotulos),
           # feriado = ifelse(datas %in% feriados, 1, 0),
           day = lubridate::mday(datas),
           # Below: our custom wom() function
           week = semes(datas),
           category = NA,
           category = ifelse(datas %in% seq(inicio, fim, by=1), "Semestre", category),
           category = ifelse(category == "Semestre" & wkdy %in% c("dom", "sab"), "fimde", category),
           category = ifelse(category == "Semestre" & wkdy %in% diasem, "Aula", category)
           )

  if(!is.null(feriados)) {
    folha <- folha %>%
    mutate(#category = ifelse(date %in% exams, "Prova", category),
           category = ifelse(datas %in% feriados, "Dia n\U00E3o letivo", category))
  }

  ggplot(folha, aes(wkdy, week)) +
    # theme_steve_web() +
    theme_bw() +
    theme(panel.grid.major.x = element_blank()) +
    geom_tile(alpha=0.8,
              aes(fill=category),
              color="black",
              linewidth=.45) +
    facet_wrap(~mon, scales="free", ncol=3) +
    geom_text(aes(label=day), #family="Helvetica",
              size = size) +
    scale_y_reverse(breaks=NULL) +
    scale_fill_manual(values=c("Aula" = coraula,
                               "Semestre"="lightsteelblue",
                               "Prova"="indianred4",
                               "fimde" = corfimde,
                               "Dia n\U00E3o letivo" = corfer),
                      na.value = corNA,
                      breaks = NULL) +
    labs(fill = "", x="", y="")
}

semes <- function(date) {
  first <- lubridate::wday(as.Date(
    paste(lubridate::year(date), lubridate::month(date), 1, sep="-"))
  )
  return((lubridate::mday(date)+(first-2)) %/% 7+1)
}
