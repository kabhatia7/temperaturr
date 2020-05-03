#' Converts the degrees from Fahrenheit to Celsius
#'
#' @param fah The temperature in degrees Fahrenheit
#'
#' @return A double of the temperature in degrees celsius
get_celsius <- function(fah)
{
  return(round(((fah - 32) * 5 / 9), digits = 2))
}



#' Gives the temperatures of a given location for a given number of days
#'
#' @param latitude The latitude of the location
#' @param longitude The longitude of the location
#' @param num_days The number of days viewed
#' @param api_key The key for the api
#'
#' @return A data frame of temperatures with dates and observation times in UTC(possibly a warning)
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr mutate pull arrange
#' @importFrom lubridate format_ISO8601 now as_datetime year month day
#' @importFrom tibble tibble
#' @export
get_prev_temp <- function(latitude, longitude, num_days = 7, api_key)
{
  selection <- 1
  if(num_days > 14)
  {
  selection <- readline(prompt = "You only have so many queries to this api are, are you sure you want to continue?\n 1: Yes \n 2: No")
  selection <- as.integer(selection)
  }

  if(num_days < 14 | selection == 1)
  {
    full_data = data.frame()
    one_day = 86400

    for(i in 1:num_days)
    {
      x <- as.character(format_ISO8601(now()-((i+1)*one_day)))
      y <- as.character(format_ISO8601(now() - i*one_day))

      curr_day <- GET("https://api.climacell.co/v3/weather/historical/station",
                      query= list(
                        lat = latitude,
                        lon = longitude,
                        fields = "temp",
                        unit_system = "us",
                        start_time = glue::glue("{x}"),
                        end_time = glue::glue("{y}"),
                        apikey = api_key))

      curr_data <- fromJSON(rawToChar(curr_day$content))
      obs_time <- curr_data$observation_time %>%
        mutate(value = as_datetime(value)) %>%
        pull(value)

      value <- curr_data$temp$value
      value_in_C = sapply(value, get_celsius)
      curr_data_table = tibble(observation_time = obs_time,
                               year = year(obs_time),
                               month = month(obs_time),
                               day = day(obs_time),
                               temp_in_F = value,
                               temp_in_C = value_in_C)

      full_data = rbind(full_data, curr_data_table) %>%
        arrange(observation_time)
    }
    return(full_data)
  }
  else{
    return()
  }
}
