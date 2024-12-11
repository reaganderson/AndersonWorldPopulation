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
  data(WorldPopulation, package=AndersonWorldPopulation)

  if( !(country_name %in% WorldPopulation$Country_Name))
  {
    stop(paste('Error! ', country_name, ' does not exisit in the data.', sep=''))
  }

  plot_func <- WorldPopulation %>%
    filter( str_detect(Country_Name, paste('^', country_name, '$', sep='')) )

  ggplot(plot_func,
         aes(x=Year, y=Population)) +
    geom_line() +
    labs(x="Year", y="Population(in 1000s)") +
    labs(title=paste(country_name))
}
