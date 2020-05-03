test_that("testing radius", {

  correct_result_row <- 1453
  correct_result_col <- 7

  my_result <- radius(35.2828, -120.6596, 3, "wuef6wJsQ3A0wwh9IMFsT8unWLjc5wts")

  expect_equal(nrow(my_result), correct_result_row, tolerance = 10)
  expect_equal(ncol(my_result), correct_result_col)

  })


test_that("testing plot_weather", {

  correct_result <- TRUE

  my_result <- plot_weather(35.2828, -120.6596, 3, "F", "wuef6wJsQ3A0wwh9IMFsT8unWLjc5wts")

  expect_equal(is.ggplot(my_result), correct_result)


})
