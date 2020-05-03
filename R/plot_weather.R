#' Uses data pulled from the API to generate a plot of the weather for the past number of user inputted days
#'
#'
#' @importFrom ggplot2 ggplot geom_line scale_color_manual theme ggtitle
#'
#'
#' @param latitude latitudinal coordinate of the location, default stored in environment by find_loc function
#' @param longitude longitudinal coordinate of the location, default stored in environment by find_loc function
#' @param num_days Number of days of past weather to be viewed
#' @param CF C for Celsius F for Fahrenheit; default set to "F"
#' @param api_key climacell.io API Key, default stored in environment by register_climacell_key function
#'
#' @return plot of temp from the past days
#'
#' @export
plot_weather <- function(latitude = lat , longitude = lon, num_days, CF = "F", api_key = apikey) {

  weather_data <- radius(latitude, longitude, num_days, api_key)

  ifelse(CF == "F",
         p <- ggplot(data = weather_data, aes(x = observation_time, y = temp_in_F, color = point )) ,
         p <- ggplot(data = weather_data, aes(x = observation_time, y = temp_in_C, color = point )))


  p + geom_line() +
    ylab(paste("Temperature in", CF, sep = " ")) +
    xlab("Date") +
    ggtitle(
      paste("Last Week's Weather at Latitude: ", latitude, ", Longitude: ", longitude, sep = ""),
      subtitle ="Weather based on radius of +/-1 on both the Latitude and Longitude"
    ) +
    scale_color_manual(
      values=c("#B27EB7","#E39AEB","#5E5CC4" , "#88B77E", "#A4E298"),
      labels = c("Lattitude -1", "Latitude +1", "Entered Point", "Longitude -1", "Longitude +1")
    ) +
    theme(plot.subtitle = element_text(face = "italic"))

}


#' creates dataframe for use for the plot weather function
#'
#'
#' @param latitude latitudinal coordinate of the location
#' @param longitude longitudinal coordinate of the location
#' @param num_days Number of days of past weather to be viewed
#' @param api_key climacell.io API Key
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

