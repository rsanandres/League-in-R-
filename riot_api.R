setwd("C:/Users/quort/OneDrive/Desktop/League in R")

##Get all of my friends
#id is the important one since it allows me to use it as the encrupted version

#lets do a one time run and do last 200 matches to start, then run an R script everyday.
library(httr)
library(jsonlite)
require(riotR)
library(request)
library(stringr)
library(plyr)

friends_names <- c("onion%20head", "jam%20cham", "Howeyourfelling", "Chatmo", 
                   "Duckyyy", "b0styjusty", "jrjrsbrother", "Aurum%20Potestas")

get_riot_data <- function(name){
  RIOT_API <- "RGAPI-a786d632-40e1-4dc5-812f-1e968c743b42"
  raph <- riotR::get_user_id(name, "NA1", RIOT_API)
  raph_name <- raph$name
  raph_puuid <- raph$puuid
  raph_account_id <- raph$accountId
  raph_id <- raph$id
  start = 0
  count = 100
  base.url <- "https://americas.api.riotgames.com"
  path <- "/lol/match/v5/matches"
  path_raph <- paste0(path,"/by-puuid/",raph_puuid,"/ids?start=", start,"&count=",count)
  raph_matches <- GET(base.url, path = path_raph,
                      add_headers("X-Riot-Token" = RIOT_API))
  raph_matches<- content(raph_matches, as = "parsed")
  raph_matches <- unlist(str_extract_all(raph_matches, "\\d{2,}", simplify = TRUE))
  load("raph_match_history_data.RData")
  #loads the match_history
  for (i in 1:100){
    path_raph <- paste0(path,"/NA1_", raph_matches[i])
    raph_match <- GET(base.url, path = path_raph,
                      add_headers("X-Riot-Token" = RIOT_API))
    raph_match<- content(raph_match, as = "parsed")
    ind_metadata <- paste0(raph_matches[i], "_metadata")
    ind_info <- paste0(raph_matches[i], "_info")
    if(!(is.null(raph_match[2]))){
      match_history[ind_metadata] <- raph_match[1]
      match_history[ind_info] <- raph_match[2]
    }
    
    Sys.sleep(0.5)
  }
  save(match_history, file="raph_match_history_data.RData")
  Sys.sleep(125)
}


get_riot_data("onion%20head")
get_riot_data("jam%20cham")
get_riot_data("Howeyourfelling")
get_riot_data("Chatmo")
get_riot_data("Duckyyy")
get_riot_data("b0styjusty")
get_riot_data("jrjrsbrother")
get_riot_data("Aurum%20Potestas")

# names(match_history[[2]]['participants']$participants[[1]])
# [1] "assists"                        "baronKills"                     "bountyLevel"                    "champExperience"                "champLevel"
# [6] "championId"                     "championName"                   "championTransform"              "consumablesPurchased"           "damageDealtToBuildings"
# [11] "damageDealtToObjectives"        "damageDealtToTurrets"           "damageSelfMitigated"            "deaths"                         "detectorWardsPlaced"
# [16] "doubleKills"                    "dragonKills"                    "firstBloodAssist"               "firstBloodKill"                 "firstTowerAssist"
# [21] "firstTowerKill"                 "gameEndedInEarlySurrender"      "gameEndedInSurrender"           "goldEarned"                     "goldSpent"
# [26] "individualPosition"             "inhibitorKills"                 "inhibitorsLost"                 "item0"                          "item1"
# [31] "item2"                          "item3"                          "item4"                          "item5"                          "item6"
# [36] "itemsPurchased"                 "killingSprees"                  "kills"                          "lane"                           "largestCriticalStrike"
# [41] "largestKillingSpree"            "largestMultiKill"               "longestTimeSpentLiving"         "magicDamageDealt"               "magicDamageDealtToChampions"
# [46] "magicDamageTaken"               "neutralMinionsKilled"           "nexusKills"                     "nexusLost"                      "objectivesStolen"
# [51] "objectivesStolenAssists"        "participantId"                  "pentaKills"                     "perks"                          "physicalDamageDealt"
# [56] "physicalDamageDealtToChampions" "physicalDamageTaken"            "profileIcon"                    "puuid"                          "quadraKills"
# [61] "riotIdName"                     "riotIdTagline"                  "role"                           "sightWardsBoughtInGame"         "spell1Casts"
# [66] "spell2Casts"                    "spell3Casts"                    "spell4Casts"                    "summoner1Casts"                 "summoner1Id"
# [71] "summoner2Casts"                 "summoner2Id"                    "summonerId"                     "summonerLevel"                  "summonerName"
# [76] "teamEarlySurrendered"           "teamId"                         "teamPosition"                   "timeCCingOthers"                "timePlayed"
# [81] "totalDamageDealt"               "totalDamageDealtToChampions"    "totalDamageShieldedOnTeammates" "totalDamageTaken"               "totalHeal"
# [86] "totalHealsOnTeammates"          "totalMinionsKilled"             "totalTimeCCDealt"               "totalTimeSpentDead"             "totalUnitsHealed"
# [91] "tripleKills"                    "trueDamageDealt"                "trueDamageDealtToChampions"     "trueDamageTaken"                "turretKills"
# [96] "turretsLost"                    "unrealKills"                    "visionScore"                    "visionWardsBoughtInGame"        "wardsKilled"
# [101] "wardsPlaced"                    "win"


