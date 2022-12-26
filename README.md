
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

<<<<<<< HEAD
### Tabelas 2 $\times$ 2
=======
### Tabelas 2 
>>>>>>> aef3b22b937675d49eb4f07faf33c19436970153

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
<<<<<<< HEAD
#> [1] 0.05869496
#> 
#> $medias
#>          media     liminf     limsup fora
#> 1   0.05377207 0.04475475 0.06278940    2
#> 2   0.06023134 0.05115622 0.06930645    2
#> 3   0.06134795 0.05234070 0.07035520    2
#> 4   0.05472144 0.04568310 0.06375979    2
#> 5   0.05251290 0.04346140 0.06156440    2
#> 6   0.05708298 0.04799022 0.06617575    2
#> 7   0.05868542 0.04957049 0.06780034    2
#> 8   0.06097060 0.05189745 0.07004374    2
#> 9   0.05438111 0.04530760 0.06345462    2
#> 10  0.05266903 0.04358422 0.06175384    2
#> 11  0.06885702 0.05978375 0.07793028    1
#> 12  0.06080131 0.05175809 0.06984452    2
#> 13  0.06607744 0.05702016 0.07513473    2
#> 14  0.05751510 0.04842624 0.06660396    2
#> 15  0.06445476 0.05537251 0.07353701    2
#> 16  0.05755203 0.04849175 0.06661232    2
#> 17  0.06061635 0.05146737 0.06976533    2
#> 18  0.06729954 0.05824051 0.07635857    2
#> 19  0.06160971 0.05253974 0.07067968    2
#> 20  0.05377320 0.04471706 0.06282934    2
#> 21  0.06143981 0.05238899 0.07049063    2
#> 22  0.05458392 0.04549121 0.06367663    2
#> 23  0.05616665 0.04706857 0.06526472    2
#> 24  0.05550517 0.04646332 0.06454701    2
#> 25  0.05978499 0.05073358 0.06883640    2
#> 26  0.05284069 0.04379396 0.06188741    2
#> 27  0.05352061 0.04446894 0.06257229    2
#> 28  0.05432268 0.04524463 0.06340073    2
#> 29  0.05140820 0.04237095 0.06044546    2
#> 30  0.05036703 0.04131013 0.05942393    2
#> 31  0.05445495 0.04538529 0.06352461    2
#> 32  0.05739749 0.04836088 0.06643411    2
#> 33  0.06416000 0.05509811 0.07322190    2
#> 34  0.05670552 0.04766716 0.06574388    2
#> 35  0.05483866 0.04576479 0.06391252    2
#> 36  0.05503000 0.04597571 0.06408429    2
#> 37  0.05781823 0.04876167 0.06687480    2
#> 38  0.05680080 0.04769882 0.06590278    2
#> 39  0.05983734 0.05078399 0.06889068    2
#> 40  0.06018328 0.05113927 0.06922729    2
#> 41  0.06290623 0.05383075 0.07198170    2
#> 42  0.05857298 0.04946700 0.06767896    2
#> 43  0.05734994 0.04828537 0.06641451    2
#> 44  0.06013979 0.05107449 0.06920509    2
#> 45  0.06352635 0.05444437 0.07260833    2
#> 46  0.06720641 0.05817109 0.07624172    2
#> 47  0.05996881 0.05089048 0.06904713    2
#> 48  0.05996418 0.05089409 0.06903427    2
#> 49  0.05107373 0.04199077 0.06015670    2
#> 50  0.05922264 0.05011889 0.06832639    2
#> 51  0.05879009 0.04970887 0.06787131    2
#> 52  0.06029861 0.05123865 0.06935858    2
#> 53  0.05160916 0.04254325 0.06067507    2
#> 54  0.05378402 0.04470617 0.06286186    2
#> 55  0.05847987 0.04942934 0.06753040    2
#> 56  0.06229551 0.05321851 0.07137252    2
#> 57  0.05589905 0.04683622 0.06496187    2
#> 58  0.06385370 0.05478708 0.07292032    2
#> 59  0.05761234 0.04848000 0.06674467    2
#> 60  0.05880360 0.04973822 0.06786898    2
#> 61  0.05677656 0.04771711 0.06583601    2
#> 62  0.06312156 0.05409193 0.07215118    2
#> 63  0.05723916 0.04818189 0.06629644    2
#> 64  0.06703236 0.05795592 0.07610880    2
#> 65  0.05922459 0.05011957 0.06832962    2
#> 66  0.05729690 0.04820512 0.06638869    2
#> 67  0.06730390 0.05823934 0.07636845    2
#> 68  0.05914261 0.05007012 0.06821510    2
#> 69  0.05797955 0.04899028 0.06696882    2
#> 70  0.06738781 0.05831785 0.07645778    2
#> 71  0.05821652 0.04915796 0.06727509    2
#> 72  0.05981740 0.05079335 0.06884145    2
#> 73  0.06138019 0.05234868 0.07041170    2
#> 74  0.05625922 0.04721894 0.06529950    2
#> 75  0.05211689 0.04313419 0.06109959    2
#> 76  0.06035885 0.05131205 0.06940565    2
#> 77  0.06769112 0.05855441 0.07682783    2
#> 78  0.05473896 0.04565803 0.06381990    2
#> 79  0.05532693 0.04626077 0.06439309    2
#> 80  0.05637938 0.04730919 0.06544957    2
#> 81  0.05059209 0.04146460 0.05971958    2
#> 82  0.05241152 0.04336413 0.06145890    2
#> 83  0.06406488 0.05498637 0.07314340    2
#> 84  0.05532794 0.04623343 0.06442245    2
#> 85  0.06392553 0.05489029 0.07296078    2
#> 86  0.05234629 0.04322316 0.06146942    2
#> 87  0.06470728 0.05561134 0.07380322    2
#> 88  0.05830529 0.04924009 0.06737049    2
#> 89  0.06152647 0.05243403 0.07061892    2
#> 90  0.06308189 0.05397941 0.07218438    2
#> 91  0.05930127 0.05018860 0.06841395    2
#> 92  0.05679756 0.04773523 0.06585988    2
#> 93  0.06091399 0.05179420 0.07003379    2
#> 94  0.06466804 0.05557700 0.07375908    2
#> 95  0.06434391 0.05523587 0.07345195    2
#> 96  0.05307787 0.04401461 0.06214113    2
#> 97  0.05742846 0.04839009 0.06646683    2
#> 98  0.06283483 0.05376685 0.07190282    2
#> 99  0.06278297 0.05367300 0.07189293    2
#> 100 0.05266980 0.04360393 0.06173568    2
=======
#> [1] 0.00452078
#> 
#> $medias
#>             media        liminf      limsup fora
#> 1    0.0102158255  0.0014234421 0.019008209    2
#> 2    0.0010533544 -0.0077610164 0.009867725    2
#> 3    0.0023089267 -0.0065433064 0.011161160    2
#> 4    0.0076036000 -0.0012106009 0.016417801    2
#> 5    0.0042826257 -0.0045337762 0.013099028    2
#> 6    0.0026925003 -0.0060864596 0.011471460    2
#> 7    0.0006529614 -0.0081668133 0.009472736    2
#> 8    0.0041294505 -0.0046672659 0.012926167    2
#> 9    0.0003404831 -0.0084118829 0.009092849    2
#> 10   0.0102706505  0.0014350625 0.019106238    2
#> 11   0.0080815528 -0.0007092881 0.016872394    2
#> 12   0.0060255072 -0.0027592183 0.014810233    2
#> 13   0.0033386353 -0.0054720991 0.012149370    2
#> 14   0.0037454858 -0.0050299608 0.012520932    2
#> 15   0.0023456055 -0.0064129839 0.011104195    2
#> 16   0.0061695001 -0.0026430782 0.014982078    2
#> 17   0.0010576687 -0.0078008335 0.009916171    2
#> 18   0.0087082226 -0.0001308565 0.017547302    2
#> 19   0.0048658692 -0.0039057749 0.013637513    2
#> 20   0.0065609059 -0.0023099401 0.015431752    2
#> 21   0.0081666369 -0.0006105483 0.016943822    2
#> 22   0.0058690792 -0.0029706571 0.014708815    2
#> 23   0.0097968547  0.0009694201 0.018624289    2
#> 24  -0.0022635302 -0.0109976721 0.006470612    2
#> 25   0.0038562434 -0.0049841399 0.012696627    2
#> 26   0.0023805974 -0.0063975698 0.011158764    2
#> 27   0.0051551159 -0.0036509392 0.013961171    2
#> 28  -0.0056468803 -0.0144615372 0.003167777    1
#> 29   0.0058534066 -0.0029468971 0.014653710    2
#> 30   0.0112179438  0.0023716977 0.020064190    2
#> 31   0.0022595688 -0.0065517667 0.011070904    2
#> 32   0.0083775631 -0.0004181865 0.017173313    2
#> 33   0.0075354597 -0.0012430409 0.016313960    2
#> 34   0.0165625626  0.0077496679 0.025375457    1
#> 35   0.0019846645 -0.0068066900 0.010776019    2
#> 36   0.0010581260 -0.0077672052 0.009883457    2
#> 37   0.0104257043  0.0016365292 0.019214879    2
#> 38   0.0106025740  0.0017785714 0.019426577    2
#> 39  -0.0025164535 -0.0113053955 0.006272489    2
#> 40   0.0098836822  0.0010657572 0.018701607    2
#> 41   0.0015018910 -0.0072794685 0.010283250    2
#> 42   0.0006858460 -0.0081400304 0.009511722    2
#> 43   0.0103784706  0.0015799906 0.019176951    2
#> 44   0.0023200901 -0.0065077587 0.011147939    2
#> 45  -0.0010307288 -0.0098149404 0.007753483    2
#> 46  -0.0004107188 -0.0092005583 0.008379121    2
#> 47  -0.0038900003 -0.0127031307 0.004923130    2
#> 48   0.0054424782 -0.0033788325 0.014263789    2
#> 49   0.0031527018 -0.0056246387 0.011930042    2
#> 50   0.0066599049 -0.0021187932 0.015438603    2
#> 51   0.0030870312 -0.0056612453 0.011835308    2
#> 52  -0.0005284354 -0.0093325818 0.008275711    2
#> 53   0.0076182417 -0.0012497870 0.016486270    2
#> 54  -0.0052136344 -0.0140284932 0.003601224    1
#> 55   0.0064658320 -0.0022970169 0.015228681    2
#> 56   0.0060016450 -0.0028513412 0.014854631    2
#> 57   0.0042006758 -0.0046305289 0.013031880    2
#> 58  -0.0020259246 -0.0108515139 0.006799665    2
#> 59  -0.0011511765 -0.0099651757 0.007662823    2
#> 60   0.0060018363 -0.0028112872 0.014814960    2
#> 61   0.0085390448 -0.0002884848 0.017366575    2
#> 62  -0.0047776711 -0.0135774024 0.004022060    1
#> 63   0.0023260268 -0.0064908931 0.011142947    2
#> 64   0.0064224396 -0.0024135336 0.015258413    2
#> 65   0.0080675452 -0.0007295627 0.016864653    2
#> 66   0.0015651090 -0.0072235449 0.010353763    2
#> 67  -0.0031898487 -0.0120262286 0.005646531    2
#> 68   0.0004677897 -0.0083537375 0.009289317    2
#> 69   0.0005825122 -0.0082535886 0.009418613    2
#> 70   0.0085544981 -0.0002507750 0.017359771    2
#> 71  -0.0010941047 -0.0099091492 0.007720940    2
#> 72  -0.0035227738 -0.0123016624 0.005256115    2
#> 73   0.0157388695  0.0068992869 0.024578452    1
#> 74  -0.0012681516 -0.0100806210 0.007544318    2
#> 75   0.0106453434  0.0018207808 0.019469906    2
#> 76   0.0053944693 -0.0034169617 0.014205900    2
#> 77   0.0075986841 -0.0011854296 0.016382798    2
#> 78   0.0084457970 -0.0003697071 0.017261301    2
#> 79  -0.0009458769 -0.0097540666 0.007862313    2
#> 80   0.0014858598 -0.0072615689 0.010233288    2
#> 81  -0.0008885623 -0.0097025162 0.007925392    2
#> 82   0.0030756244 -0.0056864384 0.011837687    2
#> 83   0.0105252034  0.0017077293 0.019342677    2
#> 84   0.0013205430 -0.0075076186 0.010148705    2
#> 85   0.0044073704 -0.0043710573 0.013185798    2
#> 86  -0.0004965104 -0.0092826915 0.008289671    2
#> 87   0.0030772413 -0.0057331997 0.011887682    2
#> 88   0.0101890441  0.0013394650 0.019038623    2
#> 89   0.0012239903 -0.0075482332 0.009996214    2
#> 90   0.0097628070  0.0009355025 0.018590112    2
#> 91   0.0126547815  0.0038047598 0.021504803    2
#> 92   0.0061587823 -0.0026574222 0.014974987    2
#> 93   0.0052149897 -0.0035948018 0.014024781    2
#> 94   0.0052138939 -0.0035754141 0.014003202    2
#> 95   0.0007363870 -0.0080340463 0.009506820    2
#> 96   0.0009503588 -0.0078717216 0.009772439    2
#> 97   0.0026588141 -0.0061752561 0.011492884    2
#> 98   0.0069124281 -0.0019370226 0.015761879    2
#> 99   0.0063270955 -0.0025093207 0.015163512    2
#> 100  0.0126831247  0.0038597717 0.021506478    2
>>>>>>> aef3b22b937675d49eb4f07faf33c19436970153
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
<<<<<<< HEAD
    #> t = 12.911, df = 399, p-value < 2.2e-16
    #> alternative hypothesis: true mean is not equal to 0
    #> 95 percent confidence interval:
    #>  0.4590651 0.6239752
    #> sample estimates:
    #> mean of x 
    #> 0.5415201
