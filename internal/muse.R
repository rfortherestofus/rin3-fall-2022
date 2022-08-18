library(rfortherestofus)
library(tidyverse)

# Post Office Hours -------------------------------------------------------

download_latest_zoom_video() %>% 
  upload_muse_video("R in 3 Months Fall 2022 Office Hours - Week 2")


# Post Cleanshot Video ----------------------------------------------------

download_cleanshot_video("https://show.rfor.us/Ovt8KH") %>% 
  upload_muse_video("DK test")
