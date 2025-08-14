#' Cronograma  
#'
#' @description
#' Desenha um Diagrama de Gantt representando um cronograma de  tarefas.
#' 
#' @param banco Banco de dados contendo as variáveis com informação sobre a tarefa, sua data de início e fim. Objeto da classe \code{data.frame} .
#' @param tarefa Nome da variável com a tarefa. Deve ir sem aspas. Padrão é `tarefa`.
#' @param inicio Nome da variável com a data de início da tarefa. Padrão é `inicio`.
#' @param fim Nome da variável com a data de fim da tarefa.Padrão é `fim`.
#' @param paleta Paleta de cores para o gráfico. Pode ser "Set1", "Set2", "Set3", "Dark2", "Paired", "Pastel1", "Pastel2", "Accent". 
#' @param breaks Intervalo de espaçamento para a apresentação da data, em meses. O padrão é 2.
#' @param ttexto.data Tamanho do texto para as datas (eixo x).
#' @param ttexto.tarefa Tamanho do texto para as tarefas (eixo y).
#' @param gradevert O diagrama deve apresentar linhas verticais, para melhor identificação da data? O padrão é \code{TRUE}.
#' @param ordenar_por Ordena por uma variável numérica presente no banco, como a data de início ou fim da tarefa. O padrão é \code{NULL}.
#' @param ordem_desc Se ordenado por alguma variável em \code{ordenar_por}, a ordem deve ser descendente? O padrão é \code{TRUE}.
#' @param xlab Rótulo para o eixo x (datas). Padrão é "Período de execução".
#' @param ylab Rótulo para o eixo y (tarefas). Padrão é "Tarefa".  
#' @param titulo Título para o gráfico. Padrão é \code{NULL}.
#' 
#' @examples
#' tarefa <- c("Revisão bibliográfica", "Coleta de dados", "Análise de dados", "Elaboração do artigo")
#' inicio <- as.Date(c("2025-01-01", "2025-04-01", "2025-06-15", "2025-08-01")) 
#' fim    <- as.Date(c("2025-08-01", "2025-06-01", "2025-07-31", "2025-10-01")) 
#' cronograma <- data.frame(tarefa, inicio, fim)
#' str(cronograma) # "tarefa" é da classe 'character', não 'factor'
#' calendas(cronograma) # Tarefas ordenadas alfabeticamente em ordem descendente
#' cronograma$tarefa <- factor(cronograma$tarefa, levels = tarefa)
#' str(cronograma)    # Categorias ordenadas,
#' calendas(cronograma) # mas apresentdas em ordem descendente 
#' cronograma$tarefa.rev <- # cria outra variável com a ordem das categorias 
#'   factor(cronograma$tarefa, levels = rev(tarefa)) # invertida
#' str(cronograma) 
#' calendas(cronograma, tarefa.rev) # Ordem ascendente
#' rm(tarefa, inicio, fim)
#' 
#' # Banco com outros nomes de variáveis
#' cronograma$tarefa.rev <- NULL
#' names(cronograma) <- c("tar", "tari", "tarf") 
#' calendas(cronograma, tar, tari, tarf)
#' 
#' # Outra paleta e sem a grade vertical:
#' calendas(cronograma, tar, tari, tarf, gradevert = FALSE, paleta = "Dark2")
#' 
#' # Ordenar pelas datas de início ou fim da tarefa:
#' calendas(cronograma, tar, tari, tarf, ordenar_por = "tari")
#' calendas(cronograma, tar, tari, tarf, ordenar_por = "tarf")
#' 
#' @importFrom ggplot2 ggplot aes geom_segment labs scale_x_date theme element_text element_line scale_color_brewer
#' @importFrom dplyr %>% mutate
#' @importFrom forcats fct_reorder
#' 
#' @export
#' 
calendas <- function(banco, tarefa = tarefa, inicio = inicio, fim = fim, paleta = NULL, ttexto.data = 8, ttexto.tarefa = 10, gradevert = TRUE, breaks = 2, ordenar_por = NULL, ordem_desc = TRUE, xlab = NULL, ylab = NULL, titulo = NULL) {
  # library(rlang)
  # library(ggthemes)
  
  # Títulos
  if(is.null(xlab)) { xlab = "\nPer\u00edodo de execu\u00e7\u00e3o" }
  if(is.null(ylab)) { ylab = "Tarefa\n" } 
  
  # Captura os símbolos
  # tarefa_sym <- ensym(tarefa)
  inicio <- ensym(inicio)
  fim <- ensym(fim)
  
  # Cria coluna auxiliar para ordenação no eixo Y
  .tarefa_color <- .tarefa_eixo <- NULL
  banco <- banco %>%
    mutate(
      .tarefa_color = as.factor({{tarefa}}),  # fixa as cores
      .tarefa_eixo = {{tarefa}}               # será reordenada se necessário
    )
  
  # Aplica ordenação opcional ao eixo Y
  if (!is.null(ordenar_por)) {
    # ordenar_por <- ensym(ordenar_por)
    banco <- banco %>%
      mutate(.tarefa_eixo = forcats::fct_reorder(.tarefa_eixo, .data[[{{ordenar_por}}]], .desc = ordem_desc))
  }
  
  # Cria gráfico com cor fixa e eixo reordenado
  gr <- ggplot(banco, aes(x = !!inicio, xend = !!fim,
                          y = .tarefa_eixo, yend = .tarefa_eixo,
                          color = .tarefa_color)) +
    geom_segment(linewidth = 8) +
    labs(y = ylab, x = xlab, title = titulo) +
    scale_x_date(date_labels = "%b\n%Y", date_breaks = paste(breaks, "month")) +
    ggthemes::theme_hc() +
    theme(legend.position = "none",
          axis.text.x = element_text(size = ttexto.data),
          axis.text.y = element_text(size = ttexto.tarefa))
  
  # Grade vertical
  if (isTRUE(gradevert)) {
    gr <- gr +
      theme(panel.grid.major.x = element_line(linetype = 2, colour = "gray", linewidth = .3))
  }
  
  # Paleta de cores
  if (!is.null(paleta)) {
    gr <- gr + scale_color_brewer(palette = paleta)
  }
  
  return(gr)
}


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
