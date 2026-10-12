#' Verifica se um número é inteiro 
#' 
#' @param num Um ou mais números, vindo de um
#' 
#' @examples
#' numinteiro(13)
#' numinteiro(13.13)
#' numinteiro(c(13, 13.65, 65, 65.13))
#' numinteiro(c(0.13, .650, 13.0))
#' 
#' \dontrun{
#'   numinteiro("Texto com ponto.")
#'   numinteiro("04.10")
#'   numinteiro("13.13")
#' }
#' 
#' @export
#' 
numinteiro <- function(num){
  if(is.character(num)) return("Digite um n\U00FAmero sem aspas.") 
  !grepl(pattern = ".", x = num, fixed = TRUE)
}
