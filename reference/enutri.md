# Classificação do estado nutricional de adultos

Classifica o estado nutricional da pessoa segundo valores do Índice de
Massa Corporal (IMC), usando os pontos de corte propostos pela
Organização Mundial da Saúde. Pode ser informado um vetor com valores do
IMC ou um vetor com o peso (Kg) e outro com altura (m^2).

## Usage

``` r
enutri(data = NULL, peso, altura, imc = NULL, cortes = "MS", idoso = FALSE)
```

## Arguments

- data:

  Banco de dados com a(s) variável(is). Argumento opcional.

- peso:

  Peso em Kg. Argumento obrigatório se não for informado o argumento
  `imc`.

- altura:

  Altura em metros (m). Argumento obrigatório se não for informado o
  argumento `imc`.

- imc:

  Índice de Massa Corporal. Argumento obrigatório se não forem
  informados os argumentos `peso` e `altura`.

- cortes:

  Categorias (pontos de corte) do estado nutricional.

  - "`MS`" (padrão) utiliza as definidas pelo Ministério da Saúde
    brasileiro (Abaixo do peso", Eutrófico, Sobrepeso, Obesidade grau I,
    Obesidade grau II e Obesidade grau III);

  - "`OMS`" utiliza as definidas pela Organização mundial da Saúde
    (Magreza, Baixo peso, Eutrófico, Sobrepeso e Obesidade);

  - "`3cat`" agrupa o peso baixo e o eutrófico em peso normal e
    identifica o sobrepeso e obesidade.

- idoso:

  Argumento lógico. Adaptar a definição de eutrofia para idoso? O padrão
  é `FALSE`.

## Value

Um fator com a classificação do IMC segundo as categorias definidas.

## Examples

``` r
data("hasdm") 
enutri(hasdm) |> 
  tabuleiro()
#>                Freq     % Freq.acum %acum
#> Abaixo do peso    4   1.0         4   1.0
#> Eutrófico       116  30.4       120  31.4
#> Sobrepeso       154  40.3       274  71.7
#> Obesidade I      74  19.4       348  91.1
#> Obesidade II     16   4.2       364  95.3
#> Obesidade III    18   4.7       382 100.0
#> Total           382 100.0       382 100.0
hasdm |> 
  enutri(cortes = "OMS") |> 
   tabuleiro()
#>            Freq     % Freq.acum %acum
#> Magreza       1   0.3         1   0.3
#> Baixo peso    3   0.8         4   1.0
#> Eutrófico   116  30.4       120  31.4
#> Sobrepeso   154  40.3       274  71.7
#> Obesidade   108  28.3       382 100.0
#> Total       382 100.0       382 100.0
enutri(hasdm, idoso = TRUE) |> 
   tabuleiro()
#>                Freq     % Freq.acum %acum
#> Abaixo do peso   27   7.1        27   7.1
#> Eutrófico       159  41.6       186  48.7
#> Sobrepeso        88  23.0       274  71.7
#> Obesidade I      74  19.4       348  91.1
#> Obesidade II     16   4.2       364  95.3
#> Obesidade III    18   4.7       382 100.0
#> Total           382 100.0       382 100.0
 
```
