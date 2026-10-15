# Verifica se um número é inteiro

Verifica se um número é inteiro

## Usage

``` r
numinteiro(num)
```

## Arguments

- num:

  Um ou mais números, vindo de um

## Examples

``` r
numinteiro(13)
#> [1] TRUE
numinteiro(13.13)
#> [1] FALSE
numinteiro(c(13, 13.65, 65, 65.13))
#> [1]  TRUE FALSE  TRUE FALSE
numinteiro(c(0.13, .650, 13.0))
#> [1] FALSE FALSE  TRUE

if (FALSE) { # \dontrun{
  numinteiro("Texto com ponto.")
  numinteiro("04.10")
  numinteiro("13.13")
} # }
```
