# Seleciona as últimas colunas de um banco de dados

Enquanto [`tail`](https://rdrr.io/r/utils/head.html) mostra as últimas
linhas de uma matriz ou "data frame", `ed()` mostra as últimas colunas
de uma matriz ou "data frame".

## Usage

``` r
ed(x, n = 5)
```

## Arguments

- x:

  Banco de dados (objeto da classe `data.frame`, `matrix` ou `table`)

- n:

  Número de colunas a selecionar (por padrão são 5)

## Value

Um objeto de classe `data.frame` com as últimas colunas selecionadas de
uma matriz ou banco de dados.

## Examples

``` r
ed(RDRS2019) |> # As últimas 5 colunas do banco
  head()
#>   TPDISEC5 TPDISEC6 TPDISEC7 TPDISEC8 TPDISEC9
#> 1        0        0        0        0        0
#> 2        0        0        0        0        0
#> 3        0        0        0        0        0
#> 4        0        0        0        0        0
#> 5        0        0        0        0        0
#> 6        0        0        0        0        0
ed(RDRS2019, 8) |> # As últimas 8 colunas do banco
  head() 
#>   TPDISEC2 TPDISEC3 TPDISEC4 TPDISEC5 TPDISEC6 TPDISEC7 TPDISEC8 TPDISEC9
#> 1        0        0        0        0        0        0        0        0
#> 2        0        0        0        0        0        0        0        0
#> 3        0        0        0        0        0        0        0        0
#> 4        0        0        0        0        0        0        0        0
#> 5        0        0        0        0        0        0        0        0
#> 6        0        0        0        0        0        0        0        0
ed(RDRS2019, 1) |> # A última coluna do banco
  head() 
#>   TPDISEC9
#> 1        0
#> 2        0
#> 3        0
#> 4        0
#> 5        0
#> 6        0
```
