test_that("testing radius", {

  my_result <- radius(35.2828, -120.6596, 3, "JTg6fvNMPHGhOYGrYRcUBcZEoY2hXhKd")

  expect_equal(nrow(my_result), 1453, tolerance = 10)
  expect_equal(ncol(my_result), 7)

  })


test_that("testing plot_weather", {

  my_result <- plot_weather(35.2828, -120.6596, 3, "F", "JTg6fvNMPHGhOYGrYRcUBcZEoY2hXhKd")

  expect_equal(is.ggplot(my_result), TRUE)

})
