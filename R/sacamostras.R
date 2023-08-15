#' Toma múltiplas amostras aleatórias de um banco de dados.
#' @aliases sacamostras
#' 
#' @description
#' Toma múltiplas amostras aleatórias sem reposição de um banco de dados. Cada amostra é salva em um objeto da classe `data.frame` e exportada para um arquivo .csv, enquanto o conjunto dos objetos é salvo num arquivo de dados do R (.RData). Os arquivos são salvos no diretório de trabalho da sessão ativa. O nº de amostras a extrair é dado pelo comprimento de uma lista indicada no argumento `suffixes`
#' e cria novos "data frames" em um número definido de amostras aleatórias de tamanho n, criando com cada amostra um objeto da classe `data.frame`, que será salvo em um arquivo .csv e com os demais data frames, em um arquivo .RData. Criada com ajuda do chatGPT em 06/06/2023.
#' 
#' @param data "Data frame" fonte das amostras.
#' @param size Tamanho das amostras (nº de registros).
#' @param prefix Texto para o início do nome dos "data frames" e bancos de dados.
#' @param suffixes Vetor numérico ou de caracteres, será usado como texto para o final do nome dos bancos de dados. Se for um vetor numérico e o argumento \code{seed} não for definido, será então usado para definir a "semente" das amostras (v. argumento \code{seed}). 
#' @param tipo Formatação do arquivo csv; `tipo = 1` invoca a função \code{\link{write.csv}}, com campos separados por vírgula (`,`) e decimais separados por ponto (`.`), enquanto `tipo = 2` (padrão) invoca a função \code{\link{write.csv2}}, criando arquivos com campos separados por ponto-e-vírgula (`;`) e decimais separados por vírgula (`,`).
#' @param seed Vetor de números inteiros do tamanho do número de amostras desejado. É usado como "semente" para os números (pseudo)aleatórios que geram as amostras, permitindo assim sua reprodução. Se \code{NULL} (padrão), é tomado de \code{suffixes}, caso este seja um vetor de números inteiros. Argumento obrigatório quando \code{suffixes} não for numérico.
#' 
#' @examples
#' # Perceba que a função não é enderaçada a nenhum objeto (como em `x <- sacamostras(...)`), 
#' # uma vez que ela já cria os bancos de dados como objetos no espaço de trabalho.
#' semente = 1:7
#' # Amostras de 100 registros:
#' sacamostras(data = RDRS2019, size = 100, prefix = "amostra_", suffixes = semente) 
#' # Amostras de 10\% dos registros:
#' sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", suffixes = semente) 
#' # Amostras de 10\% dos registros, com outra semente:
#' sacamostras(data = RDRS2019, size = .01, prefix = "amostra", suffixes = semente, seed = 11:17)
#' # Amostras de 10\% dos registros, com outros nomes, mas mesma "semente":
#' sacamostras(data = RDRS2019, size = .01, 
#'             prefix = "amostra", suffixes = paste0("0", 1:7), 
#'             seed = semente)
#' all.equal(amostra01, amostra_1) 
#' 
#' # Amostra de 10\% dos registros:
#' sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", suffixes = "bis", seed = semente) 
#' all.equal(amostra_bis1, amostra_1) 
#' sacamostras(data = RDRS2019, size = .01, prefix = "amostra", suffixes = semente, seed = 11:17)
#' all.equal(amostra11, amostra_1) 
#' rm(list = ls(pattern = "amostra"))
#' unlink("amostra*") # apaga os arquivos criados
#' 
#' @importFrom dplyr slice_sample
#' @export
#' 
sacamostras <- function(data, size, prefix, suffixes, tipo = 2, seed = NULL) {
  
  if(!is.null(seed) && length(suffixes) != length(seed)) {
    stop("Length of 'suffixes' is not the same of 'seed'")
  }
  
  sample_objects <- list()  # Create an empty list to store sample objects
  nsamples <- if(!is.null(seed)) {
    length(seed)
  } else {
    length(suffixes)
  }
  
  for (i in 1:nsamples) {
    if(is.null(seed)) {
      set.seed(suffixes[i]) # Set the seed based on the suffixes argument
    } else {
      set.seed(seed[i])  
    }
    if(size >= 1) {
      sample_data <- slice_sample(data, n = size)
    } else if(size < 1) {
      sample_data <- slice_sample(data, prop = size)
    }

    save_name <- paste0(prefix, suffixes[i])
    if(is.null(seed)) {
      save_name <- paste0(prefix, suffixes[i])
    } else {
      save_name <- paste0(prefix, rep(suffixes, nsamples)[i], (1:nsamples)[i])
    }
    
    # Save as CSV file
    csv_file <- paste0(save_name, ".csv")
    if(tipo == 1) {
      utils::write.csv(sample_data, file = csv_file, row.names = FALSE)
      } else if(tipo == 2) utils::write.csv2(sample_data, file = csv_file, row.names = FALSE)
    cat("Sample", i, "saved as", csv_file, "\n")
    
    # Save as an object in the workspace
    pos <- 1 #NULL
    assign(save_name, sample_data, envir = as.environment(pos))
    cat("Sample", i, "saved as an object:", save_name, "\n")
    
    # pos <- 1
    # envir = as.environment(pos)
    # assign("trellis.par.theme", trellis.par.get(), envir = envir)
    
    
    # Add sample object to the list
    sample_objects[[i]] <- sample_data
  }

  # Save the list of sample objects as an RData file
  rdata_file <- paste0(prefix, "samples.RData")
  save.image(#list = save_name, 
             file = rdata_file)
  cat("Samples saved as an RData file:", rdata_file, "\n")
  
  # return(sample_objects) # Não tem porque devolver o objeto, acho que só polui o output
}
