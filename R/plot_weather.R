<<<<<<< Updated upstream

#helper function to make data frame with radius around lat and lng
radius <- function(latitude, longitude, num_days, api_key){

  original <- get_prev_temp(latitude, longitude, num_days, api_key) %>% mutate(point = "0")
  lat_1 <-get_prev_temp(latitude+1, longitude, num_days, api_key) %>% mutate(point = "+1_0")
  lat_neg1 <-get_prev_temp(latitude-1, longitude, num_days, api_key) %>% mutate(point = "-1_0")
  lng_1 <- get_prev_temp(latitude, longitude +1, num_days, api_key) %>% mutate(point = "0_+1")
  lng_neg1 <- get_prev_temp(latitude, longitude-1, num_days, api_key) %>% mutate(point = "0_-1")

  radius_data <- rbind(original, lat_1, lat_neg1, lng_1, lng_neg1)

  return(radius_data)
}





plot_weather <- function(latitude, longitude, num_days, CF, api_key) {
=======
#' Uses data pulled from the API to generate a plot of the weather for the past number of user inputted days
#'
#'
#' @importFrom ggplot2 ggplot geom_line scale_linetype_manual scale_color_manual theme ggtitle
#'
#' @param latitude x
#' @param longitude x
#' @param num_days x
#' @param CF x
#' @param api_key x
#'
#' @return plot of temp from the past days
#'
#' @export
plot_weather <- function(latitude , longitude, num_days, CF, api_key) {
>>>>>>> Stashed changes

  weather_data <- radius(latitude, longitude, num_days, api_key)

  ifelse(CF == "F",
         p <- ggplot(data = weather_data, aes(x = observation_time, y = temp_in_F, color = point )) ,
         p <- ggplot(data = weather_data, aes(x = observation_time, y = temp_in_C, color = point )))


  p + geom_line() +
    ylab(paste("Temperature in", CF, sep = " ")) +
    xlab("Date") +
    ggtitle(paste("Last Week's Weather at Latitude: ", latitude, ", Longitude: ", longitude, sep = ""),
            subtitle ="Weather based on radius of +/-1 on both the Latitude and Longitude") +
    scale_linetype_manual(values=c("dotted", "dotted", "solid", "dotted", "dotted")) +
    scale_color_manual(values=c("#B27EB7","#E39AEB","#5E5CC4" , "#88B77E", "#A4E298"),
                       labels = c("Lattitude -1", "Latitude +1", "Entered Point", "Longitude -1", "Longitude +1")) +
    theme(plot.subtitle = element_text(face = "italic"))


<<<<<<< Updated upstream
=======
#' creates dataframe for use for the plot weather function
#'
#'
#' @importFrom dplyr mutate
#' @param latitude x
#' @param longitude x
#' @param num_days x
#' @param api_key x
#'
#' @return a dataframe


radius <- function(latitude, longitude, num_days, api_key){

  original <- get_prev_temp(latitude, longitude, num_days, api_key) %>%
    mutate(point = "0")

  lat_1 <-get_prev_temp(latitude+1, longitude, num_days, api_key) %>%
    mutate(point = "+1_0")

  lat_neg1 <-get_prev_temp(latitude-1, longitude, num_days, api_key) %>%
    mutate(point = "-1_0")

  lng_1 <- get_prev_temp(latitude, longitude +1, num_days, api_key) %>%
    mutate(point = "0_+1")

  lng_neg1 <- get_prev_temp(latitude, longitude-1, num_days, api_key) %>%
    mutate(point = "0_-1")

  radius_data <- rbind(original, lat_1, lat_neg1, lng_1, lng_neg1)

  return(radius_data)
}
>>>>>>> Stashed changes

