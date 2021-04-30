#Libraries
library(shiny)
library(DT)
library(shinydashboard)
library(shinydashboardPlus)
library(ggplot2)

load("raph_match_history_data.RData")
load("friends_stats.RData")
load("friends_stats_df.csv")

fs_df <- as.data.frame(t(friends_stats_df))
#Code

vchoices <- 1:nrow(friends_stats_df)
names(vchoices) <- row.names(friends_stats_df)

a1 <- names(match_history[[2]]['participants']$participants[[1]])
a2 <- 1:102
choices = setNames(a1,a1)

names <- c("Raph", "Joy", "Howie", "Matthew",
           "Caleb", "Justin (busty)", "Justin (jrjrs)", "Nathaniel")
friends_names <- c("onion head", "jam cham", "Howeyourfelling", "Chatmo", 
                   "Duckyyy", "b0styjusty", "jrjrsbrother", "Aurum Potestas")
choices_names = setNames(friends_names, names)
