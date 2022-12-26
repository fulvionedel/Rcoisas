
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rcoisas

<!-- badges: start -->
<!-- badges: end -->

> Funções para aulas e apresentação de resultados em português.

O pacote contém 15 funções, incluídas algumas importadas do pacote
[`csapAIH`](https://github.com/fulvionedel/csapAIH)), principalmente
para a descrição de variáveis com ‘output’ em português, e trabalhar com
populações brasileiras .

### Funções no pacote `Rcoisas`

     [1] "POPBR12                 População brasileira"                             
     [2] "RDRS2019                Arquivos da AIH"                                  
     [3] "bolero                  Bolero: tabelas 2x2"                              
     [4] "demonstra_IC            Demonstração do intervalo de confiança"           
     [5] "descreve                Descreve uma variável numérica"                   
     [6] "formatL                 Números em formato latino"                        
     [7] "fxetar.det_pra_fxetar5"                                                   
     [8] "                        Transforma a \"faixa etária detalhada\" (DATASUS)"
     [9] "                        em 17 faixas quinquenais."                        
    [10] "ggplot_pir              Pirâmides populacionais"                          
    [11] "histobox                Histograma com boxplot"                           
    [12] "obitosRS2019            Registros de óbito"                               
    [13] "plot.histobox           Método para histobox"                             
    [14] "plotZ                   Gráfico da probababilidade de pertencer a uma"    
    [15] "                        área da curva Normal"                             
    [16] "plot_pir                Pirâmides populacionais com os arquivos de"       
    [17] "                        população disponibilizados pelo DATASUS"          
    [18] "print.descreve          Imprime o resultado da função 'descreve'"         
    [19] "tabuleiro               Tabela de frequências univariada"                 
    [20] "tabuleiro2              Tabela de frequências com separadores latinos"    

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
#>        fem  117 284 401
#>        masc 106 385 491
#>        Sum  223 669 892
#> 
#> Proporções (%)
#>            cardio
#> obitos$sexo  sim  não
#>        fem  29.2 70.8
#>        masc 21.6 78.4
#> 
#>   Razão de Probabilidades: 1.35 ; IC95% (assintótico): 1.08 1.70 
#>                                   IC95% (exato)      : 1.07 1.67
#>   Razão de Odds          : 1.50 ; IC95% (exato)      : 1.09 2.05
#>   Valor-p: Pearson, Yates: 0.012 ; Fisher: 0.01 
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
#>   masc  69 422 491
#>   fem   16 385 401
#>   Sum   85 807 892
#> 
#> Proporções (%)
#>       causas externas
#> sexo    sim  não
#>   masc 14.1 85.9
#>   fem   4.0 96.0
#> 
#>   Razão de Probabilidades: 3.52 ; IC95% (assintótico): 2.08 5.97 
#>                                   IC95% (exato)      : 2.11 5.88
#>   Razão de Odds          : 3.93 ; IC95% (exato)      : 2.21 7.38
#>   Valor-p: Pearson, Yates: <0,001 ; Fisher: <0,001 
#> =============================================================
```

<<<<<<< HEAD
<!-- ### Demonstração do intervalo de confiança -->
=======
<<<<<<< HEAD
<!-- ### Demonstração do intervalo de confiança -->
=======
### Demonstração do intervalo de confiança

``` r
demonstra_IC(rnorm(1000), n = 50000, r = 100)
#> $mediapop
#> [1] 0.04598021
#> 
#> $medias
#>          media     liminf     limsup fora
#> 1   0.04527370 0.03657471 0.05397268    2
#> 2   0.04774505 0.03906805 0.05642205    2
#> 3   0.05119779 0.04253315 0.05986244    2
#> 4   0.04675104 0.03805866 0.05544341    2
#> 5   0.04536482 0.03668851 0.05404113    2
#> 6   0.04479409 0.03612186 0.05346633    2
#> 7   0.04697701 0.03828479 0.05566923    2
#> 8   0.03930651 0.03059834 0.04801469    2
#> 9   0.04641496 0.03775943 0.05507050    2
#> 10  0.04908892 0.04046406 0.05771378    2
#> 11  0.04764927 0.03899078 0.05630776    2
#> 12  0.05445159 0.04578047 0.06312271    2
#> 13  0.05137120 0.04268392 0.06005847    2
#> 14  0.05274743 0.04409401 0.06140085    2
#> 15  0.04475461 0.03605817 0.05345105    2
#> 16  0.04649218 0.03779772 0.05518663    2
#> 17  0.04948138 0.04080885 0.05815392    2
#> 18  0.04505883 0.03640742 0.05371024    2
#> 19  0.04708105 0.03843717 0.05572494    2
#> 20  0.04202196 0.03338712 0.05065680    2
#> 21  0.04387570 0.03520654 0.05254486    2
#> 22  0.05175791 0.04313845 0.06037737    2
#> 23  0.05325900 0.04453821 0.06197978    2
#> 24  0.04946122 0.04079904 0.05812341    2
#> 25  0.04898429 0.04029112 0.05767745    2
#> 26  0.04285570 0.03419777 0.05151363    2
#> 27  0.04500374 0.03630061 0.05370686    2
#> 28  0.05330454 0.04463169 0.06197740    2
#> 29  0.04890362 0.04026061 0.05754663    2
#> 30  0.04296290 0.03427415 0.05165166    2
#> 31  0.03640370 0.02774818 0.04505922    1
#> 32  0.03995811 0.03125321 0.04866301    2
#> 33  0.04251895 0.03380790 0.05122999    2
#> 34  0.04818642 0.03956554 0.05680731    2
#> 35  0.04491673 0.03619533 0.05363814    2
#> 36  0.04945617 0.04077371 0.05813863    2
#> 37  0.04168109 0.03301006 0.05035212    2
#> 38  0.04935038 0.04067455 0.05802621    2
#> 39  0.04833147 0.03966427 0.05699868    2
#> 40  0.04945687 0.04078138 0.05813236    2
#> 41  0.05255304 0.04384553 0.06126056    2
#> 42  0.04496380 0.03628352 0.05364407    2
#> 43  0.04762763 0.03899319 0.05626206    2
#> 44  0.04696022 0.03833913 0.05558132    2
#> 45  0.05040149 0.04177552 0.05902747    2
#> 46  0.04513467 0.03644627 0.05382306    2
#> 47  0.04665464 0.03799541 0.05531387    2
#> 48  0.04714684 0.03845513 0.05583855    2
#> 49  0.04394920 0.03529825 0.05260016    2
#> 50  0.04431716 0.03562641 0.05300791    2
#> 51  0.05343313 0.04470686 0.06215940    2
#> 52  0.05039235 0.04169696 0.05908773    2
#> 53  0.05070787 0.04203777 0.05937796    2
#> 54  0.05625355 0.04755499 0.06495212    1
#> 55  0.05689247 0.04830963 0.06547531    1
#> 56  0.04311485 0.03447760 0.05175210    2
#> 57  0.04862914 0.03998054 0.05727774    2
#> 58  0.03573387 0.02704624 0.04442151    1
#> 59  0.04307643 0.03443186 0.05172100    2
#> 60  0.05230898 0.04365846 0.06095949    2
#> 61  0.04540454 0.03670661 0.05410248    2
#> 62  0.03639215 0.02776416 0.04502014    1
#> 63  0.05234454 0.04366736 0.06102173    2
#> 64  0.04825126 0.03958281 0.05691971    2
#> 65  0.04971158 0.04105074 0.05837242    2
#> 66  0.04562967 0.03697174 0.05428760    2
#> 67  0.04602292 0.03733920 0.05470665    2
#> 68  0.04805303 0.03941552 0.05669054    2
#> 69  0.04449918 0.03583323 0.05316513    2
#> 70  0.04840185 0.03973479 0.05706890    2
#> 71  0.04891981 0.04029304 0.05754657    2
#> 72  0.04982984 0.04115742 0.05850225    2
#> 73  0.04266409 0.03400092 0.05132725    2
#> 74  0.04879652 0.04011077 0.05748227    2
#> 75  0.04955684 0.04091961 0.05819407    2
#> 76  0.04491653 0.03623578 0.05359728    2
#> 77  0.04999419 0.04134312 0.05864526    2
#> 78  0.04807908 0.03940677 0.05675138    2
#> 79  0.04457268 0.03588689 0.05325846    2
#> 80  0.04661470 0.03793676 0.05529264    2
#> 81  0.04772718 0.03907712 0.05637724    2
#> 82  0.04233853 0.03366794 0.05100912    2
#> 83  0.04769579 0.03903696 0.05635462    2
#> 84  0.05048703 0.04177859 0.05919548    2
#> 85  0.05474296 0.04609814 0.06338778    1
#> 86  0.05008630 0.04134921 0.05882339    2
#> 87  0.04271477 0.03405524 0.05137430    2
#> 88  0.04976926 0.04113457 0.05840395    2
#> 89  0.04940270 0.04072067 0.05808473    2
#> 90  0.04829037 0.03958027 0.05700047    2
#> 91  0.05346272 0.04472864 0.06219680    2
#> 92  0.04607670 0.03735135 0.05480206    2
#> 93  0.04061885 0.03198379 0.04925392    2
#> 94  0.04931144 0.04061505 0.05800784    2
#> 95  0.05090516 0.04222355 0.05958677    2
#> 96  0.03447555 0.02575800 0.04319310    1
#> 97  0.04861778 0.03995317 0.05728239    2
#> 98  0.04313121 0.03446256 0.05179986    2
#> 99  0.04428574 0.03563362 0.05293786    2
#> 100 0.03814475 0.02949402 0.04679547    2
#> 
#> $grafico
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

    #> 
    #> $teste.t
    #> 
    #>  One Sample t-test
    #> 
    #> data:  medias
    #> t = 12.532, df = 399, p-value < 2.2e-16
    #> alternative hypothesis: true mean is not equal to 0
    #> 95 percent confidence interval:
    #>  0.4365693 0.5990183
    #> sample estimates:
    #> mean of x 
    #> 0.5177938
>>>>>>> 4b129ba1bc3762badc9d385002b3ef23d064b4aa
>>>>>>> c2960d036c5d426cacf49b9f8f0b5233afc92db8

### Descrição univariada

``` r
descreve(rnorm(1000))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

    #> rnorm(1000) :  1000  observações 
    #> 
<<<<<<< HEAD
    #> Válidos: 1000     Missings: 0     Soma: -3.33 
    #> Menor: -3.95  Maior: 3.39     Amplitude: 7.35
    #> Média: 0  DP: 1   CV(%): 29951.92
    #> Assimetria: 0.04  Curtose(real): 3.37
    #> Quantis:
    #>  2.5%    5%   25%   50%   75%   95% 97.5% 
    #> -1.92 -1.58 -0.66  0.00  0.65  1.53  2.00 
    #>        IIQ: 1.3
=======
<<<<<<< HEAD
    #> Válidos: 1000     Missings: 0     Soma: -49.02 
    #> Menor: -3     Maior: 3.55     Amplitude: 6.55
    #> Média: -0.05  DP: 1.03    CV(%): 2096.73
    #> Assimetria: -0.03     Curtose(real): 2.66
    #> Quantis:
    #>  2.5%    5%   25%   50%   75%   95% 97.5% 
    #> -2.03 -1.80 -0.78 -0.03  0.69  1.59  1.92 
    #>        IIQ: 1.48
=======
    #> Válidos: 1000     Missings: 0     Soma: -30.83 
    #> Menor: -2.98  Maior: 3.52     Amplitude: 6.5
    #> Média: -0.03  DP: 0.99    CV(%): 3200.95
    #> Assimetria: 0.03  Curtose(real): 2.85
    #> Quantis:
    #>  2.5%    5%   25%   50%   75%   95% 97.5% 
    #> -1.97 -1.61 -0.70 -0.04  0.67  1.58  1.96 
    #>        IIQ: 1.37
>>>>>>> 4b129ba1bc3762badc9d385002b3ef23d064b4aa
>>>>>>> c2960d036c5d426cacf49b9f8f0b5233afc92db8
    histobox(rnorm(1000))

<img src="man/figures/README-unnamed-chunk-6-2.png" width="100%" />

``` r

tabuleiro(obitos$RACACOR)
#>       Freq     % Freq.acum %acum
#> 1      760  88.6       760  88.6
#> 2       45   5.2       805  93.8
#> 3        2   0.2       807  94.1
#> 4       49   5.7       856  99.8
#> 5        2   0.2       858 100.0
#> Total  858 100.0       858 100.0
tabuleiro2(obitos$RACACOR)
#>               Freq  %(+NA) % válido % acum
#> 1             "760" "85,2" "88,6"   "88,6"
#> 2             " 45" "5,0"  "5,2"    "93,8"
#> 3             "  2" "0,2"  "0,2"    "94,1"
#> 4             " 49" "5,5"  "5,7"    "99,8"
#> 5             "  2" "0,2"  "0,2"    "100" 
#> Total válidos "858" "96,2" "100"    "˗"   
#> Missing       " 34" "3,8"  "˗"      "˗"   
#> Total         "892" "100"  "˗"      "˗"
```

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->
