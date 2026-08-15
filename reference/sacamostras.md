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
sacamostras(
  data,
  size,
  prefix = NULL,
  suffixes,
  tipo = 2,
  seed = NULL,
  nomelongo = FALSE,
  csv = TRUE,
  rdata = TRUE
)
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

- nomelongo:

  Argumento lógico, FALSE por padrão. Se TRUE, acrescenta o número da
  semente ao nome do objeto e arquivo criados.

- csv:

  Argumento lógico, TRUE por padrão. Se FALSE, não cria o arquivo csv
  com a amostra .

- rdata:

  Argumento lógico, TRUE por padrão. Se FALSE, não cria o arquivo RData
  com a amostra .

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
#> Sample 1 saved as s1.csv 
#> Sample 1 saved as an object: s1 
#> Sample 2 saved as s2.csv 
#> Sample 2 saved as an object: s2 
#> Sample 3 saved as s3.csv 
#> Sample 3 saved as an object: s3 
#> Samples saved as an RData file: ssamples.RData 

# Amostras de 1\% dos registros, com outros nomes, mas mesma "semente":
sacamostras(data = RDRS2019, size = .01, 
            prefix = "amostra", suffixes = paste0("0", 1:3), 
            seed = semente)
#> Sample 1 saved as amostra01.csv 
#> Sample 1 saved as an object: amostra01 
#> Sample 2 saved as amostra02.csv 
#> Sample 2 saved as an object: amostra02 
#> Sample 3 saved as amostra03.csv 
#> Sample 3 saved as an object: amostra03 
#> Samples saved as an RData file: amostrasamples.RData 
all.equal(amostra01, amostra_1) 
#> [1] TRUE

# Amostra de 1\% dos registros, com mesmos nomes mas outra "semente":
sacamostras(data = RDRS2019, size = .01, prefix = "amostra", suffixes = semente, seed = 11:13)
#> Sample 1 saved as amostra1.csv 
#> Sample 1 saved as an object: amostra1 
#> Sample 2 saved as amostra2.csv 
#> Sample 2 saved as an object: amostra2 
#> Sample 3 saved as amostra3.csv 
#> Sample 3 saved as an object: amostra3 
#> Samples saved as an RData file: amostrasamples.RData 
all.equal(amostra1, s1) 
#> [1] TRUE

# A função retorna um aviso de erro se o argumento 'suffixes' não tiver 
# o mesmo comprimento do argumento 'seed':
if (FALSE) { # \dontrun{
sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", suffixes = "bis", seed = semente) 
} # }
# Amostra de 1\% dos registros:
sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", 
            suffixes = rep("bis", length(semente)), seed = semente) 
