#' Lineplot of the weather
#'
#' Generic function to create one grid which includes two or four lineplots.
#'     The first two plots show the chosen weather condition during the years from 1950 to 2010 and during 1950, 1980 and 2010.
#'     The last two show the chosen weather condition during the years from the earliest to the latest of the chosen years and during the chosen years.
#'     If the parameter both is false the first two plots will not be visible.
#'
#' @usage plot_weather(x, ...)
#'
#' ## with extra arguments
#' plot_weather(x, yr)
#' plot_weather(x, yr, both = FALSE)
#'
#' @param x a column from klimaFR. This data frame will set the weather condition.
#' @param yr a integer between 1950 and 2010 or a numeric array with integers between 1950 and 2010. The chosen years will be used to generate the third and fourth plot.
#' @param both a boolean. This boolean will decide whether you will get both grids or only the grid with the chosen years in yr.
#' @param ... further arguments passed to or from other methods
#'
#' @return The described grid
#'
#' @note Without the packages ggplot2, scales, cowplot and reshape2 this function won't work.
#' If you want to have a better plot (e.g. without overlapping titles), use the zoom (in RStudio).
#' Please keep in mind that the plots might have gaps because of the missing infomation in the data frame.
#'
#' @import ggplot2
#' @import cowplot
#' @import scales
#' @import reshape2
#'
#' @examples plot_weather(klimaFR$temp_mean)
#'
#' plot_weather(klimaFR$precip, yr =  c(2000, 1999, 2006))
#'
#' plot_weather(klimaFR$sun_dur, yr =  c(1965, 1954, 1960), both = FALSE)
#'
#' @export
plot_weather <- function (x, ...) {
  UseMethod("plot_weather", x)
}


#' Monthly climate in Freiburg
#'
#' This data set contains various informations about the climate in Freiburg
#'     from 1950 to 2010 in a monthly rhythm.
#'
#' @format A data frame with 732 observations on 8 variables:
#' \describe{
#'   \item{year}{begin of interval (year)}
#'   \item{month}{begin of interval (month)}
#'   \item{temp_mean}{monthly mean of daily temperature means in 2m height in °C}
#'   \item{temp_max}{monthly mean of daily temperature maxima in 2m height in °C}
#'   \item{temp_min}{monthly mean of daily temperature minima in 2m height in °C}
#'   \item{wind_speed}{monthly mean of daily wind speed in Bft}
#'   \item{sun_dur}{monthly sum of sunshine duration in h}
#'   \item{precip}{monthly sum of precipitation height in mm}
#' }
#'
#' @source DWD Climate Data Center (CDC): Historical monthly station observations (temperature, pressure, precipitation, sunshine duration, etc.) for Germany, version v007, 2018. (\url{http://dwd.de})
#'
#' @examples ## mean of the max. temperatures
#' mean(klimaFR$temp_max, na.rm = TRUE)
#' ## sum of sunshine duration in 1950
#' sum(klimaFR$sun_dur[1:12])
#' ## smallest an largest min. temperature
#' min(klimaFR$temp_min, na.rm = TRUE)
#' max(klimaFR$temp_min, na.rm = TRUE)
#' ## precipitation in every december
#' klimaFR$precip[klimaFR$month == "12"]
"klimaFR"
