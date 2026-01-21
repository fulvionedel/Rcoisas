# Tabela de frequências univariada

Constrói uma tabela com distribuição de frequências brutas, relativas e
acumuladas, semelhante às do SPSS, com separadores latinos.

## Usage

``` r
tabuleiro2(varcat, digits = 1)
```

## Arguments

- varcat:

  Uma variável categórica

- digits:

  No. de decimais

## Examples

``` r
# criar uma variável politômica
x <- cut(rnorm(1000), 3) # sem missings
tabuleiro2(x)
#>               Freq    %(+NA) % acum
#> (-3.23,-1.16] "  137" "13,7" "13,7"
#> (-1.16,0.892] "  688" "68,8" "82,5"
#> (0.892,2.95]  "  175" "17,5" "100" 
#> Total         "1.000" "100"  "˗"   
x[1:100] <- NA # gerar missings
tabuleiro2(x)
#>               Freq    %(+NA) % válido % acum
#> (-3.23,-1.16] "  121" "12,1" "13,4"   "13,4"
#> (-1.16,0.892] "  617" "61,7" "68,6"   "82,0"
#> (0.892,2.95]  "  162" "16,2" "18,0"   "100" 
#> Total válidos "  900" "90,0" "100"    "˗"   
#> Missing       "  100" "10,0" "˗"      "˗"   
#> Total         "1.000" "100"  "˗"      "˗"   

if (FALSE) { # \dontrun{
knitr::kable(tabuleiro2(x), align = rep("r", 4))
} # }
```
