source("helpers.R")

header <- dashboardHeader(
  title = "League of Friends",
  dropdownMenu(type = "messages",
               messageItem(
                 from = "Raph",
                 message = "Thanks for visiting the website!",
                 icon = icon("glyphicon glyphicon-heart", lib = "glyphicon")
               ),
               messageItem(
                 from = "System Updates",
                 message = "When was the last time I was updated?",
                 time = "April 30",
                 icon = icon("glyphicon glyphicon-user", lib = "glyphicon")
               )
  )
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Table Form", tabName = "Table", icon = icon("glyphicon glyphicon-th", lib = "glyphicon")),
    menuItem("Per Person", tabName = "pp",icon = icon("glyphicon glyphicon-user", lib = "glyphicon")),
    menuItem("Comparison", tabName = "Comparison",icon = icon("glyphicon glyphicon-eye-open", lib = "glyphicon"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Table",
            h2("Data Table for All Friends Stats"),
            fluidPage(
              basicPage(
                h2('Friend\'s Stats Data'),
                checkboxGroupInput("rows","Select Stat to Look at!",choices=vchoices,inline = T),
                
                tabPanel('Display length',DT::dataTableOutput('mytable'))
              )
            )
    ),
    
    tabItem(tabName = "pp",
            h2("Per Person"),
            fluidRow(
              column(2,
                     radioButtons(
                       "friend", h3("Choose your friend!"),
                       choices =choices_names, selected = "onion head"
                     )
              ),
              column(3,
                     selectInput("stat", h5("Choose the statistic"), 
                                 choices = choices, selected = 1))
            ),
            mainPanel(
              textOutput("selected_stat"),
              textOutput("chosen_stat"),
              textOutput("stat_per_game")
            )
    ),
    tabItem(tabName = "Comparison",
            h2("Comparison"),
            fluidPage(
              selectInput("p1","Name 1",choices = friends_names, selected = "onion head"),
              selectInput("p2",'Name 2',choices = friends_names, selected = "jam cham"),
              selectInput("stat_comp", h5("Choose the statistic"),choices = choices, selected = 1),
              plotOutput("Hist_Full")
            )
    )
  )
)


dashboardPage(header, sidebar, body, skin = "purple-light" )
