# Transforma a "faixa etária detalhada" (DATASUS) em 17 faixas quinquenais.

Reclassifica as idades \< 20 anos em faixas etárias quinquenais, para
ter um vetor com as mesmas categorias da "faixa etária detalhada" de
algumas tabulações do DATASUS. *Note* que não é a "faixa etária
detalhada" dos arquivos das estimativas populacionais após o Censo de
2022.

## Usage

``` r
fxetar.det_pra_fxetar5(x, tipo = "POPBR")
```

## Arguments

- x:

  Um vetor com a idade categorizada segundo: (1) os arquivos de
  população "POPBR??.DBF" (até o ano 2012) disponibilizados pelo
  DATASUS, ou (2) um `data.frame` com o resultado de uma tabulação com a
  opção "Faixa etária detalhada" no TABNET ou TabWin (v. detalhes)

- tipo:

  Argumento obrigatório indicando a origem dos dados, se um arquivo de
  população do DATASUS ou uma tabulação do TABNET ou TabWin
  (`tipo = "tabela"`). O padrão é `tipo = "POPBR"`. V. detalhes.

## Value

Se `tipo = "POPBR"`, um vetor da classe `character` com a idade
categorizada em 17 faixas etárias: quinquenais de 0 a 79 anos e 80 e +
anos de idade. Se `tipo = "tabela"`, uma tabela (de classe `data.frame`)
com a "faixa etária detalhada" agregada nessas 17 faixas etárias.

## Details

