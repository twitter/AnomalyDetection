library(AnomalyDetection)

context("Evaluation: AnomalyDetectionVec")

test_that("last period, both directions, with plot", {
  results <- AnomalyDetectionVec(raw_data[[2L]], max_anoms=0.02, direction='both', period=1440, only_last=TRUE, plot=T)
  expect_equal(length(results$anoms), 2)
  expect_equal(length(results$anoms[[2L]]), 25)
  expect_equal(class(results$plot), c("gg", "ggplot"))
})

test_that("both directions, e_value, with longterm", {
  results <- AnomalyDetectionVec(raw_data[[2L]], max_anoms=0.02, direction='both', period=1440, longterm_period=1440*14, e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2L]]), 131)
  expect_equal(results$plot, NULL)
})

test_that("both directions, e_value, threshold set to med_max", {
  results <- AnomalyDetectionVec(raw_data[[2L]], max_anoms=0.02, direction='both', period=1440, threshold="med_max", e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2L]]), 6)
  expect_equal(results$plot, NULL)
})
