# Arquivo de dados: Reduzidos da AIH - SIH/SUS. RS, 2019

RDRS2019 <- microdatasus::fetch_datasus(2019, 01, 2020, 06, "RS", "SIH-RD") |>
  dplyr::filter(stringr::str_sub(MUNIC_RES, 1, 2) %in% "43",
                stringr::str_sub(DT_INTER, 1, 4) %in% "2019") #|>
  # dplyr::select(N_AIH:SEXO, PROC_REA, DT_INTER:DIAG_PRINC, MUNIC_MOV:IDADE, CNES, MORTE)

for(i in 1:ncol(RDRS2019)) {
  if(is.factor(RDRS2019[,i]) | is.character(RDRS2019[,i])) {
    RDRS2019[,i] <- iconv(RDRS2019[,i], to='ASCII//TRANSLIT')
  }
}

# RDRS2019 <- RDRS2019[sample(1:nrow(RDRS2019), nrow(RDRS2019)*.05), ]
RDRS2019 <- RDRS2019[sample(1:nrow(RDRS2019), 10000), ]
rownames(RDRS2019) <- NULL
usethis::use_data(RDRS2019, overwrite = TRUE, compress = "xz")

# RDRS2019_sel <- RDRS2019 |>
#   dplyr::select(N_AIH:SEXO, PROC_REA, DT_INTER:DIAG_PRINC, MUNIC_MOV:IDADE, CNES)
# usethis::use_data(RDRS2019_sel, overwrite = TRUE, compress = "xz")

