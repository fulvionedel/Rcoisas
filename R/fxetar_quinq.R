#' @title Age groups in five years, for DATASUS data
#' @aliases fxetar_quinq
#' @description Recode the "detailed age groups" variables of DATASUS tables into a variable with five years age groups, from 0-4 to 80 and more (17 levels)
#'
#' @param x Age group with 34 levels: yearly from 0 to 19 years, five year from 20 to 80, and 80 and more (classificação "faixa etária detalhada" do DATASUS)

fxetar_quinq <-
  function (x)
  {
    fxetar5 <- cut(as.numeric(x),
                   breaks = c(0, 5, 10, 15, 20, 21, 22, 23, 24, 25, 26, 27,
                              28, 29, 30, 31, 32, 33))
    levels(fxetar5) <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29",
                         "30-34", "35-39", "40-44", "45-49", "50-54", "55-59",
                         "60-64", "65-69", "70-74", "75-79", "80 +")
    attr(fxetar5, which="label") <- "Faixa etaria quinquenal"
    return(fxetar5)
  }
