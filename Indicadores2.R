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
loadfonts(device="win")
library("stats")
#install.packages("shinythemes")
library(readxl)
library(shinythemes)
library("tidyr")
library(dplyr)

#install.packages("shinyBS")
library(plotly);library(visNetwork);library(shinyBS)
#install.packages("formattable")
library('formattable')

#write.csv(data, "data.csv")
setwd("C:/Users/martin.castro/Desktop/Shiny/Sep/App")
data<-read.csv("data3.csv", encoding = "UTF-8", sep = ";")
names(data)[2] <- "Ano" #Por el indicador de la columna k=1,2,..K variables
names(data)[5] <- "Definicion" #Por el indicador de la columna k=1,2,..K variables
names(data)[9] <- "Cumplio" #Por el indicador de la columna k=1,2,..K variables

ui<-(fluidPage( theme = shinytheme("journal"), tags$head(
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


Server<-function(input, output) {
 
  output$p <- renderPlotly({ df_term
    <- reactiveDf <- reactive(dplyr::filter(data, Ano %in% input$Ano))
  
  g<-ggplot(data = df_term, aes(x =Provincia , y = Indicador)) +
    geom_tile(aes(fill = Cumplio, text = txt), colour = 'white') +theme_classic()+
    theme(axis.text.x = element_text(angle = 90, family="Officina Serif ITC", size = 10), 
          axis.text.y = element_text(family="Officina Serif ITC", size = 10),
          legend.title = element_blank(),
          legend.text=element_text(family="Officina Serif ITC", size = 10),
           axis.title =element_text(colour="black", size = 12, family = "Officina Serif ITC", face = "bold"),
          legend.key.height = unit(10, "cm"), 
          legend.key.width  = unit(1, "cm"),legend.position="bottom")+
    
    scale_fill_manual(values = c("palegreen2","firebrick1","lightgoldenrod1") , na.value="cornsilk3",
                      breaks = c("No cumplio la meta",'Proximo a cumplir la meta','Cumplio la meta'))+ 
    
     labs(x = "", y="")  

  
  m <- list(
   l = 200,
   r = 80,
   b = 100,
   t = 100  )
  
  a<-ggplotly(g, tooltip = "text")%>%   layout(autosize = F, width = 1000, height = 600, margin = m)
  a  
  })
}

shinyApp(ui, Server)


