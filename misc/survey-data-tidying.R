library(tidyverse)
library(readxl)
library(janitor)


# Survey Monkey -----------------------------------------------------------

survey_monkey_data_raw <- read_excel("data/survey-monkey-data.xlsx")

last_24_hours_activity <- survey_monkey_data_raw %>%
  clean_names() %>% 
  drop_na(start_date) %>% 
  select(-c(start_date, x7, x8)) %>% 
  pivot_longer(cols = select_all_the_things_youve_done_in_the_past_24hours:x6) %>% 
  select(-name) %>% 
  mutate(value = str_remove(value, "- ")) %>% 
  drop_na(value)

last_24_hours_activity

survey_monkey_data_raw %>%
  clean_names() %>% 
  drop_na(start_date) %>% 
  select(-start_date) %>% 
  pivot_longer(cols = everything()) %>% 
  select(-name) %>% 
  mutate(value = str_remove(value, "- ")) %>% 
  drop_na(value) %>% 
  count(value) %>% 
  view()


# Qualtrics ---------------------------------------------------------------


qualtrics_data_raw <- read_excel("data/qualtrics-data.xlsx",
                                 skip = 1)

last_24_hours_questions <- qualtrics_data_raw %>%
  clean_names() %>% 
  separate_rows(select_all_the_things_youve_done_in_the_past_24hours_selected_choice,
                sep = ",") 

last_24_hours_questions %>% 
  count(select_all_the_things_youve_done_in_the_past_24hours_selected_choice) %>% 
  ggplot(aes(x = select_all_the_things_youve_done_in_the_past_24hours_selected_choice,
             y = n)) +
  geom_col()


# Google Forms/Sheets -----------------------------------------------------

google_sheets_raw <- read_excel("data/google-forms-data.xlsx")

last_24_hours_questions_google <- google_sheets_raw %>%
  clean_names() %>% 
  separate_rows(select_all_the_things_youve_done_in_the_past_24hours,
                sep = ", ") 

last_24_hours_questions_google


# Google Forms/Sheets Multiple Parts --------------------------------------

google_sheets_raw <- read_excel("data/google-forms-data-part-1.xlsx")

last_24_hours_questions_google <- google_sheets_raw %>% 
  clean_names() %>% 
  separate_rows(select_all_the_things_youve_done_in_the_past_24hours,
                sep = ", ") 


tidy_google_sheets_data <- function(raw_excel_file) {
  
  google_sheets_raw <- read_excel(raw_excel_file)
  
  last_24_hours_questions_google <- google_sheets_raw %>% 
    clean_names() %>% 
    separate_rows(select_all_the_things_youve_done_in_the_past_24hours,
                  sep = ", ") 
  
  last_24_hours_questions_google
  
}

part_1 <- tidy_google_sheets_data("data/google-forms-data-part-1.xlsx")
part_2 <- tidy_google_sheets_data("data/google-forms-data-part-2.xlsx")

bind_rows(part_1, part_2)

google_sheets_data <- c("data/google-forms-data-part-1.xlsx",
                        "data/google-forms-data-part-2.xlsx")

map_df(google_sheets_data,
       tidy_google_sheets_data)

