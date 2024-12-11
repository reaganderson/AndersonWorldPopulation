#' Makes a graph of the WorldPopulation data
#'
#' Takes WorldPopulation data set and given a country name, returns a graph of
#' the population of that country from 1950 to 2020.
#'
#' @param country_name the name of a country in the data set
#' @return a line graph of the given countries population from 1950 to 2020
#' @examples
#' CountryPopulation('United States of America')
#' CountryPopulation('China')
#' @export
CountryPopulation <- function( country_name )
{
  WorldPopulation <- AndersonWorldPopulation::WorldPopulation

  if( !(country_name %in% WorldPopulation$Country_Name))
  {
    stop(paste('Error! ', country_name, ' does not exist in the data.', sep=''))
  }

  plot_func <- dplyr::filter(WorldPopulation,
                            stringr::str_detect(Country_Name,
                                                paste('^', country_name, '$',
                                                      sep='')))

  ggplot2::ggplot(plot_func,
         ggplot2::aes(x=Year, y=Population)) +
    ggplot2::geom_line() +
    ggplot2::labs(x="Year", y="Population(in 1000s)") +
    ggplot2::labs(title=paste(country_name))
}
