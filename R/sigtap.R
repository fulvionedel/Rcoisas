#' 
#' Classifica os procedimentos do SISAB em grandes grupos de procedimentos da tabela SIGTAP.
#' 
#' @param df Banco de dados com os procedimentos. Parâmetro obrigatório não definido \emph{a priori}.
#' @param varproc Nome da variável com o código do procedimento. Por padrão é "CO_PROCEDIMENTO" e deve vir entre aspas, simples ou duplas. 
#' @param nomeproc Deve-se criar uma variável com o nome do procedimento? 
#' 
#' @examples 
#' \dontrun{
#'   sigtap(df = procedimentos, 'CO_PROCEDIMENTO') |> head()
#'   sigtap(procedimentos) |> head()
#'   sigtap(procedimentos, nomeproc = TRUE) |> head()
#' }
#' data("PASC2512")
#' sigtap(PASC2512, "PA_PROC_ID") |> head()
#' sigtap(PASC2512, "PA_PROC_ID", nomeproc = TRUE) |> head()
#' 
#' # A lista completa de códigos classificados em grupos pode ser conseguida com:
#' sigtap(Rcoisas:::tabproc) |> head()
#' 
#' @note
#' Agradeço a Matheus Pacheco Andrade, da Gerência de Informação da Secretaria Municipal de Saúde de Florianópolis, SC, por ter encontrado as tabelas no servidor FTP do DATASUS.
#' 
#' @importFrom dplyr "%>%" mutate case_when left_join select rename 
#' @export
#' 

sigtap <- function(df, varproc = 'CO_PROCEDIMENTO', nomeproc = FALSE) {
  
  CO_GRUPO <- CO_SUB_GRUPO <- CO_FORMA_ORGANIZACAO <- NULL
  NO_GRUPO <- NO_SUB_GRUPO <- NO_FORMA_ORGANIZACAO <- NULL
  
  df$CO_GRUPO <- df[[{{varproc}}]] |> substr(1,2)
  df$CO_SUB_GRUPO <- df[[{{varproc}}]] |> substr(3,4)
  df$CO_FORMA_ORGANIZACAO <- df[[{{varproc}}]] |> substr(5,6)

# Lê os arquivos de sistema com códigos e nomes (v. "data-raw/tabelaSIGTAP.R"): 
  banco <- dplyr::left_join(df, tabgrupo, by = "CO_GRUPO") %>% 
    mutate(NO_GRUPO = paste0(CO_GRUPO, ". ", NO_GRUPO))
  banco <- dplyr::left_join(banco, tabsubgrupo, by = c("CO_GRUPO", "CO_SUB_GRUPO")) %>% 
    mutate(NO_SUB_GRUPO = paste0(CO_GRUPO, CO_SUB_GRUPO, ". ", NO_SUB_GRUPO))
  banco <- dplyr::left_join(banco, tabforma, by = c("CO_GRUPO", "CO_SUB_GRUPO", "CO_FORMA_ORGANIZACAO")) %>% 
    mutate(NO_FORMA_ORGANIZACAO = paste0(CO_GRUPO, CO_SUB_GRUPO, CO_FORMA_ORGANIZACAO, ". ", NO_FORMA_ORGANIZACAO))

  if( isTRUE(nomeproc)) {
    PROCEDIMENTO <- PROCEDIMENTO2 <- NULL
    if( isTRUE('PROCEDIMENTO' %in% names(df)) ) {
      PROCEDIMENTO2 <- NULL
      banco <- dplyr::left_join(banco, tabproc, 
                                by = dplyr::join_by({{varproc}} == "CO_PROCEDIMENTO"), 
                                suffix = c("", "2"))
    } else 
      banco <- dplyr::left_join(banco, tabproc, 
                                by = dplyr::join_by({{varproc}} == "CO_PROCEDIMENTO")) %>% 
        rename(PROCEDIMENTO2 = PROCEDIMENTO)
  }

  banco %>% 
    select(-CO_GRUPO, -CO_SUB_GRUPO, -CO_FORMA_ORGANIZACAO) %>% 
    rename(GRUPO = NO_GRUPO, 
           SUBGRUPO = NO_SUB_GRUPO, 
           FORMA = NO_FORMA_ORGANIZACAO)
}
