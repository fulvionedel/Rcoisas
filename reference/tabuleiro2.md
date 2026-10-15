# Tabela de frequências bivariada

Constrói uma tabela da distribuição de frequências brutas, relativas e
acumuladas de uma variável por outra, com rótulos em português.

## Usage

``` r
tabuleiro2(
  data = NULL,
  x,
  y,
  digits = 1,
  total = TRUE,
  cum = TRUE,
  na.rm = TRUE
)
```

## Arguments

- data:

  Argumento opcional. Banco de dados contendo `x`. O padrão é `NULL`.

- x:

  A variável de linha.

- y:

  A variável de coluna.

- digits:

  nº de decimais na tabela. O padrão é 1.

- total:

  `TRUE` (padrão) apresenta o total de categorias na tabela.

- cum:

  `TRUE` (padrão) apresenta as frequências acumuladas das cateogrias.

- na.rm:

  `TRUE` (padrão) remove os "missings".

## Examples

``` r
data("hasdm")
hasdm |> 
  tabuleiro2(problema, sexo)
#> # A tibble: 3 × 9
#>   problema n_Masculino n_Feminino n.cum_Masculino n.cum_Feminino p_Masculino
#>   <fct>          <int>      <int>           <int>          <int>       <dbl>
#> 1 só HAS            82        186              82            186       66.7 
#> 2 só DM              9          9              91            195        7.32
#> 3 HAS e DM          32         65             123            260       26.0 
#> # ℹ 3 more variables: p_Feminino <dbl>, p.cum_Masculino <dbl>,
#> #   p.cum_Feminino <dbl>

data("poprs")
poprs$fxetar3 <- csapAIH::fxetar3g(poprs$fxetar5)
poprs |> 
  tabuleiro2(fxetar3, sexo, cum = FALSE)   
#> # A tibble: 3 × 5
#>   fxetar3 n_masc p_masc n_fem p_fem
#>   <chr>    <int>  <dbl> <int> <dbl>
#> 1 0-14      3675   17.7  3675  17.6
#> 2 15-59    11025   53.0 11025  52.9
#> 3 60e+      6121   29.4  6125  29.4
  
```
