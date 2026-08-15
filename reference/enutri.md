# Classificação do estado nutricional de adultos

Classifica o estado nutricional da pessoa segundo valores do Índice de
Massa Corporal (IMC), usando os pontos de corte propostos pela
Organização Mundial da Saúde. Pode ser informado um vetor com valores do
IMC ou um vetor com o peso (Kg) e outro com altura (m^2).

## Usage

``` r
enutri(data = NULL, peso, altura, imc = NULL)
```

## Arguments

- data:

  Banco de dados com a(s) variável(is)

- peso:

  Peso em Kg

- altura:

  Altura em m

- imc:

  Índice de Massa Corporal

## Value

Um fator com as categorias "Baixo peso", "Eutrófico", "Sobrepeso" ou
"Obesidade".

## Examples

``` r
data("hasdm") 
enutri(hasdm) |> 
  tabuleiro()
#>            Freq     % Freq.acum %acum
#> Baixo peso    4   1.0         4   1.0
#> Eutrófico   116  30.4       120  31.4
#> Sobrepeso   154  40.3       274  71.7
#> Obesidade   108  28.3       382 100.0
#> Total       382 100.0       382 100.0
```
