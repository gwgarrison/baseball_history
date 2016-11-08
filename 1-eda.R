# setup our data
source("0-setup.R")

# get number of players by country
player_country <- data.frame(table(players$birth_country))
names(player_country) <- c("region","value")
player_country$region <- tolower(player_country$region)
player_country$region[1 == "can"] <- "canada"
player_country$region[player_country$region == 'can'] <- 'canada'
player_country$region[player_country$region == 'usa'] <- 'united states of america'
suppressWarnings(country_choropleth(player_country,"Players by Country of Origin"))


# salary graphs
ggplot(data = salary,aes(x = salary_amount)) + geom_histogram()

teams.recent <- filter(teams,year >= 2011)
ggplot(data = teams.recent,aes(x = salary_amount,y = w/g)) + 
  geom_point(aes(color = div_win))
ggplot(data = teams.recent,aes(x = salary_amount,y = w/g)) + 
  geom_point(aes(color = lg_win))
ggplot(data = teams,aes(x = zscore,y = w/g)) + 
  geom_point(aes(color = ws_win))
       
       