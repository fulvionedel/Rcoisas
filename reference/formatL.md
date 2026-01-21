# Números em formato latino

Apresenta números em formato latino, com ponto (.) como separador de
milhar e vírgula (,) como separador decimal, mudando a classe do objeto
de `numeric` para `character`. A função simplesmente altera os padrões
de [`formatC`](https://rdrr.io/r/base/formatc.html) para
`big.mark = "."` e `decimal.mark = ","`.

## Usage

``` r
formatL(x, digits = 1, format = "f", ...)
```

## Arguments

- x:

  Um número ou vetor com números

- digits:

  Número de decimais

- format:

  Formato numérico (ver
  [`formatC`](https://rdrr.io/r/base/formatc.html))

- ...:

  Permite outros argumentos da função
  [`formatC`](https://rdrr.io/r/base/formatc.html)

## Value

Um vetor de classe `character` com os valores formatados para impressão.

## See also

[`formatC`](https://rdrr.io/r/base/formatc.html),
[`format`](https://rdrr.io/r/base/format.html)

## Examples

``` r
formatL(1234.5678)
#> [1] "1.234,6"
formatL(rnorm(5), digits = 2)
#> [1] "2,10"  "-0,61" "-1,63" "-0,01" "-0,66"
set.seed(1)
x <- c(rnorm(5, 30, 10), rep(20, 2), 25)
x
#> [1] 23.73546 31.83643 21.64371 45.95281 33.29508 20.00000 20.00000 25.00000
formatL(x) 
#> [1] "23,7" "31,8" "21,6" "46,0" "33,3" "20,0" "20,0" "25,0"
formatL(x, format = "fg", digits = 3)
#> [1] "23,7" "31,8" "21,6" "46"   "33,3" "20"   "20"   "25"  
 
```
