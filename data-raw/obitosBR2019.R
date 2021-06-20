# Arquivo de dados: Declarações de Óbito - SIM. RS, 2019

library(microdatasus)
library(csapAIH)
library(dplyr, warn.conflicts = FALSE)

obitosRS2019 <- fetch_datasus(2019, 01, 2019, 12, "RS", "SIM-DO") %>% 
  slice_sample(prop = .01)
idadesus <- idadeSUS(obitosRS2019, "SIM")

obitosRS2019 <- obitosRS2019 %>% 
  rename(sexo = SEXO,
         idade = IDADE) %>%
  mutate(sexo = factor(sexo, levels = 1:2, labels = c("masc", "fem")),
         idade      = idadesus[[1]],
         fxetar.det = idadesus[[2]],
         fxetar5    = idadesus[[3]]) 

for(i in 1:ncol(obitosRS2019)) {
  if(is.factor(obitosRS2019[,i])) {
    obitosRS2019[,i] <- iconv(obitosRS2019[,i], to='ASCII//TRANSLIT')
  }
}

usethis::use_data(obitosRS2019, overwrite = TRUE)
