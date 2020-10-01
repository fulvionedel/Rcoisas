#' @title Codigos, siglas e nomes dos estados brasileiros
#' @author Fúlvio B. Nedel
#' @aliases codestados
#' @description Lista as siglas e nomes dos estados e Distrito Federal do Brasil segundo seu código no IBGE. Com isso, permite a decodificação do código do IBGE para a sigla ou nome da Unidade da Federação.
#' @export
#' @examples
#' codestados()
#' codestados()[,2]
#' codestados()[,3]
#'
codestados <- function(){
  data.frame(coduf = c(11:17, 21:29, 31:33, 35, 41:43, 50:53),
             siglauf = c("RO", "AC", "AM", "RR", "PA", "AP", "TO", "MA", "PI", "CE", "RN", "PB", "PE", "AL", "SE", "BA", "MG", "ES", "RJ", "SP", "PR", "SC", "RS", "MS", "MT", "GO", "DF"),
             nomeuf = c("Rond\U00f4nia", "Acre", "Amazonas", "Roraima", "Par\U00e1", "Amap\U00e1", "Tocantins", "Maranh\U00e3o", "Piau\U00ed", "Cear\U00e1", "Rio Grande do Norte", "Para\U00edba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", "Minas Gerais", "Esp\U00edrito Santo", "Rio de Janeiro", "S\U00e3o Paulo", "Paran\U00e1", "Santa Catarina", "Rio Grande do Sul", "Mato Grosso do Sul", "Mato Grosso", "Goi\U00e1s", "Distrito Federal")
        )
}

