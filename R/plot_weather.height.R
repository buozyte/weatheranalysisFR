#' @export
plot_weather.height <- function(x, yr = NULL, both = TRUE) {
  date <- as.Date(paste(row.names(klimaFR), "01"), "%b %Y %d")
  all <- data.frame("date" = date, "hei" = as.numeric(x))
  spe <- data.frame("date" = date[1:12], "hei50" = as.numeric(x)[1:12],
                    "hei80" = as.numeric(x)[361:372], "hei10" = as.numeric(x)[721:732])

  p1 <- ggplot(all, aes(x=date, y=hei)) +
    geom_line() +
    labs(y="mm", x="year", title="Precip over time") +
    scale_x_date(labels = date_format("%Y"))

  colnames(spe) <- c("date", "1950", "1980", "2010")
  meltspe <- melt(spe, id = "date")

  p2 <- ggplot(meltspe, aes(x = date, y = value)) +
    geom_line(aes(colour = variable))+
    labs(y="mm", x="month", title="Precip in 1950, 1980, 2010", colour = "Years") +
    scale_x_date(labels = date_format("%b"))

  pfin <- plot_grid(p1, p2, ncol = 1)

  psfin <- NULL
  p4 <- NULL
  if (!is.null(yr)) {
    len <- length(yr)
    if (len == 1) {
      if (yr%%1 != 0 || yr<1950 || yr>2010) {
        stop("Please choose a year (Integer) between 1950 and 2010")
      }
      intv <- (((yr-1950)*12)+1):((yr-1949)*12)
      spen <- data.frame("date" = date[intv], "hei" = as.numeric(x)[intv])
      p3 <- ggplot(spen, aes(x = date, y = hei)) +
        geom_line() +
        labs(y="mm", x="month", title=paste("Precip in", yr)) +
        scale_x_date(labels = date_format("%b"))
      psfin <- p3

    } else {
      yrsor <- sort(yr)
      ext <- c(min(yrsor), max(yrsor))
      if (ext[1] < 1950 || ext[2] > 2010) {
        stop("Please choose years between 1950 and 2010.")
      }

      namarr <- NULL
      namstr <- NULL
      p4 <- NULL
      spen <- NULL
      datef <- date[(((yrsor[1]-1950)*12)+1):((yrsor[1]-1949)*12)]
      glines <- NULL
      for (i in 1:len) {
        if (yrsor[i]%%1 != 0) {
          stop("Please choose years (Integer) between 1950 and 2010")
        }

        intvs <- (((yrsor[i]-1950)*12)+1):((yrsor[i]-1949)*12)

        if (is.null(spen)) {
          spen <- data.frame("date" = datef, hei1 = as.numeric(x)[intvs])
          colnames(spen)[i+1] <- paste0("Y", yrsor[i])
        } else {
          spen <- data.frame(spen, heit = as.numeric(x)[intvs])
          colnames(spen)[i+1] <- paste0("Y", yrsor[i])
        }

        if (is.null(namarr)) {
          namarr <- yrsor[i]
          namstr <- toString(yrsor[i])
        } else {
          namarr <- c(namarr, yrsor[i])
          namstr <- c(namstr, toString(yrsor[i]))
        }
      }

      colnames(spen) <- c("date", namstr)
      melspen <- melt(spen, id = "date")

      p4 <- ggplot(melspen, aes(x = date, y = value)) +
        geom_line(aes(colour = variable)) +
        labs(y = "mm", x = "month", title = paste("Precip in", toString(namarr)), colour = "Years") +
        scale_x_date(labels = date_format("%b"))

      intva <- (((ext[1]-1950)*12)+1):((ext[2]-1949)*12)
      alln <- data.frame("date" = date[intva], "hei" = as.numeric(x)[intva])
      p3 <- ggplot(alln, aes(x = date, y = hei)) +
        geom_line() +
        labs(y="mm", x="year", title=paste("Precip between", ext[1], "and", ext[2])) +
        scale_x_date(labels = date_format("%Y"))

      psfin <- plot_grid(p3, p4, ncol = 1)
    }
  } else {
    return(pfin)
  }

  if (both) {
    if(!is.null(p4)) {
      return(plot_grid(p1, p2, p3, p4, ncol = 2, nrow =2))
    } else {
      return(plot_grid(p1, p2, p3, ncol = 2, nrow =2))
    }
  } else {
    return(psfin)
  }
}
