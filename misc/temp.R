library(tidyverse)
library(palmerpenguins)

penguins %>% 
  summarize(mean_bill_length = mean(bill_length_mm,
                                    na.rm = TRUE)) %>% 
  summarize(mean_bill_depth = mean(bill_depth_mm,
                                   na.rm = TRUE))


penguins %>% 
  summarize(mean_bill_length = mean(bill_length_mm,
                                    na.rm = TRUE),
            mean_bill_depth = mean(bill_depth_mm,
                                   na.rm = TRUE)) 


penguins

penguins %>% 
  mutate(not_actually_na = "NA") %>% 
  drop_na(not_actually_na)

read_csv("data/penguins.csv",
         na = c("male", ""))


msleep %>% 
  select(name, conservation) %>% 
  mutate(conservation = replace_na(conservation, "unknown"))

starwars %>%
  select(name, eye_color) %>%
  mutate(eye_color = na_if(eye_color, "unknown")) %>% 
  view()

starwars %>%
  select(name, eye_color) %>%
  mutate(random_variable = NA_integer_) %>% 
  mutate(random_variable = replace_na(random_variable, 0))
  view()
  
starwars %>% 
  filter(hair_color %in% c("blond", "black"))

starwars %>% 
  filter(hair_color == "brown")

starwars %>% 
  filter(str_detect(string = hair_color,
                    pattern = "brown"))

starwars %>% 
  select(contains("color"))

install.packages("gt")




library(tidyverse)
library(tidycensus)
library(janitor)

get_acs(year = 2019,
        geography = "county",
        geometry = TRUE,
        state =  "OR",
        variables = "B01003_001") %>% 
  clean_names() %>% 
  mutate(
    name = str_remove(name, " County")) %>% 
  rename(poulation = estimate,
         county = name) %>% 
  select(county, population)


