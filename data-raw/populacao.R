library(dplyr)

# Arquivo de dados: estimativas populacionais Brasil 2012

temp <- tempfile()
download.file("ftp://ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/POPBR12.zip", temp)
POPBR12 <- read.csv(unz(temp, "POPBR12.csv"))

# readr::write_csv2(POPBR12, "data-raw/POPBR12.csv")
usethis::use_data(POPBR12, overwrite = TRUE)

# Arquivo de dados: estimativas populacionais RS
##  2019
POPRS2019 <- csapAIH::popbr2000_2021(2019, 2019, "RS") |>
  droplevels() %>% 
  as.data.frame()
usethis::use_data(POPRS2019, overwrite = TRUE)

## 1980, 2010, 2020
pop1980 <- csapAIH::ler_popbr(ano = 1980) %>% 
  mutate(munic_res = as.character(munic_res)) %>% 
  dplyr::filter(fxetaria != "I000",
                substr(munic_res, 1,2) == "43") %>% 
  mutate(fxetar5 = fxetar.det_pra_fxetar5(fxetaria) |> factor(),
         sexo = factor(sexo, labels = c("masc", "fem"))) %>% 
  reframe(populacao = sum(populacao), .by = c(ano, munic_res, sexo, fxetar5))

pop2010 <- csapAIH::ler_popbr(ano = 2010) %>% 
  mutate(munic_res = as.character(munic_res)) %>% 
  dplyr::filter(fxetaria != "I000",
                substr(munic_res, 1,2) == "43") %>% 
  mutate(fxetar5 = fxetar.det_pra_fxetar5(fxetaria) |> factor(),
         sexo = factor(sexo, labels = c("masc", "fem"))) %>%
  reframe(populacao = sum(populacao), .by = c(ano, munic_res, sexo, fxetar5))

pop2020 <- csapAIH::popbr2000_2021(2020, uf = "RS") %>% 
  rename(populacao = pop,
         munic_res = mun) %>% 
  select(-c(CO_UF, UF_SIGLA, REGIAO)) 

levels(pop1980$fxetar5)[1:2] <- levels(pop2010$fxetar5)[1:2] <- levels(pop2020$fxetar5)[1:2]
levels(pop2020$fxetar5)[17] <- levels(pop1980$fxetar5)[17] 

poprs <- full_join(pop1980, pop2010) %>% 
    full_join(pop2020)
  
usethis::use_data(poprs, overwrite = TRUE)
