
library(readr);library(ggplot2);library(choroplethr)
library(dplyr)
# favor decimal over scientific notation
options("scipen"=100, "digits"=4)

# load our functions
source("0-functions.R")

players <- read_csv("./data/player.csv")
batting <- read_csv("./data/batting.csv")
pitching <- read_csv("./data/pitching.csv")
teams <- read_csv("./data/team.csv")
salary <- read_csv("./data/salary.csv")
names(salary) <- c("year","team_id","league_id","player_id","salary_amount")

# fix some data
batting$sf <- as.integer(batting$sf)

# add salary to batting and pitching information
batting <- dplyr::inner_join(batting,salary,by=c("player_id","team_id","league_id","year"))
pitching <- dplyr::inner_join(pitching,salary,by=c("player_id","team_id","league_id","year"))
batting$ba <- ba(batting$h,batting$ab)
batting$obp <- obp(batting$h,batting$bb,batting$hbp,batting$ab,batting$sf)
batting$sp <- sp(batting$h,batting$double,batting$triple,batting$hr,batting$ab)

# get rid of the pitchers in batting data
batting <- dplyr::anti_join(batting,pitching,by="player_id")

# calculate salary for each team, and then get salary data for pitchers and batters
team_salary <- salary %>% dplyr::group_by(year,team_id) %>% 
    dplyr::summarise(salary_amount = sum(salary_amount))
team_pitching_salary <- pitching %>% dplyr::group_by(year,team_id) %>%
  dplyr::summarise(pitching_salary = sum(salary_amount))
team_batting_salary <- batting %>% dplyr::group_by(year,team_id) %>%
  dplyr::summarise(batting_salary = sum(salary_amount))

teams <- dplyr::inner_join(teams,team_salary)
teams <- dplyr::inner_join(teams,team_pitching_salary)
teams <- dplyr::inner_join(teams,team_batting_salary)

# get the z score for the teams salary by year
# dat$z <- ave(dat$y, dat$group, FUN=scale)
teams$zscore <- ave(teams$salary_amount,teams$year,FUN = scale)
