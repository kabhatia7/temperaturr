test_that("testing get_prev_weather", {

  correct_result_row <- 286
  correct_result_col <- 6

  my_result <- get_prev_temp(35.2828, -120.6596, 2, "keKglY8JGUawtl9Roz00cFDxokssxVpA")

  expect_equal(nrow(my_result), correct_result_row, tolerance = 5)
  expect_equal(ncol(my_result), correct_result_col, tolerance = 5)
})
