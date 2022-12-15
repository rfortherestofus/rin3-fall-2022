
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(palmerpenguins)
library(rmarkdown)

# Render one report -------------------------------------------------------

render(input = "misc/penguins-parameterized-report.Rmd",
       output_file = "Chinstrap.html",
       params = list(species = "Chinstrap"))

# Render multiple reports -------------------------------------------------

penguin_species <- penguins %>%
  distinct(species) %>%
  pull(species) %>%
  as.character()

penguins %>% 
  pull(species)

render_penguins_report <- function(species_to_use) {
  
  render(
    input = "misc/penguins-parameterized-report.Rmd",
    output_file = str_glue("{species_to_use}.html"),
    params = list(species = species_to_use)
  )
  
}

render_penguins_report(species_to_use = "Gentoo")

# penguin_species <- c("Adelie", "Chinstrap", "Gentoo")

walk(penguin_species, render_penguins_report)


