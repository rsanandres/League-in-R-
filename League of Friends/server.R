source("helpers.R")

server <- function(input, output) {
  p1_dat <- reactive({
    input$p1
  })
  p2_dat <- reactive({
    input$p2
  })
  stat_comp_dat <- reactive({
    input$stat_comp
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
  output$Hist_Full <- renderPlot({
    ggplot(fs_df, aes_string(x = 'friends_names', y = stat_comp_dat(),fill='friends_names')) +
      geom_bar(stat = "identity") + scale_y_discrete()
    
  })
  
  observeEvent(input$rows,{
    rows <- as.numeric(input$rows)
    if(length(input$rows) == 1){
      df <- data.frame(friends_stats_df[rows,])
      df <- t(df)
      rownames(df) <- rownames(friends_stats_df)[rows]
      output$mytable = renderDataTable(df)
      
    } else if(length(input$rows) == 0){
      df <- data.frame(friends_stats_df)
      names(df) <- friends_names
      output$mytable = renderDataTable(df)
      
    }else{
      output$mytable = renderDataTable(friends_stats_df[rows,])
      
    }
  }, ignoreNULL = FALSE)
}
