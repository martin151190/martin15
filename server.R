#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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

#install.packages("shinythemes")
library(readxl)
library(shinythemes)
library("tidyr")
library(dplyr)

library(plotly);library(visNetwork);library(shinyBS)
#install.packages("formattable")
library('formattable')


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    reactiveDf <- reactive(dplyr::filter(data, Ano %in% input$Ano))
  
  output$p <- renderPlotly({ 
    g<-ggplot(reactiveDf(), aes(x =Provincia , y = Indicador)) +
      geom_tile(aes(fill = Cumplio, text = txt), colour = 'white') +theme_classic()+
      theme(axis.text.x = element_text(angle = 90, family="Officina Serif ITC", size = 12), 
            axis.text.y = element_text(family="Officina Serif ITC", size = 12),
            legend.title = element_blank(),
            legend.text=element_text(family="Officina Serif ITC", size = 12),
            axis.title =element_text(colour="black", size = 12, family = "Officina Serif ITC", face = "bold"),
            legend.key.height = unit(10, "cm"), 
            legend.key.width  = unit(1, "cm"),legend.position="bottom")+
      
      scale_fill_manual(values = c("palegreen2","firebrick1","lightgoldenrod1") , na.value="cornsilk3",
                        breaks = c("No cumplio la meta",'Próximo a cumplir la meta','Cumplio la meta'))+ 
      
      labs(x = "", y="")   
  
  
  m <- list(
    l = 200,
    r = 80,
    b = 100,
    t = 100  )
  
  a<-ggplotly(g, tooltip = "text")%>%   layout(autosize = F, width = 1000, height = 600, margin = m)
  a  
  })
})