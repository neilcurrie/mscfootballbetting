
#' Download Raw Data
#'
#' Downloads football match data from football-data.co.uk for the 22 leagues
#' available (as of 18/07/2016).
#' 
#' @usage 
#' download_raw_data(file_save_location, season_end_year = 2016)
#' 
#' @param file_save_location
#' the path to the folder which the data will be saved in
#' @param season_end_year
#' the year in which the current season or the final season required finishes
#' 
#' @details 
#' Downloads all data from all leagues. This is specified in the 
#' \code{league_information}. To make changes to \code{league_information}, 
#' for instance in a new leagues data is made available through the website
#' or to delete an entry because it is not wanted, the 
#' \code{get_league_information} function code or it's output should be 
#' modified.
#' @return
#' None
#' @examples
#' 
#' file_save_location <- 'my_path'
#' season_end_year <- 2016
#' download_raw_data(mypath, season_end_year)
#' 
#' @export

download_raw_data <- function(file_save_location, season_end_year = 2016){
  
  # Preliminaries
  league_information <- get_league_information(season_end_year)
  start_of_url <- 'http://www.football-data.co.uk/mmz4281/'
  num_leagues <- nrow(league_information)
  
  for(i in 1:num_leagues){
    league_id   <- league_information[i,'league_id']
    website_id  <- league_information[i,'website_id']
    years       <- seq(league_information[i,'start_year'],
                       league_information[i,'season_end_year'])
    num_seasons <- length(years) - 1
    years_short <- substr(years, nchar(years)-1, nchar(years))
    season_ids  <- build_season_ids(years)
    
    for(j in 1:num_seasons){
      season_id <- season_ids[j]
      
      # Download that seasons data
      raw_data_url <- paste0(start_of_url,years_short[j],years_short[j+1],'/',
                             website_id,'.csv')
      raw_data <- read.csv(url(raw_data_url))
      
      # Save that seasons data
      file_name <- paste0(file_save_location,league_id,'_',season_id,'.csv')
      write.csv(raw_data, file_name)
      
    }
  }
}