Rcoisas
================

- <a href="#instalação" id="toc-instalação">Instalação</a>
- <a href="#exemplos" id="toc-exemplos">Exemplos</a>
  - <a href="#descrição-univariada" id="toc-descrição-univariada">Descrição
    univariada</a>
    - <a href="#variáveis-numéricas" id="toc-variáveis-numéricas">Variáveis
      numéricas</a>
    - <a href="#variáveis-categóricas"
      id="toc-variáveis-categóricas">Variáveis categóricas</a>
  - <a href="#curva-de-nelson-de-moraes"
    id="toc-curva-de-nelson-de-moraes">Curva de Nelson de Moraes</a>
  - <a href="#tabelas-2-times-2" id="toc-tabelas-2-times-2">Tabelas 2 <span
    class="math inline">×</span> 2</a>

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->
<!-- badges: end -->

> **Funções para aulas e apresentação de resultados em português.**

O pacote contém funções com *outputs* em português e bancos de dados
úteis para a produção de gráficos e tabelas para aulas, como a descrição
“completa” de uma variável numérica ou a construção de indicadores de
saúde. Algumas funções são importadas do pacote
[`csapAIH`](https://github.com/fulvionedel/csapAIH) (`fxetar_quinq`,
`fxetar3g`, `ufbr`, `ler_popbr` e `popbr2000_2021`). Veja a ajuda para a
lista completa e detalhamento das funções e bancos de dados no pacote.

# Instalação

