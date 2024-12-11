library(tidyverse)
library(readxl)

estimates <- read_excel('data-raw/World_Population.xlsx', sheet='ESTIMATES', range='A17:BZ306')

WorldPopulation <- estimates %>%
  dplyr::filter(str_detect(Type, 'Country/Area')) %>%
  rename('Country_Name' = `Region, subregion, country or area *`) %>%
  dplyr::select( -Index, -Variant, -Notes, -`Country code`, -Type, -`Parent code` ) %>%
  mutate_at( vars(matches('19\\d{2}|20\\d{2}')), as.numeric )

WorldPopulation <- WorldPopulation %>%
  pivot_longer('1950':'2020', names_to='Year', values_to='Population') %>%
  mutate(Year = as.numeric(Year))

usethis::use_data(WorldPopulation)
