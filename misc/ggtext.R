library(tidyverse)
library(ggtext)
library(palmerpenguins)

ggplot(data = penguins,
       aes(x = flipper_length_mm,
           y = bill_length_mm)) +
  geom_point() +
  labs(title = "Penguins are <span style='color: red;'>really cool</span>") +
  theme(plot.title = element_markdown())
