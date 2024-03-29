# Arquivo de dados: estimativas populacionais Brasil 2012 e 2019

temp <- tempfile()
download.file("ftp://ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/POPBR12.zip", temp)
POPBR12 <- read.csv(unz(temp, "POPBR12.csv"))

# readr::write_csv2(POPBR12, "data-raw/POPBR12.csv")
usethis::use_data(POPBR12, overwrite = TRUE)

POPRS2019 <- csapAIH::popbr2000_2021(2019, 2019, "RS") |>
  droplevels()
usethis::use_data(POPRS2019, overwrite = TRUE)
