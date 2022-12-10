library("dplyr")
library("ggplot2")
library("tidyverse")
library("plotly")
library("leaflet")
#set working directory to source files location when testing code here!!
#create graphs here by making df and defining server logic to make graph(s).

#Get data
emissions_data <- read.csv('./data/owid-co2-data.csv', stringsAsFactors = FALSE)
#count rows and columns
features <- ncol(emissions_data)
observations <- nrow(emissions_data)
#Max Co2 emissions per dollar of GDP
co2_per_gdp_max = emissions_data %>%
  filter(co2_per_gdp == max(co2_per_gdp, na.rm = T)) %>%
  select(country, co2_per_gdp)
#Minimum CO2 emissions per $ of GDP (NET ZERO)
co2_per_gdp_min = emissions_data %>%
  filter(co2_per_gdp == min(co2_per_gdp, na.rm = T)) %>%
  select(country, co2_per_gdp)
#Global Average 
avg_co2_per_gdp = mean(emissions_data$co2_per_gdp, na.rm = T)

#Years in dataset
emissions_years_diff = max(emissions_data$year) - min(emissions_data$year)
first_yr = min(emissions_data$year)
last_yr = max(emissions_data$year)

co2_per_gdp <- emissions_data %>% select(year, country, co2_per_gdp)
co2_per_gdp <- drop_na(co2_per_gdp)

#plot formula from textbook chapter 17, figure 17.4 example.
plot_ly(
  data = co2_per_gdp,      # pass in the data to be visualized
  x = co2_per_gdp$year, # use a formula to specify the column for the x-axis
  y = co2_per_gdp$co2_per_gdp, # use a formula to specify the column for the y-axis
  color = co2_per_gdp$country, # use a formula to specify the color encoding
  type = "scatter", # specify the type of plot to create
  mode = "markers"  # determine the "drawing mode" for the scatter (points)
) %>%
  layout(
    title = "Yearly CO2 Emissions per dollar of GDP in each Country",                  # plot title
    xaxis = list(title = "Year", ticksuffix = ""), # axis label + format
    yaxis = list(title = "CO2 Emissions per dollar of GDP", ticksuffix = "kg/$")  # axis label + format
  )
