# Toma múltiplas amostras aleatórias de um banco de dados.

Toma múltiplas amostras aleatórias sem reposição de um banco de dados.
Cada amostra é salva em um objeto da classe \`data.frame\` e exportada
para um arquivo .csv, enquanto o conjunto dos objetos é salvo num
arquivo de dados do R (.RData). Os arquivos são salvos no diretório de
trabalho da sessão ativa. O nº de amostras a extrair é dado pelo
comprimento de uma lista indicada no argumento \`suffixes\` e cria novos
"data frames" em um número definido de amostras aleatórias de tamanho n,
criando com cada amostra um objeto da classe \`data.frame\`, que será
salvo em um arquivo .csv e com os demais data frames, em um arquivo
.RData. Criada com ajuda do chatGPT em 06/06/2023.

## Usage

``` r
sacamostras(data, size, prefix, suffixes, tipo = 2, seed = NULL)
```

## Arguments

- data:

  "Data frame" fonte das amostras.

- size:

  Tamanho das amostras (nº de registros).

- prefix:

  Texto para o início do nome dos "data frames" e bancos de dados.

- suffixes:

  Vetor numérico ou de caracteres, será usado como texto para o final do
  nome dos bancos de dados. Se for um vetor numérico e o argumento
  `seed` não for definido, será então usado para definir a "semente" das
  amostras (v. argumento `seed`).

- tipo:

  Formatação do arquivo csv; \`tipo = 1\` invoca a função
  [`write.csv`](https://rdrr.io/r/utils/write.table.html), com campos
  separados por vírgula (\`,\`) e decimais separados por ponto (\`.\`),
  enquanto \`tipo = 2\` (padrão) invoca a função
  [`write.csv2`](https://rdrr.io/r/utils/write.table.html), criando
  arquivos com campos separados por ponto-e-vírgula (\`;\`) e decimais
  separados por vírgula (\`,\`).

- seed:

  Vetor de números inteiros do tamanho do número de amostras desejado. É
  usado como "semente" para os números (pseudo)aleatórios que geram as
  amostras, permitindo assim sua reprodução. Se `NULL` (padrão), é
  tomado de `suffixes`, caso este seja um vetor de números inteiros.
  Argumento obrigatório quando `suffixes` não for numérico.

## Examples

``` r
# Perceba que a função não é enderaçada a nenhum objeto (como em `x <- sacamostras(...)`), 
# uma vez que ela já cria os bancos de dados como objetos no espaço de trabalho.
semente = 1:3
# Amostras de 100 registros:
sacamostras(data = RDRS2019, size = 100, prefix = "amostra_", suffixes = semente) 
#> Sample 1 saved as amostra_1.csv 
#> Sample 1 saved as an object: amostra_1 
#> Sample 2 saved as amostra_2.csv 
#> Sample 2 saved as an object: amostra_2 
#> Sample 3 saved as amostra_3.csv 
#> Sample 3 saved as an object: amostra_3 
#> Samples saved as an RData file: amostra_samples.RData 
# Amostras de 1\% dos registros:
sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", suffixes = semente) 
#> Sample 1 saved as amostra_1.csv 
#> Sample 1 saved as an object: amostra_1 
#> Sample 2 saved as amostra_2.csv 
#> Sample 2 saved as an object: amostra_2 
#> Sample 3 saved as amostra_3.csv 
#> Sample 3 saved as an object: amostra_3 
#> Samples saved as an RData file: amostra_samples.RData 
# Amostras de 1\% dos registros, com outra semente:
sacamostras(data = RDRS2019, size = .01, prefix = "s", suffixes = semente, seed = 11:13)
#> Sample 1 saved as s1_11.csv 
#> Sample 1 saved as an object: s1_11 
#> Sample 2 saved as s2_12.csv 
#> Sample 2 saved as an object: s2_12 
#> Sample 3 saved as s3_13.csv 
#> Sample 3 saved as an object: s3_13 
#> Samples saved as an RData file: ssamples.RData 

# Amostras de 1\% dos registros, com outros nomes, mas mesma "semente":
sacamostras(data = RDRS2019, size = .01, 
            prefix = "amostra", suffixes = paste0("0", 1:3), 
            seed = semente)
#> Sample 1 saved as amostra01_1.csv 
#> Sample 1 saved as an object: amostra01_1 
#> Sample 2 saved as amostra02_2.csv 
#> Sample 2 saved as an object: amostra02_2 
#> Sample 3 saved as amostra03_3.csv 
#> Sample 3 saved as an object: amostra03_3 
#> Samples saved as an RData file: amostrasamples.RData 
all.equal(amostra01_1, amostra_1) 
#> [1] TRUE

# Amostra de 1\% dos registros, com mesmos nomes mas outra "semente":
sacamostras(data = RDRS2019, size = .01, prefix = "amostra", suffixes = semente, seed = 11:13)
#> Sample 1 saved as amostra1_11.csv 
#> Sample 1 saved as an object: amostra1_11 
#> Sample 2 saved as amostra2_12.csv 
#> Sample 2 saved as an object: amostra2_12 
#> Sample 3 saved as amostra3_13.csv 
#> Sample 3 saved as an object: amostra3_13 
#> Samples saved as an RData file: amostrasamples.RData 
all.equal(amostra1_11, s1_11) 
#> [1] TRUE

# A função retorna um aviso de erro se o argumento 'suffixes' não tiver 
# o mesmo comprimento do argumento 'seed':
if (FALSE) { # \dontrun{
sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", suffixes = "bis", seed = semente) 
} # }
# Amostra de 1\% dos registros:
sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", 
            suffixes = rep("bis", length(semente)), seed = semente) 
#> Sample 1 saved as amostra_bis_1.csv 
#> Sample 1 saved as an object: amostra_bis_1 
#> Sample 2 saved as amostra_bis_2.csv 
#> Sample 2 saved as an object: amostra_bis_2 
#> Sample 3 saved as amostra_bis_3.csv 
#> Sample 3 saved as an object: amostra_bis_3 
#> Samples saved as an RData file: amostra_samples.RData 
all.equal(amostra_bis_1, amostra_1) 
#> [1] TRUE
sacamostras(data = RDRS2019, size = .01, prefix = "amostra", suffixes = semente, seed = 11:13)
#> Sample 1 saved as amostra1_11.csv 
#> Sample 1 saved as an object: amostra1_11 
#> Sample 2 saved as amostra2_12.csv 
#> Sample 2 saved as an object: amostra2_12 
#> Sample 3 saved as amostra3_13.csv 
#> Sample 3 saved as an object: amostra3_13 
#> Samples saved as an RData file: amostrasamples.RData 
all.equal(amostra1_11, s1_11) 
#> [1] TRUE
rm(list = ls(pattern = "amostra"))
rm(list = ls(pattern = "s"))
unlink(c("amostra*", "s*")) # apaga os arquivos criados
```
