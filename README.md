
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

### Demonstração do intervalo de confiança

``` r
demonstra_IC(rnorm(384), n = 50000, r = 100)
#> $mediapop
#> [1] -0.0326122
#> 
#> $medias
#>           media      liminf      limsup fora
#> 1   -0.03372670 -0.04203076 -0.02542264    2
#> 2   -0.03531149 -0.04362602 -0.02699695    2
#> 3   -0.03010696 -0.03844995 -0.02176398    2
#> 4   -0.03391704 -0.04224861 -0.02558546    2
#> 5   -0.02900987 -0.03733389 -0.02068585    2
#> 6   -0.03977473 -0.04811687 -0.03143259    2
#> 7   -0.03204612 -0.04038727 -0.02370496    2
#> 8   -0.02658223 -0.03489686 -0.01826760    2
#> 9   -0.04416587 -0.05249785 -0.03583388    1
#> 10  -0.03560765 -0.04395799 -0.02725730    2
#> 11  -0.03538020 -0.04370976 -0.02705064    2
#> 12  -0.03013769 -0.03842680 -0.02184858    2
#> 13  -0.03263417 -0.04096238 -0.02430596    2
#> 14  -0.02999992 -0.03831979 -0.02168006    2
#> 15  -0.03590700 -0.04422379 -0.02759021    2
#> 16  -0.03727776 -0.04559235 -0.02896317    2
#> 17  -0.02988881 -0.03821685 -0.02156076    2
#> 18  -0.02624574 -0.03455520 -0.01793627    2
#> 19  -0.03811775 -0.04644815 -0.02978736    2
#> 20  -0.03280204 -0.04111195 -0.02449213    2
#> 21  -0.04069300 -0.04902663 -0.03235937    2
#> 22  -0.03720627 -0.04553667 -0.02887588    2
#> 23  -0.03434212 -0.04266963 -0.02601462    2
#> 24  -0.03057937 -0.03888358 -0.02227516    2
#> 25  -0.03058588 -0.03890946 -0.02226230    2
#> 26  -0.03181235 -0.04015323 -0.02347148    2
#> 27  -0.03303136 -0.04135241 -0.02471031    2
#> 28  -0.03546508 -0.04377579 -0.02715437    2
#> 29  -0.03072197 -0.03905293 -0.02239101    2
#> 30  -0.02626140 -0.03461077 -0.01791203    2
#> 31  -0.03587872 -0.04424381 -0.02751364    2
#> 32  -0.03580691 -0.04410450 -0.02750933    2
#> 33  -0.03515051 -0.04347470 -0.02682632    2
#> 34  -0.02535021 -0.03367872 -0.01702170    2
#> 35  -0.03313146 -0.04144206 -0.02482087    2
#> 36  -0.03006818 -0.03840581 -0.02173054    2
#> 37  -0.04592202 -0.05428429 -0.03755975    1
#> 38  -0.03855022 -0.04684264 -0.03025781    2
#> 39  -0.03274514 -0.04106785 -0.02442243    2
#> 40  -0.02813983 -0.03646892 -0.01981074    2
#> 41  -0.04200131 -0.05032354 -0.03367909    1
#> 42  -0.03476381 -0.04311042 -0.02641720    2
#> 43  -0.02459220 -0.03287847 -0.01630594    2
#> 44  -0.02850117 -0.03680832 -0.02019403    2
#> 45  -0.03734601 -0.04566560 -0.02902642    2
#> 46  -0.03853566 -0.04689236 -0.03017897    2
#> 47  -0.03837716 -0.04667942 -0.03007490    2
#> 48  -0.03086797 -0.03919722 -0.02253871    2
#> 49  -0.03080884 -0.03910664 -0.02251103    2
#> 50  -0.02951956 -0.03787672 -0.02116240    2
#> 51  -0.03397272 -0.04228937 -0.02565608    2
#> 52  -0.03037206 -0.03868854 -0.02205557    2
#> 53  -0.04000245 -0.04832039 -0.03168451    2
#> 54  -0.02566273 -0.03399648 -0.01732897    2
#> 55  -0.02864512 -0.03696239 -0.02032786    2
#> 56  -0.03583418 -0.04419642 -0.02747194    2
#> 57  -0.04308805 -0.05146566 -0.03471045    1
#> 58  -0.02853181 -0.03684394 -0.02021969    2
#> 59  -0.03051453 -0.03884909 -0.02217997    2
#> 60  -0.02692368 -0.03522899 -0.01861837    2
#> 61  -0.02313335 -0.03145180 -0.01481489    1
#> 62  -0.02782306 -0.03617638 -0.01946975    2
#> 63  -0.03446557 -0.04280437 -0.02612677    2
#> 64  -0.03252688 -0.04083935 -0.02421440    2
#> 65  -0.02989079 -0.03824122 -0.02154035    2
#> 66  -0.03160227 -0.03990694 -0.02329761    2
#> 67  -0.03403856 -0.04232912 -0.02574800    2
#> 68  -0.02553184 -0.03384018 -0.01722350    2
#> 69  -0.03246465 -0.04077903 -0.02415026    2
#> 70  -0.02739697 -0.03571145 -0.01908250    2
#> 71  -0.03640845 -0.04475512 -0.02806178    2
#> 72  -0.02682181 -0.03517393 -0.01846969    2
#> 73  -0.02993678 -0.03825799 -0.02161558    2
#> 74  -0.03024652 -0.03862347 -0.02186956    2
#> 75  -0.02950267 -0.03781606 -0.02118927    2
#> 76  -0.03493083 -0.04323238 -0.02662928    2
#> 77  -0.03231080 -0.04064157 -0.02398003    2
#> 78  -0.03336768 -0.04174405 -0.02499131    2
#> 79  -0.04293584 -0.05127091 -0.03460077    1
#> 80  -0.02636713 -0.03467818 -0.01805609    2
#> 81  -0.03127363 -0.03957878 -0.02296849    2
#> 82  -0.02639237 -0.03469778 -0.01808697    2
#> 83  -0.03132072 -0.03963466 -0.02300679    2
#> 84  -0.03701840 -0.04533318 -0.02870362    2
#> 85  -0.03533765 -0.04363058 -0.02704471    2
#> 86  -0.03775339 -0.04604424 -0.02946254    2
#> 87  -0.02469878 -0.03302783 -0.01636973    2
#> 88  -0.02759474 -0.03592575 -0.01926373    2
#> 89  -0.03551542 -0.04386760 -0.02716323    2
#> 90  -0.02945920 -0.03777315 -0.02114525    2
#> 91  -0.03898428 -0.04728899 -0.03067957    2
#> 92  -0.03266089 -0.04098004 -0.02434174    2
#> 93  -0.03209186 -0.04036603 -0.02381768    2
#> 94  -0.03117603 -0.03947178 -0.02288029    2
#> 95  -0.02635411 -0.03465638 -0.01805184    2
#> 96  -0.03140595 -0.03977194 -0.02303996    2
#> 97  -0.03425573 -0.04258190 -0.02592956    2
#> 98  -0.03473876 -0.04304141 -0.02643612    2
#> 99  -0.03035233 -0.03867935 -0.02202532    2
#> 100 -0.03462391 -0.04293099 -0.02631683    2
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
    #> t = 10.666, df = 399, p-value < 2.2e-16
    #> alternative hypothesis: true mean is not equal to 0
    #> 95 percent confidence interval:
    #>  0.3756437 0.5454015
    #> sample estimates:
    #> mean of x 
    #> 0.4605226

### Descrição univariada

``` r
descreve(rnorm(1000))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

    #> rnorm(1000) :  1000  observações 
    #> 
    #> Válidos: 1000     Missings: 0     Soma: 38.82 
    #> Menor: -3.31  Maior: 3.51     Amplitude: 6.83
    #> Média: 0.04   DP: 1   CV(%): 2563.68
    #> Assimetria: 0.1   Curtose(real): 3.07
    #> Quantis:
    #>  2.5%    5%   25%   50%   75%   95% 97.5% 
    #> -1.86 -1.62 -0.61  0.06  0.68  1.75  2.05 
    #>        IIQ: 1.29
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
