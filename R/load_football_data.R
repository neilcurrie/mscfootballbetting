
#' Load Football Data
#' 
#' General function for loading football match data into R from a csv
#' file.
#' 
#' @usage
#' load_football_data(league_id, strings_as_factors = FALSE, directory)
#' 
#' @param league_id
#' string, the id of the league to load
#' Default = FALSE.
#' @param strings_as_factors
#' logical, whether or not to convert strings to factors. Default = FALSE
#' (recommended).
#' 
#' @param directory
#' string, the directory which contains the csv file. Default should
#' be changed by the user.
#' 
#' @return 
#' a data.frame containing football match data
#' 
#' @details 
#' Function converts dates into date format. Necessary for later use within 
#' the package.
#' 
#' 
#' @export

load_football_data <- function(league_id, strings_as_factors = FALSE,
directory = 'C:/Users/Neil/OneDrive/Documents/Final Dissertation/Football Data'
                                         ){
  
  # Load Data
  file_name <- paste0(directory,'/',league_id,'.csv')
  football_data <- read.csv(file_name, stringsAsFactors = strings_as_factors)
  football_data <- football_data[,-1]
  
  football_data$date <- as.Date(football_data$date)
  
  return(football_data)
}