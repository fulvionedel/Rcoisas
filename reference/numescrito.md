# Escreve números em texto, em português

Dado um número entre 0 e 12, devolve seu valor em texto em português.

## Usage

``` r
numescrito(x, genero = "masc")
```

## Arguments

- x:

  Número a ser convertido

- genero:

  Gênero do número. Se "fem" ou "f" o número será escrito no feminino.

## Details

Para números negativos ou maiores de 12

## Examples

``` r
numescrito(0)
#> [1] "zero"
numescrito(1)
#> [1] "um"
numescrito(1, genero = 'fem')
#> [1] "uma"
paste(numescrito(2, 'f'), "+", numescrito(3), "=", numescrito(2+3))
#> [1] "duas + três = cinco"
paste(numescrito(3), "-", numescrito(2, 'f'), "=", numescrito(3-2, 'f'))
#> [1] "três - duas = uma"
# Limitações: 0<x<12
numescrito(-2)
#> [1] -2
numescrito(13)
#> [1] 13
numescrito(20)
#> [1] 20
paste(numescrito(6), "+", numescrito(7), "=", numescrito(6+7))
#> [1] "seis + sete = 13"
paste(numescrito(13), "-", numescrito(6), "=", numescrito(13-6))
#> [1] "13 - seis = sete"
```
