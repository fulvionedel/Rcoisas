# Faixa etária nas categorias de Nelson de Moraes

Recodifica vetores com a idade em números inteiros ou em faixas etárias
quinquenais em três grandes faixas etárias: 0-14, 15-59 e 60 e + anos.

## Usage

``` r
fxetarNM(idade = NULL, fxetardet = NULL, grafico = FALSE, ...)
```

## Arguments

- idade:

  Vetor numérico representando a idade em valores contínuos ou inteiros.

- fxetardet:

  Vetor da classe `factor` ou `character` com diferentes categorizações
  de faixa etária disponíveis para tabulação no TABNET ("faixa etária
  detalhada", e outras formas com detalhamento de \< 1 ano, 1 a 4 anos e
  faixas quinquenais ou decenais que permitem o cálculo ) representando
  17 faixas etárias quinquenais, rotuladas conforme o resultado da
  função
  [`csapAIH::fxetar_quinq`](https://fulvionedel.github.io/csapAIH/reference/fxetar_quinq.html)
  (números separados por hífen, sem espaços: "0-4", ..., "75-79", "80 e
  +").

- grafico:

  Vetor lógico, FALSE por padrão. Se TRUE, desenha o gráfico da curva.

- ...:

  Permite a definição de outros parâmetros gráficos.

## Value

*Se fornecida a idade*, devolve um fator com as frequências observada em
cada faixa etária; *se fornecida a faixa etária*, devolve um vetor da
classe caractere com as frequências de cada faixa etária; *se não são
fornecidas nem a idade nem a faixa etária* – com \`fxetarNM()\` –, a
função devolve um vetor com os nomes das faixas etárias.

## Examples

``` r
# Apenas citar os grupos:
fxetarNM()
#> [1] "< 1"    "1-4"    "5-19"   "20-49"  "50 e +"

# Observar a curva na amostra de óbitos no RS em 2019:
## a idade já foi computada, com a função \code{idadeSUS}, do pacote \code{csapAIH}, com
## csapAIH::idadeSUS(obitosRS2019, sis = "SIM")
## Computar as faixas etárias de Nelson de Moraes
fxetarNM(obitosRS2019$idade) |> table()
#> 
#>    < 1    1-4   5-19  20-49 50 e + 
#>    168     25    114   1021   8665 

## Desenhar a curva (podem-se usar os parâmetros gráficos)
fxetarNM(obitosRS2019$idade, grafico = TRUE, 
         col.sub = 4, font.sub = 3, cex.sub = .8, cex.main = .95,
         main = "Curva de Nelson de Moraes. RS, 2019.", 
         sub = "\nAmostra aleatória de 10.000 óbitos.")



# ## Tabela do TABNET
# Os óbitos de residentes do RS em 2021 por faixa etária detalhada podem ser tabulados no TABNET, 
# em http://tabnet.datasus.gov.br/cgi/deftohtm.exe?sim/cnv/obt10rs.def, resultando (em 21/05/2023) 
# na seguinte tabela (http://tabnet.datasus.gov.br/cgi/tabcgi.exe?sim/cnv/obt10rs.def) 
obitosRS2021 <- data.frame(
  fxetar = c("0 a 6 dias", "7 a 27 dias", "28 a 364 dias", "1 a 4 anos", "5 a 9 anos", 
             "10 a 14 anos", "15 a 19 anos", "20 a 24 anos", "25 a 29 anos", "30 a 34 anos", 
             "35 a 39 anos", "40 a 44 anos", "45 a 49 anos", "50 a 54 anos", "55 a 59 anos", 
             "60 a 64 anos", "65 a 69 anos", "70 a 74 anos", "75 a 79 anos", "80 anos e mais", 
             "Idade ignorada"),
  casos = c(623, 267, 304, 232, 110, 151, 603, 1088, 1273, 1716, 2379, 3144, 4195, 5665, 8437, 
            10799, 12937, 14173, 13950, 35610, 66)
)
# Se no TABNET a tabela for salva com a opção "copia como CSV", e depois salva em formato .xlsx, 
# poderia ser lida com o comando
if (FALSE) { # \dontrun{
  obitosRS <- readxl::read_excel("~/Downloads/teste-fxetardet.xlsx", range = "A4:B25")
} # }  
# Com essa tabela, os seguintes comandos desenham a curva de Nelson de Moraes:
xtabs(casos/sum(casos)*100 ~ fxetarNM(fxetardet = obitosRS2021$fxetar), data = obitosRS2021) |>
plot(type = 'l', main = "Curva de Nelson de Moraes.\nRio Grande do Sul, 2021.", 
xlab = "Faixa etária (anos)", ylab = "% dos óbitos")

```
