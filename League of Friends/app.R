#Helper code and Libraries
source("helpers.R")

#Load Data
load("raph_match_history_data.RData")
load("friends_stats.RData")

ui <- fluidPage(
  # App title ----
  titlePanel("League of Friends"),
  (
    mainPanel(
      # Add PLYT Logo
      img(src = 'hahalogo.PNG', height = 200, width = 200)
      )
  ),
  fluidRow(
    column(2,
      radioButtons(
        "friend", h3("Choose your friend!"),
        choices =choices_names, selected = "onion head"
      )
    ),
    column(3,
       selectInput("stat", h5("Choose the statistic"), 
                   choices = choices, selected = 1)),
  ),
  mainPanel(
    textOutput("selected_stat"),
    textOutput("chosen_stat"),
    textOutput("stat_per_game")
  ),
  navbarPage(
    title = 'DataTable Options',
    tabPanel('Display length',     DT::dataTableOutput('ex1'))
  )
)


server <- function(input, output) {
  
  output$selected_stat <- renderText({
    paste("You have selected", input$stat)
  })
  output$chosen_stat <- renderText({
    paste("Currently, ",input$friend, " has ",
          friends_stats[[input$friend]][[input$stat]] ," ", input$stat)
  })
  output$stat_per_game <- renderText({
    paste("Currently, ",input$friend, " has ",
          round(friends_stats[[input$friend]][[input$stat]]/friends_stats[[input$friend]]$totalGames, 3) ,
          " ", input$stat, " per game.")
  })
  output$ex1 <- DT::renderDataTable(
    DT::datatable(friends_stats, options = list(pageLength = 25))
  )
}
shinyApp(ui = ui, server = server)