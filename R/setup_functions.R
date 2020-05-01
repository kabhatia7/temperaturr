#'
#' Input API key to be used for the other functions in the tempraturr, API key variable to your global environment
#'
#' @param apikey Copy and paste climacell API key to be used for use in this function
#'
#'
#' @return variable "apikey" is saved to your environment for further usage of this package
#'
#' @export
register_climacell_key <- function(apikey){

  stopifnot(api != '')

  assign("apikey", apikey, envir = globalenv())

}


#' Call information on the API and the different types of fields that can be passed as arguments
#'
