#' @title Computes the mode of a variable
#' @aliases moda
#' @description Calcula a moda de uma variável
#' 
#' @param x A vector. Maybe numeric, character or factor
#' @param tipo Defines the method. `int1` (the default) find the most frequent value in an unimodal distribution; `int2` finds the two most frequent values in a bimodal distribution; `dens` computes the value of most density in a numeric variable. If the variable is continuous, with only unique values, `tipo` will be coerced to `dens`
#' @param count Should the frequencies of values be described?
#' @export

moda <- function(x, tipo = "int1", count = FALSE) {
  if(length(unique(x)) == length(x) & tipo !="dens") {
    tipo = 'dens'
    count = FALSE
    warning("tipo foi convertido para 'dens', porque todos os valores s\U00e3o \U00fanicos")
  } 
  if(tipo == 'int1') {
    valor = names(sort(-table(x)))[1]
    categorias = sort(table(x), decreasing = T)[1]
  }
  else if(tipo == 'int2') {
    valor = names(sort(-table(x)))[1:2]
    categorias = sort(table(x), decreasing = T)[1:2]
    
  }
  else if(tipo == 'dens') {
    d = density(x, na.rm = T)
    i <- which.max(d$y)
    valor = d$x[i]
  }
  if(count == FALSE) {
    if(class(x) == 'numeric') {
      return(as.numeric(valor)) 
    }
    else
      return(valor)
    }
  else 
    return(categorias)
}

# x = rnorm(100)
# y = round(x,2)
# z = cut(x, 3)
# m = c(rep(3,10), rep(30,6), 1:30)
# sort(x)
# table(x)
# plot(density(x))
# moda(x, 'dens')
# moda(x, 'int1')
# moda(x, 'int2')
# moda(x, count = T)
# moda(x, 'int2', count = T)
# class(moda(x, 'dens'))
# class(moda(x))
# 
# moda(y)
# moda(y, 'int1')
# moda(y, 'int2')
# moda(y, count = T)
# moda(y, 'int2', count = T)
# class(moda(y))
# 
# moda(z, 'int1')
# moda(z, 'int2')
# moda(z, count = T)
# moda(z, 'int2', count = T)
# class(moda(z))
