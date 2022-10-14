library(tidyverse)
library(scales)


tfff_dark_green <- "#265142"

# Working on recreating this graph: https://show.rfor.us/hJFyQL

race_ethnicity <- read_csv("data/race-ethnicity.csv") %>%
  filter(geography == "Multnomah") %>%
  filter(year == 2020) %>% 
  select(population, value)

race_ethnicity

race_ethnicity_for_viz <- race_ethnicity %>% 
  mutate(population = fct_rev(population)) %>% 
  mutate(value_pct = percent(value, accuracy = 0.1)) %>% 
  mutate(text_label = str_glue("{population}: {value_pct}"))

race_ethnicity_for_viz_white <- race_ethnicity_for_viz %>% 
  filter(population == "White")

race_ethnicity_for_viz_nonwhite <- race_ethnicity_for_viz %>% 
  filter(population != "White")

ggplot(data = race_ethnicity_for_viz,
       aes(y = population,
           x = value)) +
  geom_col(aes(y = population,
               x = 1),
           linetype = "dotted",
           fill = "transparent",
           color = "Grey 90") +
  geom_col(fill = tfff_dark_green) +
  geom_text(data = race_ethnicity_for_viz_nonwhite,
            aes(y = population,
                x = value,
                label = text_label),
            nudge_x = 0.01,
            hjust = 0,
            family = "Calibri") +
  geom_text(data = race_ethnicity_for_viz_white,
            aes(y = population,
                x = value,
                label = text_label),
            nudge_x = -0.01,
            hjust = 1,
            color = "white",
            family = "Calibri") +
  labs(title = "POPULATION BY RACE/ETHNICITY") +
  theme_void() +
  theme(plot.title = element_text(face = "bold",
                                  family = "Calibri"))


