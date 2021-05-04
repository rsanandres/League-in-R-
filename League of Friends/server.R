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
  
  stat_dat <- reactive({
    input$stat
  })
  
  stat_game <- reactive({
    input$game
  })
  output$raph_score_text <- renderText({
    lower <- (as.numeric(stat_game())-1)* 10 + 1
    upper <- lower + 9
    temp <- model_df[lower:upper,]
    for (i in lower:upper){
      name <- model_df[i,]$summonerName
      raph_score <- model_df[i,]$raph_score
      paste(name, "has a Raph Score of", raph_score, "\n")
    }
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
  output$Hist_Raph <- renderPlot({
    lower <- (as.numeric(stat_game())-1)* 10 + 1
    upper <- lower + 9
    ggplot(model_df[lower:upper, ], aes_string(x = 'summonerName', y = 'raph_score',fill='summonerName')) +
      geom_bar(stat = "identity") + scale_y_discrete() + 
      geom_text(aes(label = paste("Raph Score:",round(raph_score, digits = 2))), vjust = -1) +
      scale_x_discrete(limits = model_df[lower:upper, ]$summonerName)
  
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