#> Sample 1 saved as amostra_bis.csv 
#> Sample 1 saved as an object: amostra_bis 
#> Sample 2 saved as amostra_bis.csv 
#> Sample 2 saved as an object: amostra_bis 
#> Sample 3 saved as amostra_bis.csv 
#> Sample 3 saved as an object: amostra_bis 
#> Samples saved as an RData file: amostra_samples.RData 
all.equal(amostra_bis, amostra_1) 
#>  [1] "Component “UF_ZI”: 76 string mismatches"                                  
#>  [2] "Component “ANO_CMPT”: 18 string mismatches"                               
#>  [3] "Component “MES_CMPT”: 86 string mismatches"                               
#>  [4] "Component “ESPEC”: 71 string mismatches"                                  
#>  [5] "Component “CGC_HOSP”: 'is.NA' value mismatch: 6 in current 4 in target"   
#>  [6] "Component “N_AIH”: 100 string mismatches"                                 
#>  [7] "Component “CEP”: 100 string mismatches"                                   
#>  [8] "Component “MUNIC_RES”: 98 string mismatches"                              
#>  [9] "Component “NASC”: 100 string mismatches"                                  
#> [10] "Component “SEXO”: 42 string mismatches"                                   
#> [11] "Component “UTI_MES_TO”: Mean relative difference: 1.684211"               
#> [12] "Component “MARCA_UTI”: 18 string mismatches"                              
#> [13] "Component “UTI_INT_TO”: Mean relative difference: 5"                      
#> [14] "Component “DIAR_ACOM”: Mean relative difference: 1.008043"                
#> [15] "Component “QT_DIARIAS”: Mean relative difference: 1.057011"               
#> [16] "Component “PROC_SOLIC”: 100 string mismatches"                            
#> [17] "Component “PROC_REA”: 100 string mismatches"                              
#> [18] "Component “VAL_SH”: Mean relative difference: 1.166865"                   
#> [19] "Component “VAL_SP”: Mean relative difference: 1.145866"                   
#> [20] "Component “VAL_TOT”: Mean relative difference: 1.1353"                    
#> [21] "Component “VAL_UTI”: Mean relative difference: 1.657143"                  
#> [22] "Component “US_TOT”: Mean relative difference: 1.150145"                   
#> [23] "Component “DT_INTER”: 99 string mismatches"                               
#> [24] "Component “DT_SAIDA”: 100 string mismatches"                              
#> [25] "Component “DIAG_PRINC”: 100 string mismatches"                            
#> [26] "Component “COBRANCA”: 46 string mismatches"                               
#> [27] "Component “NAT_JUR”: 62 string mismatches"                                
#> [28] "Component “GESTAO”: 45 string mismatches"                                 
#> [29] "Component “IND_VDRL”: 10 string mismatches"                               
#> [30] "Component “MUNIC_MOV”: 98 string mismatches"                              
#> [31] "Component “COD_IDADE”: 10 string mismatches"                              
#> [32] "Component “IDADE”: Mean relative difference: 0.6967993"                   
#> [33] "Component “DIAS_PERM”: Mean relative difference: 1.116992"                
#> [34] "Component “MORTE”: Mean relative difference: 2"                           
#> [35] "Component “CAR_INT”: 33 string mismatches"                                
#> [36] "Component “INSC_PN”: 3 string mismatches"                                 
#> [37] "Component “CBOR”: 1 string mismatch"                                      
#> [38] "Component “CNAER”: 1 string mismatch"                                     
#> [39] "Component “VINCPREV”: 1 string mismatch"                                  
#> [40] "Component “GESTOR_COD”: 13 string mismatches"                             
#> [41] "Component “GESTOR_TP”: 36 string mismatches"                              
#> [42] "Component “GESTOR_CPF”: 39 string mismatches"                             
#> [43] "Component “CNES”: 99 string mismatches"                                   
#> [44] "Component “CNPJ_MANT”: 'is.NA' value mismatch: 86 in current 91 in target"
#> [45] "Component “COMPLEX”: 22 string mismatches"                                
#> [46] "Component “FINANC”: 2 string mismatches"                                  
#> [47] "Component “FAEC_TP”: 'is.NA' value mismatch: 98 in current 98 in target"  
#> [48] "Component “REGCT”: 42 string mismatches"                                  
#> [49] "Component “RACA_COR”: 43 string mismatches"                               
#> [50] "Component “ETNIA”: 1 string mismatch"                                     
#> [51] "Component “SEQUENCIA”: Mean relative difference: 0.9700825"               
#> [52] "Component “REMESSA”: 99 string mismatches"                                
#> [53] "Component “AUD_JUST”: 'is.NA' value mismatch: 99 in current 100 in target"
#> [54] "Component “SIS_JUST”: 'is.NA' value mismatch: 99 in current 100 in target"
#> [55] "Component “VAL_SH_FED”: Mean relative difference: 1"                      
#> [56] "Component “VAL_SP_FED”: Mean relative difference: 1"                      
#> [57] "Component “VAL_UCI”: Mean relative difference: 5"                         
#> [58] "Component “MARCA_UCI”: 3 string mismatches"                               
#> [59] "Component “DIAGSEC1”: 'is.NA' value mismatch: 90 in current 95 in target" 
#> [60] "Component “DIAGSEC2”: 'is.NA' value mismatch: 99 in current 100 in target"
#> [61] "Component “TPDISEC1”: 13 string mismatches"                               
#> [62] "Component “TPDISEC2”: 1 string mismatch"                                  
# Para repetir amostras sem sobreescrever os objetos e arquivos criados, 
# usa-se o argumento 'nomelongo = TRUE'.
sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", 
            suffixes = rep("bis", length(semente)), seed = semente, nomelongo = TRUE) 
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
#> Sample 1 saved as amostra1.csv 
#> Sample 1 saved as an object: amostra1 
#> Sample 2 saved as amostra2.csv 
#> Sample 2 saved as an object: amostra2 
#> Sample 3 saved as amostra3.csv 
#> Sample 3 saved as an object: amostra3 
#> Samples saved as an RData file: amostrasamples.RData 
all.equal(amostra1, s1) 
#> [1] TRUE
rm(list = ls(pattern = "amostra"))
rm(list = ls(pattern = "s"))
unlink(c("amostra*", "s*")) # apaga os arquivos criados
```
