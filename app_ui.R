library("dplyr")
library("ggplot2")
library("tidyverse")
library("shiny")
#Needs: 2 tab shiny application
#intro page-, variables and measures of CO2 described and 3 auto generated values.
#interactive visualization- needs 2 shiny input widgets, caption of why using 
#this chart and patterns it shows.
?selectizeInput
intro <- tabPanel(
  "Introduction", # label for the tab in the navbar
  titlePanel("Introduction"), # show with a displayed title
  mainPanel(
    includeMarkdown('./project.md')
  )
)

# Define content for the second page
co2_page <- tabPanel(
  "CO2 per GDP",
  selectizeInput("Country", "Select Country", co2_per_gdp$country, selected = NULL,
                 multiple = TRUE)
)
co2_vis <- selectInput(
  inputId = "country",
  label = "Select A Country",
  choices = co2_per_gdp$country,
  selected = NULL
)
description <- sidebarPanel(co2_page, co2_vis, 
                            print("Looking at the countries with the highest emissions per dollar of GDP shows which are not doing enough to combat emissions."))

plot_on_page <- mainPanel(
  plotlyOutput(co2_plot)
)
# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  "Exploring CO2 Emitted per dollar of GDP", # application title
  intro,         # include the first page content
  co2_page,         # include the second page content
)
