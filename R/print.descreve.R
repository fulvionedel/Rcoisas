#' Imprime o resultado da função \code{\link{descreve}}
#' @aliases print.descreve
#' @rdname print.descreve
#' @family descreve
#' 
#' @param x Um objeto da classe \code{descreve}, output de \code{\link{descreve}}
#' @param print Modo de apresentação; \code{print = "tabela"} retorna uma tabela com as estatísticas
#' @param ... Não sei se serve de algo mas parece que precisa
#' 
#' @importFrom tidyr as_tibble gather
#' 
#' @export
print.descreve <- function(x){#}, print = "output", ...) {
  UseMethod("print.descreve", x)
}
#' 
#' 
#' @export
#' 
print.descreve <- function(x, print = "output", ...) {

  print.output <- function(x) {
      cat('\n', x$variavel,': ', x$n, ' observa\u00e7\u00f5es', '\n\n')
      if ( x$miss == 0 ) {
        cat('V\u00E1lidos:', x$val, 
            '\t Missings:', x$miss, 
            ' \t Soma:', x$soma, 
            '\n')
      } else if (x$miss != 0) {
        cat('V\u00E1lidos: ',x$val, 
            '\t Missings: ', x$miss, 
            ' (',x$p.miss,'%)', '\n',
            'Soma: ', x$soma, 
            '\n', 
            sep = "")
      }
      cat('Menor: ',x$menor, '\t Maior: ',x$maior, '\t Amplitude: ',x$amplitude, '\n',
          'M\u00e9dia: ',x$media, '\t DP: ',x$dp, '\t CV(%): ',x$cv, '\n',
          'Assimetria: ',x$assimetria, '\t Curtose(real): ', x$curtose, '\n',
          sep='')
      cat('Quantis:\n'); print(x$quantis) ; cat('\t\t  IIQ:', x$iiq, "\n")
  }
  # -------------
  
  # -------------
  print.tabela <- function(x) {
    df <- as.data.frame(as.numeric(unlist(x)[-1]))
    nomes <- c(# "Vari\u00E1vel",
      "n", 
      "V\u00E1lidos",
      "Missings",
      "\u0025 missings",
      "Menor",
      "Maior",
      "Amplitude",
      "Soma",
      "M\u00e9dia",
      "Vari\u00e2ncia",
      "DP",
      "CV(\u0025)",
      "Assimetria",
      "Curtose",
      "P2.5",
      "P5",
      "P25",
      "P50",
      "P75",
      "P95",
      "P97.5",
      "IIQ")
    names(df) <- x$variavel #deparse(substitute(x))
    rownames(df) <- nomes
    if (df["Missings",] == 0) df <- df[-4,,drop=FALSE]
    df
  }

  if(print == "output") print.output(x)  
  if(print == "tabela") print.tabela(x)
}

  # -------------

  # if(print == FALSE) x
  #   else
  #     if(print == "output") print.output(x)
  #     else if(print == "tabela") print.tabela(x)
  # }

