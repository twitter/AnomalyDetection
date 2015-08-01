library(AnomalyDetection)
context("Evaluation: AnomalyDetectionTs")

test_that("last day, both directions, with plot", {
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', only_last='day', plot=T)
  expect_equal(length(results$anoms), 2)
  expect_equal(length(results$anoms[[2L]]), 25)
  expect_equal(class(results$plot), c("gg", "ggplot"))
})

test_that("both directions, e_value, with longterm", {
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', longterm=TRUE, e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2L]]), 131)
  expect_equal(results$plot, NULL)
})

test_that("both directions, e_value, date only", {
    data_file <- system.file("extdata", "data_date.csv", package="AnomalyDetection")
    data <- read.csv(data_file)
    data$timestamp <- as.POSIXlt(data$timestamp, tz = 'UTC')
    results <- AnomalyDetectionTs(data, max_anoms=0.02, direction='both', e_value=TRUE)
    expect_equal(length(results$anoms), 3)
    expect_equal(results$anoms$expected_value, c(26, 27))
    expect_equal(length(results$anoms[[2L]]), 2)
    expect_equal(results$plot, NULL)
})

test_that("both directions, e_value, threshold set to med_max", {
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', threshold="med_max", e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2L]]), 4)
  expect_equal(results$plot, NULL)
})
