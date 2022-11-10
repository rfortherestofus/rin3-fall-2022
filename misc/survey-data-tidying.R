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



# Google Forms/Sheets -----------------------------------------------------

google_sheets_raw <- read_excel("data/google-forms-data.xlsx")


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

