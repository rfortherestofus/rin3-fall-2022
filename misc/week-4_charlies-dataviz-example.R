library(WDI)
library(tidyverse)

country_codes <- c("AF", "AL", "DZ", "AS", "AD", "AO", "AI", "AQ", "AG", "AR", 
                   "AM", "AW", "AU", "AT", "AZ", "BS", "BH", "BD", "BB", "BY", "BE", 
                   "BZ", "BJ", "BM", "BT", "BO", "BQ", "BA", "BW", "BV", "BR", "IO", 
                   "BN", "BG", "BF", "BI", "CV", "KH", "CM", "CA", "KY", "CF", "TD", 
                   "CL", "CN", "CX", "CC", "CO", "KM", "CD", "CG", "CK", "CR", "HR", 
                   "CU", "CW", "CY", "CZ", "CI", "DK", "DJ", "DM", "DO", "EC", "EG", 
                   "SV", "GQ", "ER", "EE", "SZ", "ET", "FK", "FO", "FJ", "FI", "FR", 
                   "GF", "PF", "TF", "GA", "GM", "GE", "DE", "GH", "GI", "GR", "GL", 
                   "GD", "GP", "GU", "GT", "GG", "GN", "GW", "GY", "HT", "HM", "VA", 
                   "HN", "HK", "HU", "IS", "IN", "ID", "IR", "IQ", "IE", "IM", "IL", 
                   "IT", "JM", "JP", "JE", "JO", "KZ", "KE", "KI", "KP", "KR", "KW", 
                   "KG", "LA", "LV", "LB", "LS", "LR", "LY", "LI", "LT", "LU", "MO", 
                   "MG", "MW", "MY", "MV", "ML", "MT", "MH", "MQ", "MR", "MU", "YT", 
                   "MX", "FM", "MD", "MC", "MN", "ME", "MS", "MA", "MZ", "MM", 
                   "NR", "NP", "NL", "NC", "NZ", "NI", "NE", "NG", "NU", "NF", "MP", 
                   "NO", "OM", "PK", "PW", "PS", "PA", "PG", "PY", "PE", "PH", "PN", 
                   "PL", "PT", "PR", "QA", "MK", "RO", "RU", "RW", "RE", "BL", "SH", 
                   "KN", "LC", "MF", "PM", "VC", "WS", "SM", "ST", "SA", "SN", "RS", 
                   "SC", "SL", "SG", "SX", "SK", "SI", "SB", "SO", "ZA", "GS", "SS", 
                   "ES", "LK", "SD", "SR", "SJ", "SE", "CH", "SY", "TW", "TJ", "TZ", 
                   "TH", "TL", "TG", "TK", "TO", "TT", "TN", "TR", "TM", "TC", "TV", 
                   "UG", "UA", "AE", "GB", "UM", "US", "UY", "UZ", "VU", "VE", "VN", 
                   "VG", "VI", "WF", "EH", "YE", "ZM", "ZW", "AX")

gdp_annual_growth <- WDI(country = country_codes,
                         indicator = c(gdp_growth = "NY.GDP.MKTP.KD.ZG")) %>% 
  as_tibble()

gdp_most_recent <- gdp_annual_growth %>% 
  filter(year == max(year)) %>% 
  drop_na(gdp_growth) %>% 
  arrange(desc(gdp_growth))

top_growers <- gdp_most_recent %>% 
  head(n = 5)

top_shrinkers <- gdp_most_recent %>% 
  tail(n = 5)

top_growers %>% 
  bind_rows(top_shrinkers) %>% 
  mutate(country = fct_reorder(country, gdp_growth)) %>% 
  ggplot(aes(x = gdp_growth,
             y = country,
             fill = ifelse(gdp_growth > 0, "Grow", "Shrink"))) +
  geom_col() +
  scale_fill_manual(values = c("Grow" = "gold",
                               "Shrink" = "grey"),
                    name = "")