O pacote ainda não tem uma primeira versão para ser lançada. A versão de
desenvolvimento pode ser instalada a partir do
[GitHub](https://github.com/) com:

    # install.packages("remotes") # Se o pacote 'remotes' não estiver instalado
    remotes::install_github("fulvionedel/Rcoisas")

# Exemplos

``` r
library(Rcoisas)
```

## Descrição univariada

> Funções `descreve`, `histobox` e `tabuleiro`.

    descreve(x, by = NULL, dec = 2, na.rm = TRUE, data = NULL, histograma = TRUE, breaks = "Sturges", freq = TRUE, main = NULL, xlab = NULL, ylab = NULL, linhas = 2, curva = TRUE, densidade = FALSE, col.dens = 1, col = "yellow2", col.curva = "DarkGreen", col.media = 2, col.dp = col.media, col.mediana = 4, legenda = TRUE, lugar = "topright", lty.curva = 2, lwd.curva = 1, lty.dens = 3, lwd.dens = 2, lty = NULL, lwd = NULL, cex = NULL, print = "output", ...)

### Variáveis numéricas

**A função `descreve`** realiza a descrição “completa” de uma variável
numérica. Por padrão apresenta uma lista com os parâmetros descritos e
um histograma com marcas da distribuição da variável. O histograma pode
ser suprimido e a lista pode ser transformada em `data.frame`.

``` r
descreve(varnum <- rnorm(1000))  
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="48%" style="display: block; margin: auto;" />


     varnum <- rnorm(1000) :  1000  observações 

    Válidos: 1000    Missings: 0     Soma: -18.44 
    Menor: -2.98     Maior: 3.27     Amplitude: 6.25
    Média: -0.02     DP: 0.98    CV(%): 5309.73
    Assimetria: 0.07     Curtose(real): 2.92
    Quantis:
     2.5%    5%   25%   50%   75%   95% 97.5% 
    -1.88 -1.61 -0.70 -0.01  0.66  1.54  1.94 
              IIQ: 1.36 

    descreve(varnum, histograma = FALSE, print = "tabela")
                varnum
    n          1000.00
    Válidos    1000.00
    Missings      0.00
    Menor        -2.98
    Maior         3.27
    Amplitude     6.25
    Soma        -18.44
    Média        -0.02
    Variância     0.96
    DP            0.98
    CV(%)      5309.73
    Assimetria    0.07
    Curtose       2.92
    P2.5         -1.88
    P5           -1.61
    P25          -0.70
    P50          -0.01
    P75           0.66
    P95           1.54
    P97.5         1.94
    IIQ           1.36

O output pode ser guardado em um objeto e depois impresso como lista ou
como tabela (de classe `data.frame`) e usado para captar em texto cada
parâmetro isoladamente.

``` r
x <- descreve(varnum, histograma = FALSE, print = FALSE)
Rcoisas:::print.descreve(x)

 varnum :  1000  observações 

Válidos: 1000    Missings: 0     Soma: -18.44 
Menor: -2.98     Maior: 3.27     Amplitude: 6.25
Média: -0.02     DP: 0.98    CV(%): 5309.73
Assimetria: 0.07     Curtose(real): 2.92
Quantis:
 2.5%    5%   25%   50%   75%   95% 97.5% 
-1.88 -1.61 -0.70 -0.01  0.66  1.54  1.94 
          IIQ: 1.36 

Rcoisas:::print.descreve(x, print = "tabela")
            varnum
n          1000.00
Válidos    1000.00
Missings      0.00
Menor        -2.98
Maior         3.27
Amplitude     6.25
Soma        -18.44
Média        -0.02
Variância     0.96
DP            0.98
CV(%)      5309.73
Assimetria    0.07
Curtose       2.92
P2.5         -1.88
P5           -1.61
P25          -0.70
P50          -0.01
P75           0.66
P95           1.54
P97.5         1.94
IIQ           1.36

paste("Média de", x$media, "e desvio-padrão de", x$dp, "unidades, configurando um coeficiente de variação de", x$cv, "%.")
[1] "Média de -0.02 e desvio-padrão de 0.98 unidades, configurando um coeficiente de variação de 5309.73 %."
```

O objeto pode ser modificado para sua impressão. O exemplo a seguir usa
outra função do pacote, `formatL()`, para apresentar os valores em
formato latino.

``` r
Rcoisas:::print.descreve(x, print = "tabela") |> 
  tibble::as_tibble(rownames = "parametro") |>
  dplyr::mutate(varnum = formatL(varnum, format = "fg", digits = 3)) |>
  knitr::kable(align = 'r')
```

|  parametro | varnum |
|-----------:|-------:|
|          n |  1.000 |
|    Válidos |  1.000 |
|   Missings |      0 |
|      Menor |  -2,98 |
|      Maior |   3,27 |
|  Amplitude |   6,25 |
|       Soma |  -18,4 |
|      Média |  -0,02 |
|  Variância |   0,96 |
|         DP |   0,98 |
|      CV(%) |  5.310 |
| Assimetria |   0,07 |
|    Curtose |   2,92 |
|       P2.5 |  -1,88 |
|         P5 |  -1,61 |
|        P25 |   -0,7 |
|        P50 |  -0,01 |
|        P75 |   0,66 |
|        P95 |   1,54 |
|      P97.5 |   1,94 |
|        IIQ |   1,36 |

O formato em tabela é pensado para uma análise estratificada por
categorias de um fator. Um argumento `by` está em desenvolvimento e
ainda não funciona adequadamente. 😕

**A função `histobox`** desenha um histograma com um diagrama de caixas
(“*box-plot*”) horizontal acima do gráfico.

``` r
histobox(varnum)
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="48%" style="display: block; margin: auto;" />

### Variáveis categóricas

**As funções `tabuleiro` e `tabuleiro2`** apresentam uma tabela
univariada com frequências absolutas e relativas (%) simples e
acumuladas.

    tabuleiro(x, digits = 1, total = TRUE, cum = TRUE, format = "en", data = NULL, ...)
    tabuleiro2(varcat, digits = 1)

``` r
tabuleiro(RACACOR, data = obitosRS2019)
         Freq     % Freq.acum %acum
Amarela    12   0.1        12   0.1
Branca   8493  88.0      8505  88.1
Indígena   20   0.2      8525  88.3
Parda     555   5.7      9080  94.1
Preta     573   5.9      9653 100.0
Total    9653 100.0      9653 100.0
```

Uma tabela para apresentação pode ser feita com a função `kable{knitr}`.
Esta função tem argumentos para apresentar resultados em formato latino,
mas o trabalho pode ser abreviado com a função `formatL{Rcoisas}` –
enquanto o argumento `format` não é implementado. Além disso, a
frequência acumulada aqui não faz muito sentido.

``` r
tab1 <- tabuleiro(RACACOR, data = obitosRS2019, cum = FALSE, digits = 3)
knitr::kable(tab1 |> formatL(format = "fg"), align = 'r')
```

|          |   Freq |   % |
|:---------|-------:|----:|
| Amarela  |     12 | 0,1 |
| Branca   |  8.493 |  88 |
| Indígena |     20 | 0,2 |
| Parda    |    555 |   6 |
| Preta    |    573 |   6 |
| Total    | 10.000 | 100 |

A função foi criada para oferecer axs estudantes um modo fácil de criar
no R uma tabela com essas características e valores em formato latino.
Na sua primeira versão os valores eram pré-formatados, oferecendo a
seguinte tabela:

``` r
(tab2 <- tabuleiro2(obitosRS2019$RACACOR))
              Freq     %(+NA) % válido % acum
Amarela       "    12" "0,1"  "0,1"    "0,1" 
Branca        " 8.493" "84,9" "88,0"   "88,1"
Indígena      "    20" "0,2"  "0,2"    "88,3"
Parda         "   555" "5,5"  "5,7"    "94,1"
Preta         "   573" "5,7"  "5,9"    "100" 
Total válidos " 9.653" "96,5" "100"    "˗"   
Missing       "   347" "3,5"  "˗"      "˗"   
Total         "10.000" "100"  "˗"      "˗"   
```

que pode facilmente formatada com `kable`.

``` r
knitr::kable(tab2, align = 'r')
```

|               |   Freq | %(+NA) | % válido | % acum |
|:--------------|-------:|-------:|---------:|-------:|
| Amarela       |     12 |    0,1 |      0,1 |    0,1 |
| Branca        |  8.493 |   84,9 |     88,0 |   88,1 |
| Indígena      |     20 |    0,2 |      0,2 |   88,3 |
| Parda         |    555 |    5,5 |      5,7 |   94,1 |
| Preta         |    573 |    5,7 |      5,9 |    100 |
| Total válidos |  9.653 |   96,5 |      100 |      ˗ |
| Missing       |    347 |    3,5 |        ˗ |      ˗ |
| Total         | 10.000 |    100 |        ˗ |      ˗ |

Mas os valores da tabela estão em formato caractere e não numérico, o
que impede a execução de operações matemáticas. Por isso foi rebatizada
de `tabuleiro2` e seu desenvolvimento descontinuado. Está no pacote
porque ainda a tenho em várias aulas 😪. É desaconselhável seu uso em
novos scripts.

## Curva de Nelson de Moraes

    fxetarNM(idade = NULL, fxetardet = NULL)

**A função `fxetarNM`** agrega um vetor com a idade ou com a “faixa
etária detalhada” (classificação do DATASUS) segundo as categorias da
Curva de Nelson de Moraes (\< 1, 1-4, 5-19, 20-49, 50 e +).

O gráfico pode ser rapidamente produzido desenhando o resultado de
`prop.table` e `table` sobre `fxetarNM(x)`.

``` r
plot(
  prop.table(table(
    fxetarNM(obitosRS2019$idade)
    ))*100, 
  type = 'l', ylab = "%", xlab = "faixa etária", 
  main = "Curva de Nelson de Moraes. RS, 2019.",
  sub = "\nAmostra aleatória de 10.000 óbitos.", col.sub = 2, font.sub = 3, cex.sub = .8)
```

<img src="man/figures/README-unnamed-chunk-14-1.png" width="48%" style="display: block; margin: auto;" />

Neste caso interessam as frequências acumuladas:

``` r
obitosRS2019$idade |>
  fxetarNM() |>
  tabuleiro(total = FALSE) |>
  formatL(format = "fg", digits = 2) |> 
  knitr::kable(align = 'r')
```

|        |  Freq |   % | Freq.acum | %acum |
|:-------|------:|----:|----------:|------:|
| \< 1   |   150 | 1,5 |       150 |   1,5 |
| 1-4    |    23 | 0,2 |       173 |   1,7 |
| 5-19   |   123 | 1,2 |       296 |     3 |
| 20-49  | 1.031 |  10 |     1.327 |    13 |
| 50 e + | 8.663 |  87 |    10.000 |   100 |

## Tabelas 2 $\times$ 2

**A função `bolero`** analisa a tabela de contingências de duas
variáveis dicotômicas. O exemplo a seguir usa um banco de dados do
pacote Rcoisas, com uma amostra aleatória de dez mil registros de óbitos
do RS para comparar a probabilidade de um diagnóstico de causa
cardiovascular e de causa externa segundo o sexo, entre os óbitos. As
causas são classificadas com a função `cid10cap()`, do pacote
[`csapAIH`](https://github.com/fulvionedel/csapAIH).

``` r
obitos <- obitosRS2019[c("sexo", "idade", "RACACOR", "CAUSABAS")]
cardio <- grepl("circulatório", csapAIH::cid10cap(obitos$CAUSABAS)) |>
  factor(levels = c(TRUE, FALSE), labels = c("sim", "não"))
externas <- grepl("externas", csapAIH::cid10cap(obitos$CAUSABAS)) |>
  factor(levels = c(TRUE, FALSE), labels = c("sim", "não"))

tabolero <- bolero(obitos$sexo, cardio)
===============================================================
                  Tabela 2 por 2 
        bolero(independente, dependente, dec=2, dnn) 
--------------------------------------------------------------- 
Var. dependente : cardio = sim 
Var. independente: obitos.sexo = fem 

           cardio
obitos$sexo  sim  não  Sum
       fem  1248 3438 4686
       masc 1226 4086 5312
       Sum  2474 7524 9998

Proporções (%)
           cardio
obitos$sexo  sim  não
       fem  26.6 73.4
       masc 23.1 76.9

Razão de Probabilidades: 1.15 ; IC95% (assintótico): 1.08 1.24 
                                IC95% (exato)      : 1.08 1.23
Razão de Odds          : 1.21 ; IC95% (exato)      : 1.10 1.33
Valor-p: Pearson, Yates: <0,001 ; Fisher: <0,001 
===============================================================
```

Para mudar a categoria de referência mudam-se antes os níveis da
variável. Os rótulos dos nomes das variáveis podem ser modificados com o
argumento `dnn`.

``` r
bolero(factor(obitos$sexo, levels = c("masc", "fem")), externas, 
       dnn = c("sexo", "causas externas"))
===============================================================
                  Tabela 2 por 2 
        bolero(independente, dependente, dec=2, dnn) 
--------------------------------------------------------------- 
Var. dependente : causas.externas = sim 
Var. independente: sexo = masc 

      causas externas
sexo    sim  não  Sum
  masc  628 4684 5312
  fem   183 4503 4686
  Sum   811 9187 9998

Proporções (%)
      causas externas
sexo    sim  não
  masc 11.8 88.2
  fem   3.9 96.1

Razão de Probabilidades: 3.03 ; IC95% (assintótico): 2.58 3.55 
                                IC95% (exato)      : 2.60 3.53
Razão de Odds          : 3.30 ; IC95% (exato)      : 2.78 3.93
Valor-p: Pearson, Yates: <0,001 ; Fisher: <0,001 
===============================================================
```

`bolero` foi escrita há mais de 20 anos e não pode ser impressa com
`kable`, mas os elementos de seu output podem ser recuperados. Veja a
estrutura de seu resultado:

``` r
# Note que acima foi criado o objeto 'tabolero' 
str(tabolero)
List of 14
 $ tab     : 'table' int [1:2, 1:2] 1248 1226 3438 4086
  ..- attr(*, "dimnames")=List of 2
  .. ..$ obitos$sexo: chr [1:2] "fem" "masc"
  .. ..$ cardio     : chr [1:2] "sim" "não"
 $ proptab : 'table' num [1:2, 1:2] 26.6 23.1 73.4 76.9
  ..- attr(*, "dimnames")=List of 2
  .. ..$ obitos$sexo: chr [1:2] "fem" "masc"
  .. ..$ cardio     : chr [1:2] "sim" "não"
 $ RP      : num 1.15
 $ lci.rp  : num 1.08
 $ uci.rp  : num 1.24
 $ OR      : num 1.21
 $ or.ic   : num [1:2] 1.1 1.33
  ..- attr(*, "conf.level")= num 0.95
 $ lci.or  : num 1.1
 $ uci.or  : num 1.33
 $ ft      :List of 7
  ..$ p.value    : num 4.35e-05
  ..$ conf.int   : num [1:2] 1.1 1.33
  .. ..- attr(*, "conf.level")= num 0.95
  ..$ estimate   : Named num 1.21
  .. ..- attr(*, "names")= chr "odds ratio"
  ..$ null.value : Named num 1
  .. ..- attr(*, "names")= chr "odds ratio"
  ..$ alternative: chr "two.sided"
  ..$ method     : chr "Fisher's Exact Test for Count Data"
  ..$ data.name  : chr "tab"
  ..- attr(*, "class")= chr "htest"
 $ qui2    :List of 9
  ..$ statistic: Named num 16.7
  .. ..- attr(*, "names")= chr "X-squared"
  ..$ parameter: Named int 1
  .. ..- attr(*, "names")= chr "df"
  ..$ p.value  : num 4.41e-05
  ..$ method   : chr "Pearson's Chi-squared test with Yates' continuity correction"
  ..$ data.name: chr "tab"
  ..$ observed : 'table' int [1:2, 1:2] 1248 1226 3438 4086
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ obitos$sexo: chr [1:2] "fem" "masc"
  .. .. ..$ cardio     : chr [1:2] "sim" "não"
  ..$ expected : num [1:2, 1:2] 1160 1314 3526 3998
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ obitos$sexo: chr [1:2] "fem" "masc"
  .. .. ..$ cardio     : chr [1:2] "sim" "não"
  ..$ residuals: 'table' num [1:2, 1:2] 2.6 -2.44 -1.49 1.4
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ obitos$sexo: chr [1:2] "fem" "masc"
  .. .. ..$ cardio     : chr [1:2] "sim" "não"
  ..$ stdres   : 'table' num [1:2, 1:2] 4.11 -4.11 -4.11 4.11
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ obitos$sexo: chr [1:2] "fem" "masc"
  .. .. ..$ cardio     : chr [1:2] "sim" "não"
  ..- attr(*, "class")= chr "htest"
 $ p.qui2  : num 4.41e-05
 $ p.Fisher: num 4.35e-05
 $ resumo  : 'table' num [1, 1:4] 1.15 1.08 1.24 0
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr "cardio"
  .. ..$ : chr [1:4] "RP" "IC95inf" "IC95sup" "p"
```

Assim podemos dizer, por exemplo, que a probabilidade de que a causa
básica de óbito seja cardiovascular é 15% maior no sexo feminino que no
masculino (RP = 1,15; IC<sub>95</sub> 1,08 a 1,24). Veja abaixo o código
utilizado:

> \[…\] cardiovascular é `formatL((tabolero$RP-1)*100, digits = 0)`%
> maior no sexo feminino que no masculino (RP =
> `formatL(tabolero$RP, 2)`; IC<sub>95</sub>
> `formatL(tabolero$lci.rp, 2)` a `formatL(tabolero$uci.rp, 2)`).

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->
