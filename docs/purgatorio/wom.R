wom <- function(date) {
  first <- lubridate::wday(as.Date(
    paste(lubridate::year(date), lubridate::month(date), 1, sep="-"))
  )
  return((lubridate::mday(date)+(first-2)) %/% 7+1)
}
