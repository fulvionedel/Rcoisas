#' @title Tabela de frequências bivariada
#' @description Constrói uma tabela da distribuição de frequências brutas, relativas e acumuladas de uma variável por outra, com rótulos em português.
#' @aliases tabuleiro2
#' 
#' @param data Argumento opcional. Banco de dados contendo \code{x}. O padrão é \code{NULL}.
#' @param x A variável de linha.
#' @param y A variável de coluna.
#' @param digits nº de decimais na tabela. O padrão é 1.
#' @param total \code{TRUE} (padrão) apresenta o total de categorias na tabela.
#' @param cum   \code{TRUE} (padrão) apresenta as frequências acumuladas das cateogrias.
#' @param na.rm \code{TRUE} (padrão) remove os "missings".
#' 
#' @examples 
#' data("hasdm")
#' hasdm |> 
#'   tabuleiro2(problema, sexo)
#' 
#' data("poprs")
#' poprs$fxetar3 <- csapAIH::fxetar3g(poprs$fxetar5)
#' poprs |> 
#'   tabuleiro2(fxetar3, sexo, cum = FALSE)   
#'   
#' @importFrom dplyr  count group_by relocate select ungroup
#' @importFrom tidyr pivot_wider
#' 
#' @export
#' 
tabuleiro2 <- function( data = NULL, x, y, digits = 1, total = TRUE, cum = TRUE, na.rm = TRUE) {
  if(!is.null(data)) {
    dados <- data |>
      dplyr::select({{x}}, {{y}})
  } else {
      nomes <- c(utils::tail(all.names(substitute(x)), 1),
                 utils::tail(all.names(substitute(y)), 1))
      dados <- data.frame(x = {{x}}, y = {{y}})
      names(dados) <- nomes
    }
  if(isTRUE(na.rm)) dados <- na.omit(dados)
  
  tabela <- dados |> 
    group_by(.data[[substitute(y)]]) |>
    dplyr::count(.data[[substitute(x)]]) |> 
    mutate(n.cum = cumsum(n),
           p = n/sum(n)*100,
           p.cum = cumsum(p)) |>
    dplyr::ungroup()

  xx <- substitute(x)
  yy <- substitute(y)
  n <- p <- n.cum <- p.cum <- p_masc <- n_masc <- p_fem <- n_fem <- NULL 
  
  if(isTRUE(cum)) {
    tabela <- tabela |> 
      tidyr::pivot_wider(id_cols = xx, names_from = yy, 
                         values_from = c(n, n.cum, p, p.cum))
  } else {
    tabela <- tabela |> 
      tidyr::pivot_wider(id_cols = xx, names_from = yy, 
                         values_from = c(n, p)) |> 
      dplyr::relocate(p_masc, .after = n_masc) |> 
      dplyr::relocate(p_fem, .after = n_fem)
  }
  
  tabela
}
