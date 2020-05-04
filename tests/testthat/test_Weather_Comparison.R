test_that("testing Weather_Comparison", {

  correct_result_row <- 24
  correct_result_col <- 8

  my_result <- weather_comparison(35.2828, -120.6596, "keKglY8JGUawtl9Roz00cFDxokssxVpA")

  expect_equal(nrow(my_result), correct_result_row)
  expect_equal(ncol(my_result), correct_result_col)
})
