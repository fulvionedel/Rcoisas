# Totais de colunas em uma tabela

Em uma tabela, acrescenta uma linha com o total das colunas, ou a soma
dos valores das colunas em linhas selecionadas.

## Usage

``` r
adissoma(tabela, rotulo = "Total")
```

## Arguments

- tabela:

  Objeto de estrutura matricial com no mínimo duas linhas e duas colunas

- rotulo:

  Rótulo para a linha da soma, o padrão é "Total".

## Value

A tabela (de classe `data.frame`) com a linha da soma ao final.

## Details

É análoga a [`colSums`](https://rdrr.io/r/base/colSums.html), mas
identifica as colunas numéricas na tabela e trabalha apenas sobre elas,
sempre com `na.rm = TRUE`, isto é, desconsiderando os missings na soma.

## See also

[`colSums`](https://rdrr.io/r/base/colSums.html)

## Examples

``` r
# Reproduzir uma tabela da mortalidade por "faixa etária detalhada" do DATASUS:
tabela <- "'Faixa Etária det'  Masc  Fem  Ign Total
                 '0 a 6 dias'   361   257   5   623
                '7 a 27 dias'   156   111   -   267
              '28 a 364 dias'   155   148   1   304
                 '1 a 4 anos'   144    88   -   232
                 '5 a 9 anos'    64    46   -   110
               '10 a 14 anos'    83    68   -   151
               '15 a 19 anos'   462   141   -   603
               '20 a 24 anos'   817   271   -  1088
               '25 a 29 anos'   880   393   -  1273
               '30 a 34 anos'  1155   561   -  1716
               '35 a 39 anos'  1508   870   1  2379
               '40 a 44 anos'  1954  1190   -  3144
               '45 a 49 anos'  2514  1681   -  4195
               '50 a 54 anos'  3488  2175   2  5665
               '55 a 59 anos'  5170  3265   2  8437
               '60 a 64 anos'  6557  4240   2 10799
               '65 a 69 anos'  7566  5370   1 12937
               '70 a 74 anos'  7989  6181   3 14173
               '75 a 79 anos'  7438  6508   4 13950
             '80 anos e mais' 14444 21159   7 35610"
tabela <- read.table(header = TRUE, na.strings = "-", text = tabela)
adissoma(tabela)
#>    Faixa.Etária.det  Masc   Fem Ign  Total
#> 1        0 a 6 dias   361   257   5    623
#> 2       7 a 27 dias   156   111  NA    267
#> 3     28 a 364 dias   155   148   1    304
#> 4        1 a 4 anos   144    88  NA    232
#> 5        5 a 9 anos    64    46  NA    110
#> 6      10 a 14 anos    83    68  NA    151
#> 7      15 a 19 anos   462   141  NA    603
#> 8      20 a 24 anos   817   271  NA   1088
#> 9      25 a 29 anos   880   393  NA   1273
#> 10     30 a 34 anos  1155   561  NA   1716
#> 11     35 a 39 anos  1508   870   1   2379
#> 12     40 a 44 anos  1954  1190  NA   3144
#> 13     45 a 49 anos  2514  1681  NA   4195
#> 14     50 a 54 anos  3488  2175   2   5665
#> 15     55 a 59 anos  5170  3265   2   8437
#> 16     60 a 64 anos  6557  4240   2  10799
#> 17     65 a 69 anos  7566  5370   1  12937
#> 18     70 a 74 anos  7989  6181   3  14173
#> 19     75 a 79 anos  7438  6508   4  13950
#> 20   80 anos e mais 14444 21159   7  35610
#> 21            Total 62905 54723  28 117656
# Somar a faixa de 0-4 anos:
tabela2 <- rbind(adissoma(tabela[1:4,], rotulo = "0 a 4 anos")[5,],
                 tabela[-c(1:4),])
adissoma(tabela2) 
#>    Faixa.Etária.det  Masc   Fem Ign  Total
#> 1        0 a 4 anos   816   604   6   1426
#> 2        5 a 9 anos    64    46  NA    110
#> 3      10 a 14 anos    83    68  NA    151
#> 4      15 a 19 anos   462   141  NA    603
#> 5      20 a 24 anos   817   271  NA   1088
#> 6      25 a 29 anos   880   393  NA   1273
#> 7      30 a 34 anos  1155   561  NA   1716
#> 8      35 a 39 anos  1508   870   1   2379
#> 9      40 a 44 anos  1954  1190  NA   3144
#> 10     45 a 49 anos  2514  1681  NA   4195
#> 11     50 a 54 anos  3488  2175   2   5665
#> 12     55 a 59 anos  5170  3265   2   8437
#> 13     60 a 64 anos  6557  4240   2  10799
#> 14     65 a 69 anos  7566  5370   1  12937
#> 15     70 a 74 anos  7989  6181   3  14173
#> 16     75 a 79 anos  7438  6508   4  13950
#> 17   80 anos e mais 14444 21159   7  35610
#> 18            Total 62905 54723  28 117656
# Pode-se ter o mesmo resultado com 'colSums()', mas com mais trabalho: 
cbind("Faixa etária" = c(tabela2[[1]], "Total"), 
      rbind(tabela2[-1], colSums(tabela2[-1], na.rm = TRUE)))
#>       Faixa etária  Masc   Fem Ign  Total
#> 5       0 a 4 anos   816   604   6   1426
#> 51      5 a 9 anos    64    46  NA    110
#> 6     10 a 14 anos    83    68  NA    151
#> 7     15 a 19 anos   462   141  NA    603
#> 8     20 a 24 anos   817   271  NA   1088
#> 9     25 a 29 anos   880   393  NA   1273
#> 10    30 a 34 anos  1155   561  NA   1716
#> 11    35 a 39 anos  1508   870   1   2379
#> 12    40 a 44 anos  1954  1190  NA   3144
#> 13    45 a 49 anos  2514  1681  NA   4195
#> 14    50 a 54 anos  3488  2175   2   5665
#> 15    55 a 59 anos  5170  3265   2   8437
#> 16    60 a 64 anos  6557  4240   2  10799
#> 17    65 a 69 anos  7566  5370   1  12937
#> 18    70 a 74 anos  7989  6181   3  14173
#> 19    75 a 79 anos  7438  6508   4  13950
#> 20  80 anos e mais 14444 21159   7  35610
#> 181          Total 62905 54723  28 117656

```
