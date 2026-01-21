# Bolero: tabelas 2x2

Analisa uma tabela 2x2 e apresenta um output com rótulos em português

## Usage

``` r
bolero(independente, dependente = NULL, dec = 2, dnn = NULL)
```

## Arguments

- independente:

  Variável independente

- dependente:

  Variável dependente

- dec:

  No. de decimais

- dnn:

  Nome das variáveis a ser impresso no 'output'

## Value

Um objeto da classe \`list\` com as tabelas de frequências absolutas e
relativas, razão de probabilidades e de odds, com seus intervalos de
confiança e valores-p.

## Examples

``` r
with(RDRS2019, bolero(SEXO, MORTE))
#> ===============================================================
#>                   Tabela 2 por 2 
#>         bolero(independente, dependente, dec=2, dnn) 
#> --------------------------------------------------------------- 
#> Var. dependente : MORTE = 0 
#> Var. independente: SEXO = 1 
#> Missings: 0 (0,0%)
#> 
#>      MORTE
#> SEXO      0     1   Sum
#>   1    4251   284  4535
#>   3    5238   227  5465
#>   Sum  9489   511 10000
#> 
#> Proporções (%)
#>     MORTE
#> SEXO    0    1
#>    1 93.7  6.3
#>    3 95.8  4.2
#> 
#> Razão de Probabilidades: 0.98 ; IC95% (assintótico): 0.97 0.99 
#>                                 IC95% (exato)      : 0.97 0.99
#> Razão de Odds          : 0.65 ; IC95% (exato)      : 0.54 0.78
#> Valor-p: Pearson, Yates: <0,001 ; Fisher: <0,001 
#> ===============================================================
with(RDRS2019, bolero(SEXO, MORTE, dnn = c("Sexo", "Óbito")))
#> ===============================================================
#>                   Tabela 2 por 2 
#>         bolero(independente, dependente, dec=2, dnn) 
#> --------------------------------------------------------------- 
#> Var. dependente : Óbito = 0 
#> Var. independente: Sexo = 1 
#> Missings: 0 (0,0%)
#> 
#>      Óbito
#> Sexo      0     1   Sum
#>   1    4251   284  4535
#>   3    5238   227  5465
#>   Sum  9489   511 10000
#> 
#> Proporções (%)
#>     Óbito
#> Sexo    0    1
#>    1 93.7  6.3
#>    3 95.8  4.2
#> 
#> Razão de Probabilidades: 0.98 ; IC95% (assintótico): 0.97 0.99 
#>                                 IC95% (exato)      : 0.97 0.99
#> Razão de Odds          : 0.65 ; IC95% (exato)      : 0.54 0.78
#> Valor-p: Pearson, Yates: <0,001 ; Fisher: <0,001 
#> ===============================================================
```
