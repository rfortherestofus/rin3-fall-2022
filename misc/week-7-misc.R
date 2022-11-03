library(tidyverse)
library(palmerpenguins)

penguins %>% 
  mutate(bill_length_categorical = case_when(
    bill_length_mm > 40 ~ "Over 40",
    between(bill_length_mm, 38, 40) ~ "Between 38 and 40",
    TRUE ~ "Less than 38"
  )) %>% 
  view()



animals_eating <- msleep %>% 
  drop_na(vore) %>% 
  count(vore) %>% 
  pivot_wider(names_from = vore,
              values_from = n) 

# ggplot(data = animals_eating,
#        aes(x = )

animals_eating_tidy <- animals_eating %>% 
  pivot_longer(cols = everything(),
               names_to = "animal_type",
               values_to = "n")

ggplot(data = animals_eating_tidy,
       aes(x = animal_type,
           y = n)) +
  geom_col()

data_mike_week_3 <- read_csv(here::here("data", "mike-data-week-3.csv")) %>% 
  slice(1:10) 

data_mike_week_3_tidy <- data_mike_week_3 %>% 
  pivot_longer(cols = Jan:Dec,
               names_to = "month",
               values_to = "widgets") %>% 
  select(-Annual) %>% 
  mutate(widgets = parse_number(widgets)) 

data_mike_week_3_tidy %>% 
  group_by(Sector) %>% 
  summarize(total_widgets = sum(widgets))

library(tidycensus)

acs_poverty_wide <- get_acs(year = 2019,
                            geography = "county",
                            state = "OR",
                            variables = c("n_in_poverty_male" = "S1701_C02_011",
                                          "n_in_poverty_female" = "S1701_C02_012",
                                          "n_in_poverty_under_18" = "S1701_C02_002"),
                            output = "wide")

acs_poverty_wide

