# Arquivo de dados: Declarações de Óbito - SIM. RS, 2019

library(microdatasus)
library(csapAIH)
library(dplyr, warn.conflicts = FALSE)

obitosRS2019 <- fetch_datasus(year_start = 2019, 
                              year_end = 2019, 
                              uf = "RS",
                              information_system = "SIM-DO") %>% 
  slice_sample(prop = .01)

obitosRS2019 <- obitosRS2019 %>%
  bind_cols(idadeSUS(., "SIM")) %>% 
  select(-IDADE) %>% 
  process_sim() %>% 
  mutate(idade = as.numeric(idade),
         sexo = factor(SEXO, 
                       levels = c("Masculino", "Feminino"), 
                       labels = c("masc", "fem"))) %>% 
  select(-SEXO) 
rownames(obitosRS2019) <- NULL

for(i in 1:ncol(obitosRS2019)) {
  if(is.factor(obitosRS2019[,i])) {
    obitosRS2019[,i] <- iconv(obitosRS2019[,i], to='ASCII//TRANSLIT')
  }
}

usethis::use_data(obitosRS2019, overwrite = TRUE)
