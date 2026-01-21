# Zeros à esquerda

Unifica o número de caracteres em um vetor, colocando zeros ("0") à
esquerda do valor original.

## Usage

``` r
zeroesq(x, n = NULL)
```

## Arguments

- x:

  Vetor (de caracteres ou numérico) com algarismos arábicos.

- n:

  Limite do número de zeros a incluir; o padrão é \`NULL\`, sendo então
  definido pela função como o necessário até alcançar o número máximo de
  characteres do vetor; pode ser definido pelo usuário.

## Value

Vetor de caracteres com os dígitos vazios à esquerda do valor original
preenchidos por zero (0).

## Details

Muitas vezes temos, nos bancos de dados, uma variável registrada em
algarismos com grande amplitude de valores mas que na verdade são
códigos em vez de valores numéricos, como no caso do número de
identificação do registro, ou da Equipe de Saúde da Família em um grande
município. Se a variável é numérica (\`integer\`, \`numeric\` ou
\`double/float\`), não é um problema grave, nesse caso costuma-se
ignorar os resumos apresentados sobre a variável ou transformá-la em
texto (\`character\`). Entretanto, em qualquer caso pode trazer alguns
inconvenientes, como - se, num banco de dados com mais de mil registros
uma variável "identificador" aparecer como 1, ..., em vez de 0001, ...,
ela não pode estar inserida (sem trabalho prévio) em definições
condicionais para múltiplas variáveis do tipo "em todos os fatores,
transforme '9', '99' e '999' em NA", ou "em todas variáveis numéricas,
transforme e '999' em NA"; - ordenação de numerais em formato de texto
não segue as mesmas regras que em formato numérico (temos "1, 10, 11,
..., 19, 2, 20, 21, ...), o que implica na definição dos níveis ao
definir um fator.

## Examples

``` r
(codid <- c(1:3, 10:12, 101:103, 1000))
#>  [1]    1    2    3   10   11   12  101  102  103 1000

# Se o vetor é numérico a ordenação acontece sem problemas:
class(codid)
#> [1] "numeric"
sort(codid)
#>  [1]    1    2    3   10   11   12  101  102  103 1000

# Mas se ele for de characteres não:
sort(as.character(codid))
#>  [1] "1"    "10"   "1000" "101"  "102"  "103"  "11"   "12"   "2"    "3"   

# o que gostaríamos é:
sort(as.character(zeroesq(codid)))
#>  [1] "0001" "0002" "0003" "0010" "0011" "0012" "0101" "0102" "0103" "1000"

# ou, diretamente (porque o vetor pode ser numérico ou caractere):
sort(zeroesq(codid))
#>  [1] "0001" "0002" "0003" "0010" "0011" "0012" "0101" "0102" "0103" "1000"
```
