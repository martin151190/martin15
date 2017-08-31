#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(plyr)
library(dplyr)
library(RColorBrewer)
#install.packages("gplots")
library(gplots)
#install.packages("ggplot2")
library("ggplot2")
library("scales")
library("reshape2")
library(lattice)
library(latticeExtra)
library(plotly)
library(shiny)
#install.packages("extrafont")
library(extrafont)


#install.packages("shinythemes")
library(readxl)
library(shinythemes)
library("tidyr")
library(dplyr)

library(plotly);library(visNetwork);library(shinyBS)
#install.packages("formattable")
library('formattable')

# Define UI for application that draws a histogram
shinyUI(fluidPage( tags$head(
  tags$style(HTML("
                  @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                  
                  h1 {
                  font-family: 'Lobster', cursive;
                  font-weight: 500;
                  line-height: 1.1;
                  color: blue4;
                  }
                  
                  "))
  ),
  
  headerPanel("Ejecucion de los indicadores"),
  sidebarPanel(
    sliderInput("Ano", "Ano", min = 2012, max = 2016, value = 1), width=3),
  mainPanel(
    plotlyOutput(outputId = "p", height=550, width = 100)
  )
  ))
