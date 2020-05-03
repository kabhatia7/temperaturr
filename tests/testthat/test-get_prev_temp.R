test_that("testing get_prev_weather", {

  correct_result_row <- (142 * 3) + 2
  correct_result_col <- 6

  my_result <- get_prev_temp(35.2828, -120.6596, 3, "keKglY8JGUawtl9Roz00cFDxokssxVpA")

  expect_equal(nrow(my_result), correct_result_row)
  expect_equal(ncol(my_result), correct_result_col)
})