Os arquivos "POPBR??.DBF" têm a idade em anos completos até 19 anos,
faixas quinquenais de 20-24 até 75-79 anos e 80 e + anos. A "faixa
etária detalhada" é uma opção de tabulação dos dados de mortalidade nos
aplicativos TABNET
(https://datasus.saude.gov.br/informacoes-de-saude-tabnet/) e TabWin, do
DATASUS. A idade é detalhada nos componentes da Taxa de Mortalidade
Infantil, \< 1 ano não especificado, 1-4 anos, faixas quinquenais dos 5
aos 79 anos e 80 e mais. Nas opções de tabulação on-line da "morbidade
hospitalar", esses mesmos cortes são usados para a definição da "Faixa
Etária 2".

## Examples

``` r
data("POPBR12")
str(POPBR12)
#> 'data.frame':    367290 obs. of  6 variables:
#>  $ MUNIC_RES: int  110001 110001 110001 110001 110001 110001 110001 110001 110001 110001 ...
#>  $ ANO      : int  2012 2012 2012 2012 2012 2012 2012 2012 2012 2012 ...
#>  $ SEXO     : int  1 1 1 1 1 1 1 1 1 1 ...
#>  $ SITUACAO : int  3 3 3 3 3 3 3 3 3 3 ...
#>  $ FXETARIA : int  0 101 202 303 404 505 606 707 808 909 ...
#>  $ POPULACAO: int  187 186 187 190 193 198 204 211 219 226 ...
xtabs(POPULACAO ~ FXETARIA + SEXO, POPBR12)
#>         SEXO
#> FXETARIA       1       2
#>     0    1463815 1416101
#>     101  1426466 1379228
#>     202  1410325 1362640
#>     303  1412511 1363667
#>     404  1430272 1379568
#>     505  1460627 1407883
#>     606  1500707 1445796
#>     707  1547704 1490586
#>     808  1598586 1539797
#>     909  1650850 1590611
#>     1010 1706560 1645204
#>     1111 1768360 1705705
#>     1212 1806832 1745525
#>     1313 1808281 1752494
#>     1414 1785934 1738274
#>     1515 1765545 1726191
#>     1616 1741144 1710797
#>     1717 1726027 1703022
#>     1818 1729077 1710345
#>     1919 1743206 1726691
#>     2024 8782606 8766636
#>     2529 8610952 8795610
#>     3034 7853458 8166586
#>     3539 6883541 7243527
#>     4044 6427350 6800153
#>     4549 5785459 6240934
#>     5054 4912910 5389329
#>     5559 3963556 4441120
#>     6064 3087312 3520063
#>     6569 2256975 2654866
#>     7074 1691406 2103802
#>     7579 1105881 1493580
#>     8099 1148647 1827317
POPBR12$FXETAR5 <- fxetar.det_pra_fxetar5(POPBR12$FXETARIA)
str(POPBR12)
#> 'data.frame':    367290 obs. of  7 variables:
#>  $ MUNIC_RES: int  110001 110001 110001 110001 110001 110001 110001 110001 110001 110001 ...
#>  $ ANO      : int  2012 2012 2012 2012 2012 2012 2012 2012 2012 2012 ...
#>  $ SEXO     : int  1 1 1 1 1 1 1 1 1 1 ...
#>  $ SITUACAO : int  3 3 3 3 3 3 3 3 3 3 ...
#>  $ FXETARIA : int  0 101 202 303 404 505 606 707 808 909 ...
#>  $ POPULACAO: int  187 186 187 190 193 198 204 211 219 226 ...
#>  $ FXETAR5  : chr  "00-04" "00-04" "00-04" "00-04" ...
xtabs(POPULACAO ~ FXETAR5 + SEXO, POPBR12)
#>        SEXO
#> FXETAR5       1       2
#>   00-04 7143389 6901204
#>   05-09 7758474 7474673
#>   10-14 8875967 8587202
#>   15-19 8704999 8577046
#>   20-24 8782606 8766636
#>   25-29 8610952 8795610
#>   30-34 7853458 8166586
#>   35-39 6883541 7243527
#>   40-44 6427350 6800153
#>   45-49 5785459 6240934
#>   50-54 4912910 5389329
#>   55-59 3963556 4441120
#>   60-64 3087312 3520063
#>   65-69 2256975 2654866
#>   70-74 1691406 2103802
#>   75-79 1105881 1493580
#>   80e+  1148647 1827317
# Um arquivo csv de uma tabulação da Declaração de Óbito no TABNET 
# (residentes no RS, 2021):
if (FALSE) { # \dontrun{
df <- read.csv2("sim_cnv_obt10rs195350189_4_122_229.csv", 
                skip = 3, nrows = 21, encoding = "latin1") |>
  dplyr::select(-Ign) |> 
  fxetar.det_pra_fxetar5(tipo = 'tabela')
} # }
# Os valores são os seguintes:
dors21 <- data.frame(
 fxetar.det = c("0 a 6 dias", "7 a 27 dias", "28 a 364 dias", "1 a 4 anos",
           "5 a 9 anos", "10 a 14 anos", "15 a 19 anos", "20 a 24 anos",  
           "25 a 29 anos", "30 a 34 anos", "35 a 39 anos", "40 a 44 anos",  
           "45 a 49 anos",  "50 a 54 anos",  "55 a 59 anos", "60 a 64 anos",  
           "65 a 69 anos", "70 a 74 anos", "75 a 79 anos", "80 anos e mais"), 
  masc = c(361, 156, 155, 144, 64, 83, 462, 817, 880, 1155, 1508, 1954, 2514,
           3488, 5170, 6557, 7566, 7989, 7438, 14444),
  fem = c(257, 111, 148, 88, 46, 68, 141, 271, 393, 561, 870, 1190, 1681, 
          2175, 3265, 4240, 5370, 6181, 6508, 21159))
dors21
#>        fxetar.det  masc   fem
#> 1      0 a 6 dias   361   257
#> 2     7 a 27 dias   156   111
#> 3   28 a 364 dias   155   148
#> 4      1 a 4 anos   144    88
#> 5      5 a 9 anos    64    46
#> 6    10 a 14 anos    83    68
#> 7    15 a 19 anos   462   141
#> 8    20 a 24 anos   817   271
#> 9    25 a 29 anos   880   393
#> 10   30 a 34 anos  1155   561
#> 11   35 a 39 anos  1508   870
#> 12   40 a 44 anos  1954  1190
#> 13   45 a 49 anos  2514  1681
#> 14   50 a 54 anos  3488  2175
#> 15   55 a 59 anos  5170  3265
#> 16   60 a 64 anos  6557  4240
#> 17   65 a 69 anos  7566  5370
#> 18   70 a 74 anos  7989  6181
#> 19   75 a 79 anos  7438  6508
#> 20 80 anos e mais 14444 21159
fxetar.det_pra_fxetar5(dors21, tipo = "tabela")
#> # A tibble: 17 × 3
#>    fxetar5  masc   fem
#>    <fct>   <dbl> <dbl>
#>  1 0-4       816   604
#>  2 5-9        83    68
#>  3 10-14     462   141
#>  4 15-19     817   271
#>  5 20-24     880   393
#>  6 25-29    1155   561
#>  7 30-34    1508   870
#>  8 35-39    1954  1190
#>  9 40-44    2514  1681
#> 10 45-49      64    46
#> 11 50-54    3488  2175
#> 12 55-59    5170  3265
#> 13 60-64    6557  4240
#> 14 65-69    7566  5370
#> 15 70-74    7989  6181
#> 16 75-79    7438  6508
#> 17 80e+    14444 21159

dors21$total <- dors21$masc + dors21$fem
fxetar.det_pra_fxetar5(dors21, tipo = "tabela")
#> # A tibble: 17 × 4
#>    fxetar5  masc   fem total
#>    <fct>   <dbl> <dbl> <dbl>
#>  1 0-4       816   604  1420
#>  2 5-9        83    68   151
#>  3 10-14     462   141   603
#>  4 15-19     817   271  1088
#>  5 20-24     880   393  1273
#>  6 25-29    1155   561  1716
#>  7 30-34    1508   870  2378
#>  8 35-39    1954  1190  3144
#>  9 40-44    2514  1681  4195
#> 10 45-49      64    46   110
#> 11 50-54    3488  2175  5663
#> 12 55-59    5170  3265  8435
#> 13 60-64    6557  4240 10797
#> 14 65-69    7566  5370 12936
#> 15 70-74    7989  6181 14170
#> 16 75-79    7438  6508 13946
#> 17 80e+    14444 21159 35603
```
