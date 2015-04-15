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

test_that("both directions, e_value, threshold set to med_max", {
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', threshold="med_max", e_value=TRUE)
  expect_equal(length(results$anoms), 3)
  expect_equal(length(results$anoms[[2L]]), 4)
  expect_equal(results$plot, NULL)
})

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

context("Testing NAs")

test_that("check handling of datasets with leading and trailing NAs", {
  raw_data[1:10, "count"] <- NA
  raw_data[length(raw_data[[2L]]), "count"] <- NA
  results <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', plot=T)
  expect_equal(length(results$anoms), 2)
  expect_equal(length(results$anoms[[2L]]), 131)
  expect_equal(class(results$plot), c("gg", "ggplot"))
})

test_that("check handling of datasets with NAs in the middle", {
  raw_data[floor(length(raw_data[[2L]])/2), "count"] <- NA
  expect_error(AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both'))
})

test_that("check handling of datasets with leading and trailing NAs", {
  raw_data[1:10, "count"] <- NA
  raw_data[length(raw_data[[2L]]), "count"] <- NA
  results <- AnomalyDetectionVec(raw_data[[2]], max_anoms=0.02, period=1440, direction='both', plot=T)
  expect_equal(length(results$anoms), 2)
  expect_equal(length(results$anoms[[2L]]), 131)
  expect_equal(class(results$plot), c("gg", "ggplot"))
})

test_that("check handling of datasets with NAs in the middle", {
  raw_data[floor(length(raw_data[[2L]])/2), "count"] <- NA
  expect_error(AnomalyDetectionVec(raw_data[[2L]], max_anoms=0.02, period=1440, direction='both'))
})

context("Testing constant value time series")

test_that("checking for errors if time series has constant value for all values", {
    test <- rep(1,1000)
    expect_true({AnomalyDetectionVec(test, period=14, plot=T, direction='both'); TRUE})

})
