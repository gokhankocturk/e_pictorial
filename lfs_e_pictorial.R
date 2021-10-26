library(echarts4r)
library(echarts4r.assets)
library(readxl)
library(dplyr)
library(tidyr)
library(Cairo)
library(extrafont)
library(data.table) 
library(htmlwidgets)

# Import Data
lfs_2014_2021 <- read_xls("lfs_2014_2021.xls")
lfs_2014_2021$year <- as.factor(lfs_2014_2021$year)

# Data Wrangling
lfs_economic_activity <- lfs_2014_2021 %>% 
  select(year, month, agriculture_n:services_n) %>% 
  filter(year %in% c(2019, 2020, 2021), month == "8") %>% 
  mutate(month = case_when(month == "8" ~ "August")) %>% 
  setnames(old = c("agriculture_n", "industry_n", "services_n", "constraction_n"),
           new = c("Agriculture", "Industry", "Services", "Constraction"))

lfs_economic_activity %>% 
  e_charts(year) %>% 
  e_pictorial(Agriculture,
              name = "Agriculture",
              symbol = ea_icons("user"),
              symbolRepeat = TRUE,
              barGap = "-30%",
              symbolSize = c(15, 15)) %>% 
  e_pictorial(Constraction,
              name = "Constraction",
              symbol = ea_icons("user"),
              symbolRepeat = TRUE,
              barGap = "-30%",
              symbolSize = c(15, 15)) %>% 
  e_pictorial(Industry,
              name = "Industry",
              symbol = ea_icons("user"),
              symbolRepeat = TRUE,
              barGap = "-30%",
              symbolSize = c(15, 15)) %>% 
  e_pictorial(Services,
              name = "Services",
              symbol = ea_icons("user"),
              symbolRepeat = TRUE,
              barGap = "-30%",
              symbolSize = c(15, 15)) %>% 
  e_title(text = "Economic Activity Estimations in Turkey", 
          subtext = "2019 - 2020 - 2021 August LFS Data",
          top = 0,
          left = "center",
          textStyle = list(fontsize = "28", color = "#0072B2"),
          subtextStyle = list(fontStyle = "italic", fontSize = "14")) %>% 
  e_grid(right = "20%", top = "100") %>% 
  e_legend(type = "scroll",
           right = "15",
           top = "40%",
           orient = "vertical",
           itemGap = 15) %>% 
  e_axis_labels(x = "Year",
                y = "Population") %>% 
  e_x_axis(nameTextStyle = list(color = "#FFFAFA"),
           axisLabel = list(color = "#FFFAFA", fontWeight = "bold")) %>% 
  e_y_axis(nameTextStyle = list(color = "#FFFAFA", fontWeight = "bold"),
           axisLabel = list(color = "#FFFAFA")) %>% 
  e_labels(position = "top") %>% 
  e_color(color = c("red", "#98FB98", "blue", "orange"),
          background = "#575757") %>% 
  e_tooltip(trigger = "axis") %>% 
  e_theme("wonderland") %>% 
  e_toolbox_feature("dataZoom") %>% 
  e_toolbox_feature("dataView") %>% 
  e_toolbox_feature("saveAsImage") %>% 
  e_hide_grid_lines() %>% 
  htmlwidgets::saveWidget(file = "lfs_economic_activity_pictorial.html")
