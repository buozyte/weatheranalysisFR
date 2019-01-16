#' Print a row
#'
#' Creates a text which contains all information about the weather conditions in Freiburg
#'     in the chosen month and year.
#'     Please keep in mind that the year has to be between 1950 and 2010.
#'
#' @note The format of the date should follow the format \%b \%Y
#'     (see: \url{https://www.statmethods.net/input/dates.html})
#'
#' @param x a date (string)
#'
#' @return The described text
#'
#' @examples rowtotext("Jan 1967")
#' rowtotext("Aug 2002")
#' ## next example contains at least one NA
#' rowtotext("Oct 2002")
#'
#' @export
rowtotext <- function(x) {
  if (class(x) != "character" || length(x) > 1) {
    stop("Sorry, the input has so be a (one) string!")
  }
  temp <- format(as.Date(paste(x, "01"), "%b %Y %d"), format = "%B %Y")
  if (is.na(temp)) {
    stop("Your input is not a valid date. Please check the help page for more infomation.")
  }
  info <- klimaFR[row.names(klimaFR) == x,]
  if (length(row.names(info)) == 0) {
    stop ("The year in your input should be between 1950 and 2010.")
  }
  p1 <- (paste("In", temp, "the mean temperature in Freiburg was about", info$temp_mean,
              "ºC. During this month the temperature went up to", info$temp_max,
              "ºC and fell down to", info$temp_min, "ºC on average."))
  p2 <- (paste("The sunshine duration during the whole month was about",
              info$sun_dur, "hours, while the sum of precipitation height was",
              info$precip, "mm.", "Lastly the mean daily wind speed was", info$wind_speed,
              "Bft."))
  for (i in 1:6){
    if (is.na(info[1,i])) {
      warning("It seems like your text includes a 'NA'. This means that this information is unfortunatly missing, sorry!")
      return(paste(p1, p2))
    }
  }
  return(paste(p1, p2))
}
