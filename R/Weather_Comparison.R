#' Gives a Data Set of Weather Data for Today(The Upcoming 24 hours ) and Tommorow(The Following 24 hours) with the diffrences between the two days included as well .
#'
#' @param latitude The latitude of the location
#' @param longitude The longitude of the location
#' @param api_key The key for the api

#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom tidyverse arrange rename tibble
#' @importFrom lubridate format_ISO8601 now as_datetime
#'
#' @return A data set with weather information between today and tommorow and the diffrences by hour
#' @export
#'



weather_comparison <- function(latitude, longitude, api_key)
{
  next_day = data.frame()
  one_day = 86400*2.3 # number of seconds per day

#  for(i in 1)
#  {
    today <- as.character(format_ISO8601(now() + one_day))

    curr_day <- GET("https://api.climacell.co/v3/weather/forecast/hourly?unit_system=si&start_time=now",
                    query= list(
                      lat = latitude,
                      lon = longitude,
                      fields = "temp",
                      unit_system = "us",
                      end_time = glue::glue("{today}"),
                      apikey = api_key))

    curr_data <- fromJSON(rawToChar(curr_day$content))
    obs_time <- curr_data$observation_time %>%
      mutate(value = as_datetime(value)) %>%   #as_datetime
      pull(value)

    value <- curr_data$temp$value
    value_in_C = sapply(value, get_celsius)
    curr_data_table = tibble(observation_time = as_datetime(-25200,obs_time),
                             temp_in_F = value,
                             temp_in_C = value_in_C)

    next_day = rbind(next_day, curr_data_table) %>%
      arrange(observation_time)

    tommorow =  data.frame(next_day[1:24,1:3],next_day[25:48,1:3])
      #data.frame(full_data[1:24,1:3],full_data[25:48,1:3])
    tommorow$diffrence_in_F = tommorow[,2] - tommorow[,5]
    tommorow$diffrence_in_C = tommorow[,3] - tommorow[,6]
    tommorow = tommorow%>%
      rename(
        Day1_Times = observation_time,
        Day1_Temp_in_F = temp_in_F,
        Day1_Temp_in_C= temp_in_C,
        Day2_Times = observation_time.1,
        Day2_Temp_in_F = temp_in_F.1,
        Day2_Temp_in_C= temp_in_C.1,
        Diffrence_in_F= diffrence_in_F,
        Diffrence_in_C= diffrence_in_C

      )

# }
  return(tommorow)
}

#x =Weather_Comparison(35.2828, -120.6596, "keKglY8JGUawtl9Roz00cFDxokssxVpA")


get_celsius <- function(fah)
{
  return(round(((fah - 32) * 5 / 9), digits = 2))
}
