# https://stephanieevergreen.com/easy-dot-plots-in-excel/

library(tidyverse)
library(ggtext)

kindergarten_readiness <- tribble(
  ~subject, ~score, ~date,
  "Literacy", 34, "Fall",
  "Literacy", 69, "Spring",
  "Language", 67, "Fall",
  "Language", 75, "Spring"
)