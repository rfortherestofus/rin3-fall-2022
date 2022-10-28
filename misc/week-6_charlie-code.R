library(tidyverse)

bmi_data <- read_csv(here::here("data", "bars-too-long.csv"))

bmi_data %>% 
  ggplot(aes(x = heart_disease,
             y = avg_bmi)) +
  geom_col() +
  facet_wrap(~ sex)

avg_bmi_data <- bmi_data %>% 
  group_by(heart_disease, sex) %>% 
  summarise(avg_avg_bmi = mean(avg_bmi)) %>% 
  ungroup()

avg_bmi_data %>% 
  mutate(avg_avg_bmi = avg_avg_bmi / 100) %>% 
  ggplot(aes(x = heart_disease,
             y = avg_avg_bmi)) +
  geom_col() +
  facet_wrap(~ sex)

ggplot(avg_bmi_data)

rep("Cats", 5)

"Cats" %>% 
  rep(5)




msleep %>% 
  ggplot(aes(x = vore)) +
  geom_bar()

vore_count <- msleep %>% 
  count(vore) 


ggplot(vore_count,
       aes(x = vore,
             y = n)) +
  geom_col()

msleep %>% 
  group_by(vore) %>% 
  summarise(avg_sleep = mean(sleep_total)) %>% 
  ggplot(aes(x = vore,
             y = avg_sleep)) +
  geom_col()



iris %>% 
  as_tibble() %>% 
  mutate(across(starts_with("Sepal"),
                ~ . * 10))