temp_names <- list()

make_list_name <- function(name, list){
  temp <- name
  temp <- assign(temp, numeric(1))
  list[[name]] <- temp
  return(list)
}

get_player_stats("onion%20head")
get_player_stats("jam%20cham")
get_player_stats("Howeyourfelling")
get_player_stats("Chatmo")
get_player_stats("Duckyyy")
get_player_stats("b0styjusty")
get_player_stats("jrjrsbrother")
get_player_stats("Aurum%20Potestas")


get_player_stats <- function(name){
  #NOTE YOU CANT RUN MORE THAN ONCE SINCE IT WILL COUNT GAMES ALREADY COUNTED UH
    #do not think it will be a problem since I just run this everytime I want to update it.
  setwd("C:/Users/quort/OneDrive/Desktop/League in R")
  RIOT_API <- "RGAPI-814aa0dd-c794-440f-bc99-c85807d43ad9"
  user <- riotR::get_user_id(name, "NA1", RIOT_API)
  user_name<- user$name
  user_puuid <- user$puuid
  load("raph_match_history_data.RData")
  load("friends_stats.RData")
  #loads the match_history
  #goes through all the matches_info
  if(user_name %in% names(friends_stats)){
    temp_names <- list()
    tt <- names(match_history[[2]]['participants']$participants[[1]])
    for (i in 1:length(names(match_history[[2]]['participants']$participants[[1]]))){
      name <- tt[i]
      temp_names <- make_list_name(name, temp_names)
    }
    stats <- as.data.frame(temp_names)
    stats$totalGames <- numeric(1)
    friends_stats[[user_name]] <- stats
  }
  temp <- friends_stats
  for(ind in seq(2,length(match_history), 2)){
    for(i in 1:10){
      #conversion from like info -> game number to just the list of the game number
      puuid <- match_history[[ind]]['participants']$participants[[i]]$puuid
      
      #for right now, the things that arent numerical arent being analyzed correctly but its okay for now
      if(identical(puuid, user_puuid)){
        for(attr in names(match_history[[2]]['participants']$participants[[1]])){
          print(attr)
          if(attr == "perks"){
            next
          }
          if(attr == "win"){
            temp[[user_name]][[attr]] <- match_history[[ind]]['participants']$participants[[i]][[attr]]
            next
          }
          if(!(is.null(match_history[[ind]]['participants']$participants[[i]][[attr]]))){
            if(!(is.character(match_history[[ind]]['participants']$participants[[i]][[attr]]))){
                print("not char")
                temp[[user_name]][[attr]]<- temp[[user_name]][[attr]] + match_history[[ind]]['participants']$participants[[i]][[attr]]
            } else {
              print("char")
              temp[[user_name]][[attr]] <- match_history[[ind]]['participants']$participants[[i]][[attr]]
            }
          }
        }
        temp[[user_name]]$totalGames <- temp[[user_name]]$totalGames + 1
      }
    }
  }
  friends_stats <- temp
  save(friends_stats,file = "friends_stats.RData")
  return(friends_stats)
}


