# Tomar amostras de bancos de dados

``` r
library(Rcoisas)
```

    sacamostras(data, size, prefix, suffixes, tipo = 2, seed = NULL)

A função
[`sacamostras()`](https://fulvionedel.github.io/Rcoisas/reference/sacamostras.md)
automatiza o processo de toma de múltiplas amostras aleatórias (sem
reposição) de um banco de dados, gravando um arquivo .csv para cada
amostra criada e um arquivo .RData com os bancos de dados (da classe
`data.frame`). Foi motivada pela necessidade de organizar exercícios de
bioestatística e epidemiologia em diferentes grupos de trabalho, de modo
que um mesmo processo de manejo e análise de dados gere resultados
diferentes. Resulta ainda em exemplo prático para discutir a
variabilidade estocástica.

O usuário pode definir:

- o número e tamanho das amostras;  
- o texto a preceder e suceder o nome dos bancos de dados criados;  
- o formato dos arquivos .csv que serão salvos, se (1) campos separados
  por vírgula e decimais por ponto ou (2) campos separados por
  ponto-e-vírgula e decimais por vírgula;  
- um número de origem (“semente”) para a definição das amostras (v.
  [`?set.seed`](https://rdrr.io/r/base/Random.html)).

## Exemplo

O pacote `Rcoisas` tem um banco de dados de Autorizações de Internação
Hospitalar (AIHs) do SUS, com registros das internações hospitalares
realizadas pelo SUS no Rio Grande do Sul (RS) em 2019.[¹](#fn1) Pode ser
usado para um exercício em que se pretenda saber como a ocorrência de
morte intrahospitalar nas internações pelo SUS no RS em 2019 varia em
função do tempo de internação e do sexo, idade e cor da pele do
paciente. Imaginemos que o exercício será aplicado a uma turma dividida
em três grupos e cada grupo trabalhará com uma amostra de 100 registros.

Se o exercício focar na análise, podemos entregar o banco já trabalhado
antes de tirar as amostras. Assim, o *script* abaixo executa os
seguintes passos:

- transforma as variáveis `SEXO`, `RACA_COR` e `MORTE` em fator,
  decodificando as categorias; e
- computa a idade: neste exemplo a idade é calculada como a diferença
  entre a data da internação e do nascimento (variáveis `DT_INTER` e
  `NASC`) dividida por 365,25 (para transformar o tempo, dado
  originalmente em dias, em anos, considerando os anos bissextos), para
  usar um método clássico e reprodutível em diferentes bancos de dados,
  embora não seja o método preferível nos arquivos da AIH[²](#fn2); e  
- seleciona apenas as variáveis de interesse.

``` r
data("RDRS2019")
RDRS2019 <- within(RDRS2019,  {
  SEXO <- factor(SEXO, labels = c("Masculino", "Feminino"))
  RACA_COR <- factor(RACA_COR, levels = c("01", "02", "03", "04", "05"),
                               labels = c("Branca", "Preta", "Parda", "Amarela", "Indígena"))
  IDADE <- trunc(as.numeric((as.Date(DT_INTER, "%Y%m%d") - as.Date(NASC, "%Y%m%d"))/365.25))
  MORTE <- factor(MORTE, levels = c(1,0), labels = c("Sim", "Não"))
})
RDRS2019 <- RDRS2019[c(11,51:53,84)]
```

A estrutura do banco final é mostrada abaixo. Precisamos extrair três
amostras aleatórias de 100 registros desse banco de dados.

``` r
str(RDRS2019)
   'data.frame':    10000 obs. of  5 variables:
    $ SEXO     : Factor w/ 2 levels "Masculino","Feminino": 1 2 2 2 1 1 2 1 1 2 ...
    $ IDADE    : num  23 73 27 80 73 53 20 53 29 72 ...
    $ DIAS_PERM: int  21 2 2 4 3 4 1 3 6 5 ...
    $ MORTE    : Factor w/ 2 levels "Sim","Não": 2 2 2 2 2 2 2 2 2 2 ...
    $ RACA_COR : Factor w/ 5 levels "Branca","Preta",..: 1 1 1 1 1 1 3 1 NA 1 ...
```

As amostras são criadas pela função
[`sacamostras()`](https://fulvionedel.github.io/Rcoisas/reference/sacamostras.md),
em que vale notar o uso dos argumentos `prefix` e `suffixes`:

- `prefix` é um argumento obrigatório usado para identificação dos
  bancos e arquivos criados; é um argumento para permitir que o usuário
  ponha o texto de sua escolha e não tem valor padrão para que o usuário
  seja consciente dessa definição;
  - Para evitar sobreescrever algum arquivo .csv inadvertidamente,
    verifico antes se o diretório de trabalho contém arquivos com o nome
    que será usado como prefixo:

    ``` r
    dir(pattern = "^amostra")
       character(0)
    ```
- `suffixes` pode ser usado apenas para a identificação dos objetos e
  arquivos ccriados, se os valores de origem dos números aleatórios
  forem definidos no argumento `semente`. Por padrão (nosso caso),
  `suffixes` é usado também para definir a semente de números aleatórios
  em cada amostra, pois pode ser conveniente identificar no nome do
  objeto a semente que o gerou.[³](#fn3) Assim, ao identificar um
  complemento no nome da amostra (um “sufixo”), o argumento `suffixes`
  define ainda o número de amostras, pois para cada nome uma amostra.
  Assim, como `suffixes = 1:3` gera um vetor de três elementos (1, 2 e
  3), teremos três amostras.

``` r
sacamostras(data = RDRS2019, size = 100, prefix = "amostra_", suffixes = 1:3)
   Sample 1 saved as amostra_1.csv 
   Sample 1 saved as an object: amostra_1 
   Sample 2 saved as amostra_2.csv 
   Sample 2 saved as an object: amostra_2 
   Sample 3 saved as amostra_3.csv 
   Sample 3 saved as an object: amostra_3 
   Samples saved as an RData file: amostra_samples.RData
```

A mensagem de execução da função nos informa que foram criadas três
amostras como objetos no espaço de trabalho (`amostra_1`, `amostra_2` e
`amostra_3`) e que foram salvas cada uma em um arquivo csv e todas elas
em um único arquivo RData (“amostra_samples.RData”). Efetivamente, agora
os podemos ver no espaço de trabalho e no diretório do computador em que
temos a sessão ativa:

``` r
ls(pattern = "^amostra")
   [1] "amostra_1" "amostra_2" "amostra_3"
dir(pattern = "^amostra")
   [1] "amostra_1.csv"         "amostra_2.csv"         "amostra_3.csv"        
   [4] "amostra_samples.RData"
```

Um resumo breve das variáveis confirma que as amostras são realmente
diferentes entre si:

``` r
summary(amostra_1)
           SEXO        IDADE         DIAS_PERM     MORTE        RACA_COR 
    Masculino:53   Min.   : 0.00   Min.   : 0.00   Sim: 5   Branca  :74  
    Feminino :47   1st Qu.:28.75   1st Qu.: 2.00   Não:95   Preta   : 2  
                   Median :49.50   Median : 3.00            Parda   : 3  
                   Mean   :47.07   Mean   : 6.01            Amarela : 0  
                   3rd Qu.:68.50   3rd Qu.: 8.00            Indígena: 0  
                   Max.   :91.00   Max.   :32.00            NA's    :21
summary(amostra_2)
           SEXO        IDADE         DIAS_PERM     MORTE        RACA_COR 
    Masculino:44   Min.   : 0.00   Min.   : 0.00   Sim: 4   Branca  :77  
    Feminino :56   1st Qu.:26.25   1st Qu.: 2.00   Não:96   Preta   : 5  
                   Median :48.50   Median : 3.50            Parda   : 5  
                   Mean   :45.33   Mean   : 6.31            Amarela : 1  
                   3rd Qu.:67.00   3rd Qu.: 7.00            Indígena: 0  
                   Max.   :88.00   Max.   :68.00            NA's    :12
summary(amostra_3)
           SEXO        IDADE         DIAS_PERM     MORTE        RACA_COR 
    Masculino:49   Min.   : 0.00   Min.   : 0.00   Sim: 5   Branca  :66  
    Feminino :51   1st Qu.:26.50   1st Qu.: 2.00   Não:95   Preta   : 6  
                   Median :51.00   Median : 4.00            Parda   : 8  
                   Mean   :46.57   Mean   : 7.33            Amarela : 0  
                   3rd Qu.:68.00   3rd Qu.: 7.00            Indígena: 1  
                   Max.   :99.00   Max.   :49.00            NA's    :19
```

Temos assim uma amostra para cada grupo, tanto em arquivos csv –
interessantes se o exercício incluir a leitura de arquivos de dados –
como em objetos num arquivo de dados do R.

O código abaixo: (1) apaga todos os objetos da sessão de trabalho e (2)
carrega o recém criado arquivo “amostra_samples.RData”, com todas as
amostras.

``` r
rm(list = ls()) ; ls()
   character(0)
load("amostra_samples.RData") ; ls() 
   [1] "amostra_1" "amostra_2" "amostra_3" "RDRS2019"
```

O processo de salvamento e leitura dos arquivos csv pode não respeitar o
formato dos campos do banco original. Assim, o campo “nº da AIH”, que
abriga um número de registro extenso pode ser lido como numérico mesmo
que esteja armazenado como charactere no banco original. No mesmo
sentido, vemos a seguir que ao ler os arquivos csv as variáveis
categóricas são lidas no formato caractere (`chr`) e não fator. Há ainda
uma diferença na estrutura das variáveis numéricas. Isso pode ser
resolvido definindo as classes das variáveis no comando de leitura.

``` r
amostra_1 |> str()
   'data.frame':    100 obs. of  5 variables:
    $ SEXO     : Factor w/ 2 levels "Masculino","Feminino": 2 2 1 2 2 2 2 2 1 1 ...
    $ IDADE    : num  4 49 83 84 42 19 60 46 80 50 ...
    $ DIAS_PERM: int  0 3 8 21 1 1 11 1 5 10 ...
    $ MORTE    : Factor w/ 2 levels "Sim","Não": 2 2 2 1 2 2 2 2 2 2 ...
    $ RACA_COR : Factor w/ 5 levels "Branca","Preta",..: 1 1 1 3 1 NA 1 1 NA NA ...
read.csv2("amostra_1.csv") |> str()
   'data.frame':    100 obs. of  5 variables:
    $ SEXO     : chr  "Feminino" "Feminino" "Masculino" "Feminino" ...
    $ IDADE    : int  4 49 83 84 42 19 60 46 80 50 ...
    $ DIAS_PERM: int  0 3 8 21 1 1 11 1 5 10 ...
    $ MORTE    : chr  "Não" "Não" "Não" "Sim" ...
    $ RACA_COR : chr  "Branca" "Branca" "Branca" "Parda" ...
read.csv2("amostra_1.csv", colClasses = c("factor", "numeric", "integer", "factor", "factor")) |> str()
   'data.frame':    100 obs. of  5 variables:
    $ SEXO     : Factor w/ 2 levels "Feminino","Masculino": 1 1 2 1 1 1 1 1 2 2 ...
    $ IDADE    : num  4 49 83 84 42 19 60 46 80 50 ...
    $ DIAS_PERM: int  0 3 8 21 1 1 11 1 5 10 ...
    $ MORTE    : Factor w/ 2 levels "Não","Sim": 1 1 1 2 1 1 1 1 1 1 ...
    $ RACA_COR : Factor w/ 3 levels "Branca","Parda",..: 1 1 1 2 1 NA 1 1 NA NA ...
```

Finalmente, vale lembrar que o ambiente de trabalho pode ser limpo com a
função [`rm()`](https://rdrr.io/r/base/rm.html) e os arquivos podem ser
apagados com a função [`unlink()`](https://rdrr.io/r/base/unlink.html):

``` r
rm(list = ls(pattern = "amostra"))
unlink(c("amostra*", "*.html")) # apaga os arquivos criados
```

------------------------------------------------------------------------

1.  Veja em
    [`?RDRS2019`](https://fulvionedel.github.io/Rcoisas/reference/RDRS2019.md)
    que não são todas as internações mas uma amostra aleatória de dez
    mil registros.

2.  A computação da idade nos arquivos da AIH pode ser mais precisa.
    Neles, o campo `IDADE` registra a idade do paciente em dias, meses,
    anos ou anos após a centena, enquanto o campo `COD_IDADE` identifica
    a unidade de medida; a função `idadeSUS` do pacote
    [`csapAIH`](https://github.com/fulvionedel/csapAIH) pode ser usada
    para a computação da idade nos registros de internação do SUS e da
    Declaração de Óbito do Sistema de Informação sobre Mortalidade
    (SIM).

3.  Veja a ajuda da função para mais detalhes nesse sentido.
