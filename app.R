library(shiny)
library(ggplot2)
library(lubridate)

banting <- read.csv("API_Banting.csv")

ui <- fluidPage(
  titlePanel("Banting Air Pollutant Index 2013-2015"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Select Year", value = 2014, min = 2013, max = 2015, sep = ""),
      sliderInput("month", "Select Month", value = 1, min = 1, max = 12)
    ),
    mainPanel(h3("API Air Pollutant Index for Banting"), plotOutput("plot1"))
  )
)
server <- function(input, output) {
  
  output$plot1 <- renderPlot({
    
    select_data <- banting[month(banting$Date)==input$month & year(banting$Date)==input$year,]
    ggplot(data=select_data, aes(x = select_data$Hour, y = select_data$API))+geom_smooth(color='red')+labs(x="Hour", y="API Reading")
    
  })
}
shinyApp(ui = ui, server = server)
