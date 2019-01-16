context("Print a row as a string")
library(weatheranalysisFR)

test_that("Class of input not character", {
  expect_error(rowtotext(123))
  expect_error(rowtotext(c("Jan 2003", "Nov 1984")))
})

test_that("Input in wrong format", {
  expect_error(rowtotext("July 2009"))
  expect_error(rowtotext("1984 Aug"))
})

test_that("Year not in range", {
  expect_error(rowtotext("Feb 2011"))
  expect_error(rowtotext("Nov 1940"))
})

test_that("Correct input",{
  expect_equal(rowtotext("Jan 2003"), "In January 2003 the mean temperature in Freiburg was about 2.05 ºC. During this month the temperature went up to 4.68 ºC and fell down to -0.68 ºC on average. The sunshine duration during the whole month was about 54.7 hours, while the sum of precipitation height was 66.1 mm. Lastly the mean daily wind speed was 2.52 Bft.")
  expect_warning(rowtotext("Oct 2002"))
})
