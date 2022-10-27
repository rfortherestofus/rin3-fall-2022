library(tidyverse)
library(janitor)

iris %>% 
  as_tibble() %>% 
  mutate(Sepal.Length = round_half_up(Sepal.Length)) %>% 
  mutate(Sepal.Width = round_half_up(Sepal.Width))

iris %>%
  as_tibble() %>%
  mutate(across(c(Sepal.Length, Sepal.Width), round_half_up))
