
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
#> [1] -0.02558041
#> 
#> $medias
#>           media      liminf        limsup fora
#> 1   -0.02826711 -0.03783337 -0.0187008583    2
#> 2   -0.03074010 -0.04032129 -0.0211589069    2
#> 3   -0.03381670 -0.04339921 -0.0242341841    2
#> 4   -0.02815659 -0.03771497 -0.0185982178    2
#> 5   -0.02273441 -0.03234118 -0.0131276457    2
#> 6   -0.02564140 -0.03519485 -0.0160879504    2
#> 7   -0.02215559 -0.03180065 -0.0125105283    2
#> 8   -0.02318145 -0.03275338 -0.0136095241    2
#> 9   -0.02489271 -0.03445909 -0.0153263284    2
#> 10  -0.02088911 -0.03049352 -0.0112847094    2
#> 11  -0.02421421 -0.03378738 -0.0146410525    2
#> 12  -0.02072666 -0.03035711 -0.0110962227    2
#> 13  -0.02903961 -0.03860653 -0.0194726802    2
#> 14  -0.02065135 -0.03020894 -0.0110937641    2
#> 15  -0.01483582 -0.02439816 -0.0052734694    1
#> 16  -0.03318470 -0.04278793 -0.0235814659    2
#> 17  -0.02896597 -0.03857842 -0.0193535172    2
#> 18  -0.02034780 -0.02990394 -0.0107916717    2
#> 19  -0.02735608 -0.03694796 -0.0177642117    2
#> 20  -0.02292894 -0.03254153 -0.0133163460    2
#> 21  -0.03190996 -0.04147761 -0.0223423050    2
#> 22  -0.02764317 -0.03721625 -0.0180701022    2
#> 23  -0.02503601 -0.03464549 -0.0154265344    2
#> 24  -0.01827733 -0.02780208 -0.0087525798    2
#> 25  -0.02587109 -0.03546566 -0.0162765186    2
#> 26  -0.02006823 -0.02969607 -0.0104403882    2
#> 27  -0.02968156 -0.03925473 -0.0201083851    2
#> 28  -0.03291392 -0.04251107 -0.0233167746    2
#> 29  -0.02432042 -0.03387558 -0.0147652634    2
#> 30  -0.02456049 -0.03414617 -0.0149747996    2
#> 31  -0.03025607 -0.03984864 -0.0206634914    2
#> 32  -0.02696007 -0.03652968 -0.0173904628    2
#> 33  -0.02587577 -0.03546607 -0.0162854687    2
#> 34  -0.02886764 -0.03846032 -0.0192749566    2
#> 35  -0.02419683 -0.03379217 -0.0146014903    2
#> 36  -0.02868261 -0.03823745 -0.0191277573    2
#> 37  -0.03147390 -0.04110616 -0.0218416457    2
#> 38  -0.02513694 -0.03466964 -0.0156042524    2
#> 39  -0.02406348 -0.03357807 -0.0145488873    2
#> 40  -0.02111787 -0.03072765 -0.0115080853    2
#> 41  -0.02199466 -0.03156590 -0.0124234155    2
#> 42  -0.02176218 -0.03137145 -0.0121529038    2
#> 43  -0.02361736 -0.03317819 -0.0140565353    2
#> 44  -0.02212472 -0.03171188 -0.0125375519    2
#> 45  -0.02423834 -0.03381890 -0.0146577741    2
#> 46  -0.02168961 -0.03128477 -0.0120944519    2
#> 47  -0.03098832 -0.04058020 -0.0213964451    2
#> 48  -0.01689730 -0.02641644 -0.0073781564    2
#> 49  -0.02938265 -0.03895255 -0.0198127643    2
#> 50  -0.02103289 -0.03061973 -0.0114460433    2
#> 51  -0.02272833 -0.03229113 -0.0131655394    2
#> 52  -0.01714588 -0.02671538 -0.0075763730    2
#> 53  -0.02394079 -0.03352060 -0.0143609880    2
#> 54  -0.03203745 -0.04163822 -0.0224366890    2
#> 55  -0.02519687 -0.03476142 -0.0156323176    2
#> 56  -0.02908324 -0.03864439 -0.0195220847    2
#> 57  -0.03500309 -0.04457834 -0.0254278297    2
#> 58  -0.03183195 -0.04142391 -0.0222399915    2
#> 59  -0.02113124 -0.03073149 -0.0115309942    2
#> 60  -0.02221632 -0.03177871 -0.0126539331    2
#> 61  -0.02493913 -0.03450479 -0.0153734600    2
#> 62  -0.02321607 -0.03277831 -0.0136538252    2
#> 63  -0.01950117 -0.02906673 -0.0099356226    2
#> 64  -0.02519188 -0.03478129 -0.0156024781    2
#> 65  -0.02676006 -0.03633491 -0.0171852207    2
#> 66  -0.03486073 -0.04443292 -0.0252885443    2
#> 67  -0.02360444 -0.03322933 -0.0139795450    2
#> 68  -0.02512890 -0.03472753 -0.0155302670    2
#> 69  -0.02540541 -0.03498754 -0.0158232818    2
#> 70  -0.03361970 -0.04318704 -0.0240523606    2
#> 71  -0.02460354 -0.03418007 -0.0150270086    2
#> 72  -0.01039614 -0.02001940 -0.0007728877    1
#> 73  -0.02578591 -0.03538030 -0.0161915249    2
#> 74  -0.03206108 -0.04161577 -0.0225063967    2
#> 75  -0.02551838 -0.03508160 -0.0159551649    2
#> 76  -0.02168631 -0.03125126 -0.0121213577    2
#> 77  -0.02528772 -0.03486622 -0.0157092156    2
#> 78  -0.02432610 -0.03390385 -0.0147483439    2
#> 79  -0.02690850 -0.03658604 -0.0172309700    2
#> 80  -0.02898647 -0.03857706 -0.0193958797    2
#> 81  -0.02716724 -0.03677069 -0.0175637956    2
#> 82  -0.02619826 -0.03575624 -0.0166402682    2
#> 83  -0.02838876 -0.03798376 -0.0187937570    2
#> 84  -0.01603168 -0.02564139 -0.0064219763    2
#> 85  -0.02183454 -0.03139357 -0.0122755139    2
#> 86  -0.03361377 -0.04320777 -0.0240197792    2
#> 87  -0.01913483 -0.02868795 -0.0095817105    2
#> 88  -0.02748166 -0.03708642 -0.0178769058    2
#> 89  -0.01732111 -0.02685876 -0.0077834662    2
#> 90  -0.02827575 -0.03784953 -0.0187019823    2
#> 91  -0.02093529 -0.03050153 -0.0113690476    2
#> 92  -0.02390857 -0.03349293 -0.0143242064    2
#> 93  -0.02874480 -0.03834701 -0.0191425860    2
#> 94  -0.02158814 -0.03115632 -0.0120199548    2
#> 95  -0.02568117 -0.03524854 -0.0161137964    2
#> 96  -0.02246004 -0.03203007 -0.0128900053    2
#> 97  -0.01995018 -0.02950316 -0.0103972020    2
#> 98  -0.02818062 -0.03777353 -0.0185876977    2
#> 99  -0.03090711 -0.04044751 -0.0213667047    2
#> 100 -0.02590038 -0.03550961 -0.0162911441    2
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
    #> t = 10.916, df = 399, p-value < 2.2e-16
    #> alternative hypothesis: true mean is not equal to 0
    #> 95 percent confidence interval:
    #>  0.3903229 0.5617995
    #> sample estimates:
    #> mean of x 
    #> 0.4760612

### Descrição univariada

``` r
descreve(rnorm(1000))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

    #> rnorm(1000) :  1000  observações 
    #> 
    #> Válidos: 1000     Missings: 0     Soma: 1.65 
    #> Menor: -3.21  Maior: 2.87     Amplitude: 6.08
    #> Média: 0  DP: 1   CV(%): 60419.89
    #> Assimetria: -0.13     Curtose(real): 2.95
    #> Quantis:
    #>  2.5%    5%   25%   50%   75%   95% 97.5% 
    #> -2.06 -1.70 -0.63  0.01  0.68  1.52  1.84 
    #>        IIQ: 1.3
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
