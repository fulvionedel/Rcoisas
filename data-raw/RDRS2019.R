# Arquivo de dados: Reduzidos da AIH - SIH/SUS. RS, 2019

library(microdatasus)

RDRS2019 <- fetch_datasus(2019, 01, 2019, 12, "RS", "SIH-RD")
RDRS2019 <- RDRS2019[sample(1:nrow(RDRS2019), nrow(RDRS2019)*.01), ]
rownames(RDRS2019) <- NULL

for(i in 1:ncol(RDRS2019)) {
  if(is.factor(RDRS2019[,i])) {
    RDRS2019[,i] <- iconv(RDRS2019[,i], to='ASCII//TRANSLIT')
  }
}

usethis::use_data(RDRS2019, overwrite = TRUE, compress = "xz")
