library(tidyverse)
library(readxl)
library(janitor)


# Survey Monkey -----------------------------------------------------------

survey_monkey_data_raw <- read_excel("data/survey-monkey-data.xlsx")

survey_monkey_data_tidy <- survey_monkey_data_raw %>% 
  clean_names() %>% 
  select(-x8) %>% 
  # slice(-1)
  drop_na(start_date) %>% 
  pivot_longer(cols = -start_date,
               names_to = "question",
               values_to = "response") %>% 
  select(-question) %>% 
  drop_na(response) %>% 
  mutate(response = str_remove(response, "- "))

survey_monkey_data_tidy %>% 
  count(response)


# Qualtrics ---------------------------------------------------------------


qualtrics_data_raw <- read_excel("data/qualtrics-data.xlsx",
                                 skip = 1)

qualtrics_data_raw %>% 
  clean_names() %>% 
  mutate(id = row_number()) %>% 
  select(id, select_all_the_things_youve_done_in_the_past_24hours_selected_choice) %>% 
  separate_rows(select_all_the_things_youve_done_in_the_past_24hours_selected_choice,
                sep = ",") %>% 
  count(select_all_the_things_youve_done_in_the_past_24hours_selected_choice)


# Google Forms/Sheets -----------------------------------------------------

google_sheets_raw <- read_excel("data/google-forms-data.xlsx")

google_things_last_24 <- google_sheets_raw %>% 
  clean_names() %>% 
  mutate(id = row_number()) %>% 
  relocate(id) %>% 
  separate_rows(select_all_the_things_youve_done_in_the_past_24hours,
                sep = ", ")

choices_last_24hrs <- c("Eaten food", "Slept", "Gone to work", "Cooked food",
                        "Relaxed with a hobby (TELL US THE HOBBY BY TYPING IN THE OTHER FIELD)",
                        "Commuted for work")

msleep %>% 
  relocate(sleep_total, .after = genus)


google_things_last_24 %>% 
  count(select_all_the_things_youve_done_in_the_past_24hours,
        sort = TRUE) %>% 
  filter(n > 3)


google_things_last_24 %>% 
  filter(select_all_the_things_youve_done_in_the_past_24hours %in% choices_last_24hrs) %>% 
  count(select_all_the_things_youve_done_in_the_past_24hours,
        sort = TRUE)


google_things_last_24 %>% 
  filter(!select_all_the_things_youve_done_in_the_past_24hours %in% choices_last_24hrs) %>% 
  count(select_all_the_things_youve_done_in_the_past_24hours,
        sort = TRUE)


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

