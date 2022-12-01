# https://stephanieevergreen.com/easy-dot-plots-in-excel/

library(tidyverse)
library(ggtext)

kindergarten_readiness <- tribble(
  ~subject, ~score, ~date,
  "Literacy", 34, "Fall",
  "Literacy", 69, "Spring",
  "Language", 67, "Fall",
  "Language", 75, "Spring",
  "Mathematics", 63, "Fall",
  "Mathematics", 77, "Spring",
  "Science", 92, "Fall",
  "Science", 98, "Spring",
  "Creative Arts", 96, "Fall",
  "Creative Arts", 100, "Spring"
) %>% 
  mutate(subject = factor(subject,
                          levels = c("Literacy", "Language", "Mathematics", "Science", "Creative Arts"))) %>% 
  mutate(subject = fct_rev(subject))

subject_labels <- kindergarten_readiness %>% 
  filter(date == "Fall")

kindergarten_readiness %>%
  ggplot(aes(x = score,
             y = subject,
             color = date,
             label = score)) +
  geom_point(size = 8) +
  geom_text(color = "white") +
  geom_text(data = subject_labels,
            aes(label = subject),
            hjust = 1.5) +
  scale_color_manual(values = c(
    "Fall" = "#867c84",
    "Spring" = "#c15250"
  )) +
  scale_x_continuous(limits = c(0, 100),
                     breaks = seq(from = 0,
                                  to = 100,
                                  by = 10)) +
  labs(title = "Kindergarten readiness increased between <span style='color: #867c84;'>Fall</span> and <span style='color: #be5250;'>Spring</span>") +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        axis.title = element_blank(),
        plot.title = element_markdown(),
        axis.text.y = element_blank(),
        legend.position = "none")
  