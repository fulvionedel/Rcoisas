# Tabela de frequências univariada

Constrói uma tabela com distribuição de frequências brutas, relativas e
acumuladas, com rótulos em português.

## Usage

``` r
tabuleiro(x, digits = 1, total = TRUE, cum = TRUE, data = NULL, ...)
```

## Arguments

- x:

  O vetor a ser tabulado.

- digits:

  nº de decimais na tabela. O padrão é 1.

- total:

  TRUE (default) apresenta o total de categorias na tabela.

- cum:

  TRUE (default) apresenta as frequências acumuladas das cateogrias.

- data:

  Argumento opcional. Banco de dados contendo `x`. O padrão é NULL.

- ...:

  permite o uso de argumentos da função
  [`table`](https://rdrr.io/r/base/table.html).

## Examples

``` r
set.seed(1)
x <- rbinom(100000, 3, .25)

tabuleiro(x)
#>         Freq     % Freq.acum %acum
#> 0      42221  42.2     42221  42.2
#> 1      42127  42.1     84348  84.3
#> 2      14003  14.0     98351  98.4
#> 3       1649   1.6    100000 100.0
#> Total 100000 100.0    100000 100.0

# Sem o total
tabuleiro(x, total = FALSE)
#>    Freq    % Freq.acum %acum
#> 0 42221 42.2     42221  42.2
#> 1 42127 42.1     84348  84.3
#> 2 14003 14.0     98351  98.4
#> 3  1649  1.6    100000 100.0

# Sem as frequências acumuladas
tabuleiro(x, cum = FALSE)
#>         Freq     %
#> 0      42221  42.2
#> 1      42127  42.1
#> 2      14003  14.0
#> 3       1649   1.6
#> Total 100000 100.0

# Oculta a frequência acumulada absoluta e mantém a % acumulada
tabuleiro(x, total = FALSE)[,-3]
#>    Freq    % %acum
#> 0 42221 42.2  42.2
#> 1 42127 42.1  84.3
#> 2 14003 14.0  98.4
#> 3  1649  1.6 100.0
```