=======
    #> t = 11.537, df = 399, p-value < 2.2e-16
    #> alternative hypothesis: true mean is not equal to 0
    #> 95 percent confidence interval:
    #>  0.4070878 0.5743174
    #> sample estimates:
    #> mean of x 
    #> 0.4907026
>>>>>>> aef3b22b937675d49eb4f07faf33c19436970153

### Descrição univariada

``` r
descreve(rnorm(1000))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

    #> rnorm(1000) :  1000  observações 
    #> 
<<<<<<< HEAD
    #> Válidos: 1000     Missings: 0     Soma: 37.46 
    #> Menor: -4.19  Maior: 2.74     Amplitude: 6.94
    #> Média: 0.04   DP: 1   CV(%): 2674.87
    #> Assimetria: -0.09     Curtose(real): 3.1
    #> Quantis:
    #>  2.5%    5%   25%   50%   75%   95% 97.5% 
    #> -1.92 -1.59 -0.60  0.04  0.73  1.67  1.91 
    #>        IIQ: 1.32
=======
    #> Válidos: 1000     Missings: 0     Soma: -70.99 
    #> Menor: -3.49  Maior: 2.97     Amplitude: 6.46
    #> Média: -0.07  DP: 1.01    CV(%): 1424.37
    #> Assimetria: 0.05  Curtose(real): 3.05
    #> Quantis:
    #>  2.5%    5%   25%   50%   75%   95% 97.5% 
    #> -2.00 -1.72 -0.74 -0.09  0.59  1.60  1.97 
    #>        IIQ: 1.33
>>>>>>> aef3b22b937675d49eb4f07faf33c19436970153
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
