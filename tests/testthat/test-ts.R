library(AnomalyDetection)
context("Evaluation: AnomalyDetectionTs")

test_that("last day, both directions, with plot", {
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', only_last='day', plot=T)
  expect_equal(length(results$anoms), 2)
  expect_equal(length(results$anoms[[2]]), 25)
  expect_equal(class(results$anoms$timestamp), c("POSIXlt", "POSIXt"))
  expect_equal(class(results$plot), c("gg", "ggplot"))
})

test_that("both directions, e_value, with longterm", {
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', longterm=TRUE, e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2]]), 131)
  expect_equal(class(results$anoms$timestamp), c("POSIXlt", "POSIXt"))
  expect_equal(results$plot, NULL)
})

test_that("both directions, e_value, threshold set to med_max", {
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', threshold="med_max", e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2]]), 4)
  expect_equal(class(results$anoms$timestamp), c("POSIXlt", "POSIXt"))
  expect_equal(results$plot, NULL)
})

context("Evaluation: AnomalyDetectionVec")

test_that("last period, both directions, with plot", {
  results <- AnomalyDetectionVec(raw_data[[2]], max_anoms=0.02, direction='both', period=1440, only_last=TRUE, plot=T)
  expect_equal(length(results$anoms), 2)
  expect_equal(length(results$anoms[[2]]), 25)
  expect_equal(class(results$plot), c("gg", "ggplot"))
})

test_that("both directions, e_value, with longterm", {
  results <- AnomalyDetectionVec(raw_data[[2]], max_anoms=0.02, direction='both', period=1440, longterm_period=1440*14, e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2]]), 131)
  expect_equal(results$plot, NULL)
})

test_that("both directions, e_value, threshold set to med_max", {
  results <- AnomalyDetectionVec(raw_data[[2]], max_anoms=0.02, direction='both', period=1440, threshold="med_max", e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2]]), 6)
  expect_equal(results$plot, NULL)
})




