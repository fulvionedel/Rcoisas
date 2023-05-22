
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rcoisas

<!-- badges: start -->
<!-- badges: end -->

> Funções para aulas e apresentação de resultados em português.

O pacote contém 14 funções, incluídas algumas importadas do pacote
[`csapAIH`](https://github.com/fulvionedel/csapAIH), principalmente
para a descrição de variáveis com ‘output’ em português, e trabalhar com
populações brasileiras .

### Funções no pacote `Rcoisas`

     [1] "POPBR12                 População brasileira"                             
     [2] "POPRS2019               População por sexo e faixa etária. Municípios"    
     [3] "                        gaúchos, 2019."                                   
     [4] "RDRS2019                Arquivos da AIH"                                  
     [5] "bolero                  Bolero: tabelas 2x2"                              
     [6] "descreve                Descreve uma variável numérica"                   
     [7] "formatL                 Números em formato latino"                        
     [8] "fxetar.det_pra_fxetar5"                                                   
     [9] "                        Transforma a \"faixa etária detalhada\" (DATASUS)"
    [10] "                        em 17 faixas quinquenais."                        
    [11] "ggplot_pir              Pirâmides populacionais"                          
    [12] "histobox                Histograma com boxplot"                           
    [13] "obitosRS2019            Registros de óbito"                               
    [14] "plot.histobox           Método para histobox"                             
    [15] "plotZ                   Gráfico da probababilidade de pertencer a uma"    
    [16] "                        área da curva Normal"                             
    [17] "plot_pir                Pirâmides populacionais com os arquivos de"       
    [18] "                        população disponibilizados pelo DATASUS"          
    [19] "print.descreve          Imprime o resultado da função 'descreve'"         
    [20] "tabuleiro               Tabela de frequências univariada"                 
    [21] "tabuleiro2              Tabela de frequências com separadores latinos"    

## Instalação

O pacote ainda não tem uma primeira versão para ser lançada. A versão de
desenvolvimento pode ser instalada a partir do
[GitHub](https://github.com/) com:

``` r
# install.packages("remotes") # Se for necessário
remotes::install_github("fulvionedel/Rcoisas")
```

## Exemplos

``` r
library(Rcoisas)
```

### Descrição univariada

Funções `descreve`, `histobox` e `tabuleiro`.

``` r
varnum <- rnorm(1000)
descreve(varnum)
#> varnum :  1000  observações 
#> 
#> Válidos: 1000     Missings: 0     Soma: -19.48 
#> Menor: -3     Maior: 3.21     Amplitude: 6.2
#> Média: -0.02  DP: 1.02    CV(%): 5239.01
#> Assimetria: -0.01     Curtose(real): 2.83
#> Quantis:
#>  2.5%    5%   25%   50%   75%   95% 97.5% 
#> -2.02 -1.70 -0.72  0.01  0.70  1.61  1.95 
#>        IIQ: 1.42
descreve(varnum, print = "tabela")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

    #>                  x
    #> n          1000.00
    #> Válidos    1000.00
    #> Missings      0.00
    #> Menor        -3.00
    #> Maior         3.21
    #> Amplitude     6.20
    #> Soma        -19.48
    #> Média        -0.02
    #> Variância     1.04
    #> DP            1.02
    #> CV(%)      5239.01
    #> Assimetria   -0.01
    #> Curtose       2.83
    #> P2.5         -2.02
    #> P5           -1.70
    #> P25          -0.72
    #> P50           0.01
    #> P75           0.70
    #> P95           1.61
    #> P97.5         1.95
    #> IIQ           1.42
    histobox(varnum)

<img src="man/figures/README-unnamed-chunk-4-2.png" width="100%" />

``` r

tabuleiro(obitosRS2019$RACACOR)
#>          Freq     % Freq.acum %acum
#> Branca    767  88.3       767  88.3
#> Indígena    2   0.2       769  88.5
#> Parda      51   5.9       820  94.4
#> Preta      49   5.6       869 100.0
#> Total     869 100.0       869 100.0
tabuleiro2(obitosRS2019$RACACOR)
#>               Freq  %(+NA) % válido % acum
#> Branca        "767" "86,0" "88,3"   "88,3"
#> Indígena      "  2" "0,2"  "0,2"    "88,5"
#> Parda         " 51" "5,7"  "5,9"    "94,4"
#> Preta         " 49" "5,5"  "5,6"    "100" 
#> Total válidos "869" "97,4" "100"    "˗"   
#> Missing       " 23" "2,6"  "˗"      "˗"   
#> Total         "892" "100"  "˗"      "˗"
```

``` r
descreve(varnum, print = "tabela") |> 
  dplyr::mutate(x = formatL(x, format = "fg"))
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

    #>                x
    #> n          1.000
    #> Válidos    1.000
    #> Missings       0
    #> Menor         -3
    #> Maior          3
    #> Amplitude      6
    #> Soma         -19
    #> Média      -0,02
    #> Variância      1
    #> DP             1
    #> CV(%)      5.239
    #> Assimetria -0,01
    #> Curtose        3
    #> P2.5          -2
    #> P5            -2
    #> P25         -0,7
    #> P50         0,01
    #> P75          0,7
    #> P95            2
    #> P97.5          2
    #> IIQ            1

### Tabelas 2 $\times$ 2

``` r
obitos <- obitosRS2019[c("sexo", "idade", "RACACOR", "CAUSABAS")]
cardio <- grepl("circulatório", csapAIH::cid10cap(obitos$CAUSABAS)) |>
  factor(levels = c(TRUE, FALSE), labels = c("sim", "não"))
externas <- grepl("externas", csapAIH::cid10cap(obitos$CAUSABAS)) |>
  factor(levels = c(TRUE, FALSE), labels = c("sim", "não"))

bolero(obitos$sexo, cardio)
#> =============================================================
#>                   Tabela 2 por 2 
#>         bolero(independente, dependente, dec=2, dnn) 
#> ------------------------------------------------------------- 
#> Var. dependente : cardio = sim 
#> Var. independente: obitos.sexo = fem 
#> 
#>            cardio
#> obitos$sexo sim não Sum
#>        fem  100 311 411
#>        masc 131 350 481
#>        Sum  231 661 892
#> 
#> Proporções (%)
#>            cardio
#> obitos$sexo  sim  não
#>        fem  24.3 75.7
#>        masc 27.2 72.8
#> 
#>   Razão de Probabilidades: 0.89 ; IC95% (assintótico): 0.71 1.12 
#>                                   IC95% (exato)      : 0.70 1.12
#>   Razão de Odds          : 0.86 ; IC95% (exato)      : 0.63 1.17
#>   Valor-p: Pearson, Yates: 0.363 ; Fisher: 0.358 
#> =============================================================
bolero(factor(obitos$sexo, levels = c("masc", "fem")), externas, dnn = c("sexo", "causas externas"))
#> =============================================================
#>                   Tabela 2 por 2 
#>         bolero(independente, dependente, dec=2, dnn) 
#> ------------------------------------------------------------- 
#> Var. dependente : causas.externas = sim 
#> Var. independente: sexo = masc 
#> 
#>       causas externas
#> sexo   sim não Sum
#>   masc  66 415 481
#>   fem   19 392 411
#>   Sum   85 807 892
#> 
#> Proporções (%)
#>       causas externas
#> sexo    sim  não
#>   masc 13.7 86.3
#>   fem   4.6 95.4
#> 
#>   Razão de Probabilidades: 2.97 ; IC95% (assintótico): 1.81 4.86 
#>                                   IC95% (exato)      : 1.83 4.81
#>   Razão de Odds          : 3.28 ; IC95% (exato)      : 1.90 5.89
#>   Valor-p: Pearson, Yates: <0,001 ; Fisher: <0,001 
#> =============================================================
```

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->
