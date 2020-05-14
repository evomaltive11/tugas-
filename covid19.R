#
# Covid19 Shiny Dashboard. 
# Written by : Nicholas Andrian
# Department of Business statistics, Matana University
# Notes: just for my homework , DON'T reupload this in anywhere or claim this as yourself work.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# A. PACKAGES----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)                                  
library(markdown)

# B. PREPARE YOUR DATABASE  ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# covid19 = read.csv('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv')   
# 
# write.csv(covid19, "Covid19.csv")
# 
# Covid <- read.csv("Covid19.csv")
# 
# Covid19 <- select(Covid,
#                   Country  = location,
#                   Region   = region,
#                   Week     = week,
#                   Positive = total_cases,
#                   Deaths   = total_deaths)

# C. BUILD YOUR SHINY APP ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# C.1 User Interface (ui) ----
ui<-navbarPage("Dashboard",
               tabPanel("Covid19",titlePanel("Cases"), 
                        sidebarLayout(
                          sidebarPanel(DT::dataTableOutput("table1"),
                                       downloadButton("downloadData",
                                                      "Download Data Here",
                                                      href = "")),
                          mainPanel(tableOutput("table1`")))),
               
               tabPanel("Visualization",
                        plotlyOutput("plot")),
               
               tabPanel("Help", 
                        titlePanel("Please contact:"), 
                        helpText("Nicholas Andrian ~ Student of 
                                Department of Business Statistics, 
                                Matana University at nangkyubm@gmail.com"),
                        sidebarLayout(
                          sidebarPanel(
                            downloadButton("downloadCode", 
                                           "Download Code Here", 
                                           href = "")),
                          mainPanel(tableOutput("table"))))
)

# C.2 Server ----

server<-function(input, output, session) {
  
  output$table1 <- DT::renderDataTable({DT::datatable(Covid19)})
  
  output$plot <- renderPlotly(
    {ggplotly(ggplot(Covid19, aes(Positive, Deaths, color = Region)) +
                geom_point(aes(size = Positive, frame = Week, ids = Country)) +
                scale_x_log10())%>% 
        animation_opts(1000,easing="elastic",redraw=FALSE)})
  
}

shinyApp(ui, server)      # This is execute your apps
