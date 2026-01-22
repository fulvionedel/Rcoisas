Rcoisas: Funções para aulas de epidemiologia e bioestatística em
português.
================
<!-- | Em atualização -->

21 de janeiro de 2026

- [Conteúdo](#conteúdo)
- [Instalação](#instalação)

------------------------------------------------------------------------

No [SourceForge](https://sourceforge.net/p/rcoisas/): [![Download
Rcoisas](https://img.shields.io/sourceforge/dt/rcoisas.svg)](https://sourceforge.net/p/rcoisas/files/latest/download)
[![Download
Rcoisas](https://img.shields.io/sourceforge/dm/rcoisas.svg)](https://sourceforge.net/p/rcoisas/files/latest/download)

------------------------------------------------------------------------

O pacote contém funções com *outputs* em português e bancos de dados
úteis para a produção de gráficos e tabelas úteis para a construção de
material didático e exercícios em aula, como a descrição de variáveis
numéricas e tabela de frequências, a análise de uma tabela 2 x 2 ou a
construção de indicadores de saúde, como a curva de Nelson de Moraes.
<!-- Algumas funções são importadas do pacote [`csapAIH`](https://github.com/fulvionedel/csapAIH) (`fxetar_quinq`, `fxetar3g`, `ufbr`, `ler_popbr` e `popbr2000_2021`).  -->

## Conteúdo

Esta é a primeira “*release*” do pacote, com 18 funções, listadas a
seguir:

     [1] "adissoma"               "bolero"                 "calendas"              
     [4] "descreve"               "ed"                     "folhinha"              
     [7] "formatL"                "fxetar.det_pra_fxetar5" "fxetarNM"              
    [10] "ggplot_pir"             "histobox"               "numescrito"            
    [13] "plot_pir"               "plotZ"                  "sacamostras"           
    [16] "tabuleiro"              "tabuleiro2"             "zeroesq"               

Exemplos de uso de algumas funções podem ser vistos em
<https://fulvionedel.github.io/Rcoisas/>

Veja aqui o [manual do
pacote](https://github.com/fulvionedel/Rcoisas/blob/master/inst/manual/Rcoisas_0.0.1.0.pdf).

## Instalação

A última versão do pacote pode ser instalada no **R**:

- baixando o arquivo de instalação no
  [SourceForge](https://sourceforge.net/projects/Rcoisas/) e depois
  instalando, com a IDE de preferência ou com o comando
  `install.packages("Rcoisas_<versão>.tar.gz")` (em Linux ou Mac) ou
  `install.packages("Rcoisas_<versão>.zip")` (em Windows); ou

- com a função `install.packages()` endereçada ao link da última versão
  no [SourceForge](https://sourceforge.net/projects/Rcoisas/files/):

``` r
install.packages("https://sourceforge.net/projects/Rcoisas/files/latest/download", 
                 type = "source", repos = NULL) 
```

A versão de desenvolvimento pode ser instalada a partir do
[GitHub](https://github.com/) com o pacote `remotes`:

    # install.packages("remotes") # Se o pacote 'remotes' não estiver instalado
    remotes::install_github("fulvionedel/Rcoisas")
