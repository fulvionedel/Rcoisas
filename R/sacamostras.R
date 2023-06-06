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
#' @param suffixes Vetor com texto para o final do nome dos "data frames" e bancos de dados.
#' 
#' @examples
#' # Perceba que a função não é enderaçada a nenhum objeto (tipo `x <- sacamostras(...)`), 
#' # uma vez que ela já cria os bancos de dados como objetos no espaço de trabalho.
#' semente = 1:7
#' # Amostra de 100 registros:
#' sacamostras(data = RDRS2019, size = 100, prefix = "amostra_", suffixes = semente) 
#' # Amostra de 10\% dos registros:
#' sacamostras(data = RDRS2019, size = .01, prefix = "amostra_", suffixes = semente) 
#' unlink("amostra*") # apaga os arquivos criados
#' 
#' @importFrom dplyr slice_sample
#' @export
#' 
sacamostras <- function(data, size, prefix, suffixes) {
  
  sample_objects <- list()  # Create an empty list to store sample objects
  
  for (i in 1:length(suffixes)) {
    set.seed(suffixes[i])  # Set the seed based on the suffixes element
    if(size >= 1) {
      sample_data <- slice_sample(data, n = size)
    } else if(size < 1) {
      sample_data <- slice_sample(data, prop = size)
    }
    save_name <- paste0(prefix, suffixes[i])
    
    # Save as CSV file
    csv_file <- paste0(save_name, ".csv")
    utils::write.csv(sample_data, file = csv_file, row.names = FALSE)
    cat("Sample", i, "saved as", csv_file, "\n")
    
    # Save as an object in the workspace
    pos <- NULL
    assign(save_name, sample_data)#, envir = .GlobalEnv)
    cat("Sample", i, "saved as an object:", save_name, "\n")
    
    # Add sample object to the list
    sample_objects[[i]] <- sample_data
  }
  
  # Save the list of sample objects as an RData file
  rdata_file <- paste0(prefix, "samples.RData")
  save(list = save_name, file = rdata_file)
  cat("Samples saved as an RData file:", rdata_file, "\n")
  
  # return(sample_objects) # Não tem porque devolver o objeto, acho que só polui o output
}
