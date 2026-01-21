# Histograma com boxplot

Desenha um histograma com boxplot integrado ao mesmo gráfico

## Usage

``` r
histobox(
  x,
  limites = NULL,
  col.h = "cyan",
  col.bx = "skyblue1",
  maresq = 4.5,
  mardir = 2.1,
  ...
)
```

## Arguments

- x:

  Uma variável numérica

- limites:

  Limites do eixo x

- col.h:

  Cor do histograma

- col.bx:

  Cor do boxplot

- maresq:

  Margem esquerda do gráfico

- mardir:

  Margem direita do gráfico

- ...:

  Outros parâmetros de [`hist`](https://rdrr.io/r/graphics/hist.html) e
  [`boxplot`](https://rdrr.io/r/graphics/boxplot.html)

## Value

O desenho do gráfico

## Examples

``` r
varnum <- rnorm(1000)
histobox(varnum)

histobox(varnum, ylab = "Frequência")

histobox(varnum, maresq = 2.8)

# Se a margem esquerda for zero, o eixo y é removido:
histobox(varnum, col.h = "tomato", col.bx = "yellow", maresq = 0)

histobox(varnum, col.h = "tomato", col.bx = "yellow", mardir = 0)

histobox(varnum, col.h = "tomato", col.bx = "yellow", maresq = 0, mardir = 0)

```
