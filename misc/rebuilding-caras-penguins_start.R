library(tidyverse)
library(palmerpenguins)

penguin_bananas <- penguins %>%
  mutate(banana_quantity = case_when(species == "Adelie" & island == "Biscoe" ~ 1,
                                     species == "Adelie" & island == "Dream" ~ 0.6,
                                     species == "Adelie" & island == "Torgersen" ~ 0,
                                     TRUE ~ 1)) %>% 
  mutate(baking_time = bill_depth_mm,
         yumminess = bill_length_mm) %>% 
  mutate(banana_preference = case_when(
    species == "Chinstrap" ~ "ripe",
    species == "Gentoo" ~ "over-ripe",
    species == "Adelie" ~ "under-ripe"
  ))

banana_colours <- list("under-ripe" = "#89973d",
                       "ripe" = "#e8b92f",
                       "over-ripe" = "#a45e41")



penguin_bananas %>% 
  ggplot(aes(x = baking_time,
             y = yumminess)) +
  geom_point(aes(color = banana_preference))





