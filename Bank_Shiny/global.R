# libraries & setup ---------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)
library(lubridate)
library(ggplot2)

# Data Import ----

bankm <- read.table("bank-full.csv"
                  ,
                             header = TRUE,
                             sep = ";",
                             stringsAsFactors = FALSE
                   )




# Data Summarise ----

glimpse(bankm) 
summary(bankm)
colSums(is.na(bankm))
table(bankm$job)

# Data Convert ----

bankm <- bankm %>% 
  mutate_if(is.integer, as.numeric) %>% 
  mutate(
    job = as.factor(job),
    default = as.factor(default),
    marital = as.factor(marital),
    education = as.factor(education),
    housing = as.factor(housing),
    loan = as.factor(loan),
    contact = as.factor(contact),
    y = as.factor(y),
    month = as.factor(month),
    age = as.character(age),
    month = as.factor(month)
  )


# Pengelompokkan Umur ----

bankm <- bankm %>% 
  mutate(
    age_grouping = case_when(
      str_detect(age, pattern = "18|19|20|21|22|23|24|25")~"Teen(18-25)",
      str_detect(age, pattern = "26|27|28|29|30|31|32|33|34|35")~"Early Adult(26-35)",
      str_detect(age, pattern = "36|37|38|39|40|41|42|43|44|45")~"Lately Adult(36-45)",
      str_detect(age, pattern = "46|47|48|49|50|51|52|53|54|55")~"Early Mature(46-55)",
      str_detect(age, pattern = "56|57|58|59|60|61|62|63|64|65")~"Lately Mature(56-65)",
      str_detect(age, pattern = "66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95")~"Old Age(>65)"
    )
  )




# Duration ----

bankm <- bankm %>% 
  mutate(
    month_code = case_when(
      str_detect(month, pattern = "jan")~1,
      str_detect(month, pattern = "feb")~2,
      str_detect(month, pattern = "mar")~3,
      str_detect(month, pattern = "apr")~4,
      str_detect(month, pattern = "may")~5,
      str_detect(month, pattern = "jun")~6,
      str_detect(month, pattern = "jul")~7,
      str_detect(month, pattern = "aug")~8,
      str_detect(month, pattern = "sep")~9,
      str_detect(month, pattern = "oct")~10,
      str_detect(month, pattern = "nov")~11,
      str_detect(month, pattern = "dec")~12
    )
  )

bankm <- bankm %>% 
  mutate(
    month_code = as.factor(month_code)
  )


  