#UPDATES THE CSV BASED ON MATCH HISTORY
update_stats <- function(){
  #I want to put the stats into a dataframe
  setwd("C:/Users/quort/OneDrive/Desktop/League in R")
  load("raph_match_history_data.RData")
  temp <- as.data.frame(match_history[[2]])
  #c(names(match_history[[2]][['participants']][[1]]), names(match_history[[2]]))
  for(ind in seq(4,length(match_history), 2)){
    print(ind)
    if(!(is.null(match_history[[ind]]))){
      if(match_history[[ind]]$gameMode == 'CLASSIC'){
        temp1 <- as.data.frame(match_history[[ind]])
        if (length(temp1) == 1379){
          temp <- rbind(temp, temp1)
        }
      }
    }
  }
  save(temp,file = "game_stats.csv")
}


#gets the data per participant and win
get_model_df <- function(){
  temp <- match_history[[2]]$participants[[1]]
  temp$perks <- NULL
  temp <- as.data.frame(temp)
  temp <- temp[-c(1),]
  for(ind in seq(2,length(match_history), 2)){
    if(!(is.null(match_history[[ind]]))){
      if(match_history[[ind]]$gameMode == 'CLASSIC'){
        for(i in 1:10){
          temp1 <- match_history[[ind]]$participants[[i]]
          temp1$perks <- NULL
          temp1 <- as.data.frame(temp1)
          if(identical(sort(names(temp)), sort(names(temp1)))){
            temp <- rbind(temp, temp1)
          }
          print(nrow(temp))
        }
        
      }
    }
  }
  write.csv(model_df, "model_df.csv")
}

add_raph_score <- function(){
  model_df <- read.csv("model_df.csv")
  
  stats_removed <- c("X.1", "X", "championId", "championName", "championTransform", "gameEndedInEarlySurrender", "gameEndedInSurrender","individualPosition",
                     "item0","item1","item2" ,"item3","item4","item5","item6","itemsPurchased", "lane", "nexusKills","nexusLost", "participantId",
                     "profileIcon",
                     "puuid", "riotIdName","riotIdTagline","role","spell1Casts","spell2Casts","spell3Casts","spell4Casts","summoner1Casts","summoner1Id"
                     ,"summoner2Casts","summoner2Id","summonerId","summonerLevel","summonerName",
                     "teamEarlySurrendered","teamId","teamPosition","timePlayed", "win", "raph_score")
  
  df <- model_df[!colnames(model_df) %in% stats_removed]
  ## this is really inflated for the right side
  weights <- c(1, 1, 1, 1/10000, 
               1/13, 1/8, 1/4000, 1/2000,
               1/4000, 1/20000, -1, 0.2,
               1, 0.2, 1, 1,
               1, 1, 1/15000, 1/10000,
               1, -1, 1, 1,
               1/1000, 1, 1, 1/120,
               1/30000, 1/5000, 1/5000, 1/15,
               1, 1, 3, 1/30000,
               1/5000, 1/5000, 2.5, 1/3,
               1/20, 0, 0, 1/500,
               1/20000, 1/7000, 1/1000, 1/85,
               1/223, -1/60, 1/4, 2, 
               1/30000, 1/5000, 1/5000, 1/2,
               -1/2, 1, 1/20, 1/3, 
               0.45, 1/7)
  
  
  score <- integer(length(rownames(df)))
  df$raph_score <- score
  for(i in 1:length(rownames(df))){
    df[i,] <- weights * df[i,]
    df[i, "raph_score"] <- ((sum(df[i,])/55)+0.15)*5
  }
  model_df$raph_score <- df$raph_score
  model_df['X'] <- NULL
  model_df['X.1'] <- NULL
  write.csv(model_df, "model_df.csv")
  print(colnames(model_df))
  return(model_df)
}

stats_to_df <- function(){
  friends_stats_df <- data.frame()
  for(i in 1:length(friends_stats)){
    temp <- as.data.frame(friends_stats[[i]])
    friends_stats_df <- rbind(friends_stats_df, temp)
  }
  row.names(friends_stats_df) <- friends_names
  friends_stats_df = t(friends_stats_df)
  save(friends_stats_df, file = "friends_stats_df.csv")
}

