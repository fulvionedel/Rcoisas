#' 
#' Baixa os arquivos txt decodificadores dos códigos de procedimento da tabela SIGTAP 
#' 

temp <- tempfile(fileext = ".zip")
download.file("ftp://ftp2.datasus.gov.br/public/sistemas/tup/downloads/TabelaUnificada_202603_v2603111027.zip",
              destfile = temp, mode = "wb")
unzip(temp, list = TRUE)
unzip(temp, files = c("tb_grupo.txt", "tb_sub_grupo.txt", "tb_forma_organizacao.txt"), exdir = "../data-raw")
tabgrupo <- read.fwf("../data-raw/tb_grupo.txt",
                     colClasses = c("character", "character"),
                     widths = c(2,49),
                     col.names = c("CO_GRUPO", "NO_GRUPO"),
                     fileEncoding = "latin1")
library(readr)
tabsubgrupo <- read_fwf("../data-raw/tb_sub_grupo.txt",
                        fwf_widths(widths = c(2, 2, 49), c("CO_GRUPO", "CO_SUB_GRUPO", "NO_SUB_GRUPO")),
                        locale = locale(encoding = "latin1"),
                        show_col_types = FALSE)
tabforma <- read_fwf("../data-raw/tb_forma_organizacao.txt",
                     fwf_widths(widths = c(2, 2, 2, 49),
                                c("CO_GRUPO", "CO_SUB_GRUPO", "CO_FORMA_ORGANIZACAO", "NO_FORMA_ORGANIZACAO")),
                     locale = locale(encoding = "latin1"),
                     show_col_types = FALSE)

# A tabela com os procedimentos só encontrei em DBF
temp <- tempfile(fileext = ".zip")
download.file("ftp://ftp.datasus.gov.br/dissemin/publicos/SIASUS/200801_/Auxiliar/TAB_SIA.zip",
              destfile = temp, mode = "wb")
unzip(temp, list = TRUE) |> tail(8) 
unzip(temp, files = "DBF/TB_SIGTAW.dbf", junkpaths = T)

tabproc <- foreign::read.dbf("TB_SIGTAW.dbf", as.is = TRUE)
names(tabproc) <- c("CO_PROCEDIMENTO", "PROCEDIMENTO")

usethis::use_data(tabproc, tabgrupo, tabsubgrupo, tabforma, internal = TRUE, overwrite = TRUE)


temp <- tempfile()
download.file("ftp://ftp.datasus.gov.br/dissemin/publicos/SIASUS/200801_/Dados/PASC2512.dbc",
              destfile = temp, mode = "wb") 
PASC2512 <- read.dbc::read.dbc(temp) 
names(PASC2512)
PASC2512 <- PASC2512[sample(PASC2512$PA_CODUNI, 1000), ]
# PASC2512 <- PASC2512[sample(PASC2512$PA_CODUNI, 1000), -c(5:15,17:33,35:37,45:59,61)] 

usethis::use_data(PASC2512, overwrite = TRUE)
