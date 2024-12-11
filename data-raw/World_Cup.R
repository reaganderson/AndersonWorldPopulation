library(tidyverse)
library(rvest)

url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'

wiki_data <- read_html(url)

table <- wiki_data %>%
  html_nodes('table') %>%
  .[[4]] %>%
  html_table(header=FALSE, fill=TRUE)

World_Cup <- table %>%
  dplyr::select(X1, X2, X5, X4, X6) %>%
  mutate(Year = X1, Host = X2, Matches = X5, Total_Attendance = X4, Avg_Attendance = X6) %>%
  dplyr::select(-X1, -X2, -X5, -X4, -X6) %>%
  slice(-1 * 1:2) %>%
  slice(-26)

World_Cup <- World_Cup %>%
  mutate( Total_Attendance = str_replace_all(Total_Attendance, pattern=',', replacement='') ) %>%
  mutate( Avg_Attendance = str_replace_all(Avg_Attendance, pattern=',', replacement='') ) %>%
  mutate( Total_Attendance = as.numeric(Total_Attendance),
          Avg_Attendance = as.numeric(Avg_Attendance) ) %>%
  dplyr::filter(!is.na(Total_Attendance))

World_Cup <- World_Cup %>%
  mutate( WorldCup = str_c(Host, Year, sep='', collapse=NULL)) %>%
  dplyr::select(-Host, -Year) %>%
  relocate(WorldCup)

usethis::use_data(World_Cup)
