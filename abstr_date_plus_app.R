rm(list = ls())
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  headerPanel(h1("COTA: Date Calculator")),
  
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
      
      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        font-size: 5;
        line-height: 3.1;
        # color: #7c61ed;
        color: #afafd4;
      }

    "))
  ),
    
   theme = shinytheme("slate"),
    

  mainPanel(flowLayout(
    dateInput('date_entered', 'Enter your start date', value = Sys.Date(), startview = "decade"),
    # sliderInput('length_entered', 'How many days forward?', 0, 1000, 20),
    numericInput('length_entered', 'How many days forward?', 10),
    actionButton("go", "Calculate"),
    verbatimTextOutput("calculated_date"),
    
    tags$style(type='text/css', "#calculated_date { width:60%; vertical-align:bottom; margin-top: 26px;}"),
    tags$style(type='text/css', "#go { width:60%; vertical-align:bottom; margin-top: 26px;}")))
  
  
)

# Define server logic 
server <- function(input, output) {
  
  temp <- reactive({
    if(input$go == 0){return()}
    
    
    
    isolate({
      temp2 <- as.character(input$date_entered + input$length_entered)
    })
    temp2
  })
  
  output$calculated_date <- renderText({temp()})
  
  
  output$heading <- renderText({
    as.character("COTA - Date Calculator")
  })
  
  src = "https://media.licdn.com/mpr/mpr/shrink_200_200/AAEAAQAAAAAAAAc1AAAAJGZhYWU2OGJhLWJkYzAtNDgxNC1iMGQ1LWRkYmQ0ZmU2ZjYzNg.png"
  output$logo <- renderText({c('<img src="',src,'">')})
    
}

# Run the application 
shinyApp(ui = ui, server = server)
