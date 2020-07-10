#' Imprime o resultado da funcao \code{\link{descreve}}
#' @aliases print.descreve
#' @rdname print.descreve
#' @family descreve
#' @param x Um output de \code{\link{descreve}}
#' @param dec Número de decimais
#' @param ... **Acho** que permite coisas de \code{\link{print}}
#' @export 
print.descreve <- function(x, ...) {
  UseMethod("print.descreve")
}
#' @export
#' 
print.descreve <-
  function(x, dec = 2, ...) {
    cat(x$variavel,': ', x$n, ' observa\u00e7\u00f5es', '\n\n')
    if ( x$miss == 0 ) {
      cat('V\u00E1lidos:',x$val, 
          '\t Missings:',x$miss, 
          ' \t Soma:',x$soma, 
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
        sep='', ...
        )
    cat('Quantis:\n'); print(x$quantis) ; cat('\t\t  IIQ:',x$iiq)
}
