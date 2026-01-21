# Gráfico da probabilidade de pertencer a uma área da curva Normal

Gráfico da probabilidade de pertencer a uma área da curva Normal

## Usage

``` r
plotZ(
  x = NULL,
  mu = 0,
  dp = 1,
  p = NULL,
  z = NULL,
  cor = 2,
  main = NULL,
  sub = NULL,
  area = "abaixo",
  cex.main = 2,
  cex.sub = 1.5,
  cex.axis = 1.3,
  ...
)
```

## Arguments

- x:

  valor a comparar com a média

- mu:

  média

- dp:

  desvio-padrão

- p:

  probabilidade

- z:

  escore-z

- cor:

  cor do preenchimento da área sob a curva

- main:

  título

- sub:

  subtítulo

- area:

  "abaixo" (padrão) calcula e desenha a probabilidade de um valor menor
  ou igual a x, p ou z; "acima" calcula e desenha a probabilidade de um
  valor maior que x, p ou z

- cex.main:

  tamanho da fonte do título

- cex.sub:

  tamanho da fonte do subtítulo

- cex.axis:

  tamanho da fonte do eixo

- ...:

  Permite o uso de outros parâmetros gráficos

## Value

O gráfico (objeto de classe `NULL`) com a área de probabilidade
achurada.

## Examples

``` r
plotZ(p = .975)

#> [[1]]
#> P(X <= "1,96") == "0,975"
#> 
#> $x
#> [1] 1.959964
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.975
#> 
#> $z
#> NULL
#> 
plotZ(p = .025)

#> [[1]]
#> P(X <= "-1,96") == "0,025"
#> 
#> $x
#> [1] -1.959964
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.025
#> 
#> $z
#> NULL
#> 
plotZ(z = 1.96)

#> [[1]]
#> P(Z <= "1,96") == "0,975"
#> 
#> $x
#> NULL
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.9750021
#> 
#> $z
#> [1] 1.96
#> 
plotZ(z = -1.96)

#> [[1]]
#> P(Z <= "-1,96") == "0,025"
#> 
#> $x
#> NULL
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.0249979
#> 
#> $z
#> [1] -1.96
#> 
plotZ(p = .975, area = "acima")

#> [[1]]
#> P(X > "1,96") == "0,025"
#> 
#> $x
#> [1] 1.959964
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.975
#> 
#> $z
#> NULL
#> 
plotZ(p = .025, area = "acima")

#> [[1]]
#> P(X > "-1,96") == "0,975"
#> 
#> $x
#> [1] -1.959964
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.025
#> 
#> $z
#> NULL
#> 
plotZ(z = 1.96, area = "acima")

#> [[1]]
#> P(Z > "1,96") == "0,025"
#> 
#> $x
#> NULL
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.9750021
#> 
#> $z
#> [1] 1.96
#> 
plotZ(z = -1.96, area = "acima")

#> [[1]]
#> P(Z > "-1,96") == "0,975"
#> 
#> $x
#> NULL
#> 
#> $media
#> [1] 0
#> 
#> $dp
#> [1] 1
#> 
#> $p
#> [1] 0.0249979
#> 
#> $z
#> [1] -1.96
#> 
plotZ(x = 10, mu = 4.7, dp = 2.7, cor = "yellow")

#> [[1]]
#> P(Z <= "1,96") == "0,975"
#> 
#> $x
#> [1] 10
#> 
#> $media
#> [1] 4.7
#> 
#> $dp
#> [1] 2.7
#> 
#> $p
#> [1] 0.9751748
#> 
#> $z
#> [1] 1.962963
#> 
plotZ(x = 10, mu = 4.7, dp = 2.7, area = "acima")

#> [[1]]
#> P(Z > "1,96") == "0,025"
#> 
#> $x
#> [1] 10
#> 
#> $media
#> [1] 4.7
#> 
#> $dp
#> [1] 2.7
#> 
#> $p
#> [1] 0.9751748
#> 
#> $z
#> [1] 1.962963
#> 
# plotZ(x = c(8, 10), mu = 4.7, dp = 2.7)
```
