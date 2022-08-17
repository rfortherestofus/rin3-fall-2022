library(fs)
library(pagedown)
library(tidyverse)
library(knitr)

rmd_files <- dir_ls(path = "slides",
                     regexp = ".Rmd")

walk(rmd_files, knit)

html_files <- dir_ls(path = "slides",
                     regexp = ".html")

walk(html_files, chrome_print)


md_files <- dir_ls(regexp = "slides-") 

walk(md_files, file_delete)

beepr::beep()