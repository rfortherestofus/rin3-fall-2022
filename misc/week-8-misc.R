library(tidyverse)

location_data <- tribble(
  ~id, ~address,
  1, "Las Vegas, USA, 97208, Earth",
  2, "Bristol, UK, 97276",
  3, "Kassala, Sudan, 89654", 
)


location_data %>% 
  separate(address,
           sep = ",",
           into = c("city",
                    "country",
                    "zip_code",
                    "planet"))

device_ownership <- tribble(
  ~name, ~devices_owned,
  "Charlie", "Smart TV, Cell phone",
  "Mohammad", "Cell phone",
  "Christina", "Smart TV, Games Console, Cell phone"
)

device_ownership %>% 
  mutate(smart_tv = str_count(devices_owned, "Smart TV")) %>% 
  mutate(cell_phone = str_count(devices_owned, "Cell phone"))

device_ownership %>% 
  separate_rows(devices_owned,
                sep = ", ") %>% 
  count(devices_owned) %>% 
  ggplot(aes(x = devices_owned,
             y = n)) +
  geom_col()


# Functions ---------------------------------------------------------------



view_acs_variables <- function(year = 2018) {
  tidycensus::load_variables(year, "acs5", cache = TRUE) %>%
    tibble::view()
}

omni_table <- function(df) {
  
  df %>%
    flextable::flextable(...) %>%
    flextable::theme_zebra(even_body = "#9DAECE",
                           odd_body = "#CED6E6") %>%
    flextable::fontsize(part = "all", size = 11) %>%
    flextable::font(part = "all", fontname = "Lato") %>%
    flextable::bold(part = "header", bold = TRUE) %>%
    flextable::bold(part = "body", j = 1, bold = TRUE) %>%
    flextable::align(part = "all", align = "center") %>%
    flextable::bg(part = "header", bg = omni_colors("Dark Blue")) %>%
    flextable::color(part = "header", color = "white") %>%
    flextable::color(part = "body", color = "#333333") %>%
    flextable::bg(part = "body", j = 1, bg = omni_colors("Dark Blue")) %>%
    flextable::color(part = "body", j = 1, color = "white") %>%
    flextable::border_inner(part = "body", border = officer::fp_border(color = "white")) %>%
    flextable::border(part = "header", border.bottom = officer::fp_border(color = "white")) %>%
    flextable::autofit()

}