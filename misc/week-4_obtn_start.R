library(tidyverse)
library(scales)

tfff_dark_green <- "#265142"

# Working on recreating this graph: https://show.rfor.us/hJFyQL

race_ethnicity <- read_csv("data/race-ethnicity.csv") %>%
  filter(geography == "Multnomah",
         year == 2020) %>%
  select(population, value)

race_ethnicity %>% 
  mutate(population = fct_rev(population)) %>% 
  ggplot() +
  geom_col(aes(x = 1,
               y = population),
           fill = "transparent",
           color = tfff_dark_green,
           linetype = "dotted") +
  geom_col(aes(x = value,
               y = population),
           fill = tfff_dark_green) +
  geom_text(aes(x = value + 0.2,
                y = population,
                label = paste(population, scales::percent(value)))) +
  theme_void()
