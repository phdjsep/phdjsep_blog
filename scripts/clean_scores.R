library(tidyverse)
library(jsonlite)

# Need to prep text output from selenium to be in JSON format before running here
# This assumes three rounds

raw <- read_json("rdata/footgolf/nationals/nationals_scores_men.json", simplifyVector = T)
raw_unnested <- raw %>% unnest() %>% select(name, round1, round2, round3)

scores_rd1 <- select(raw_unnested, name, round1)
scores_rd2 <- select(raw_unnested, name, round2)
scores_rd3 <- select(raw_unnested, name, round3)

scores_rd1 <- add_column(scores_rd1, round = rep(1, 1260), .before = 'round1')
scores_rd2 <- add_column(scores_rd2, round = rep(2, 1260), .before = 'round2')
scores_rd3 <- add_column(scores_rd3, round = rep(3, 1260), .before = 'round3')

scores_rd1 <- add_column(scores_rd1, hole = rep(1:18, 70), .before = 'round1')
scores_rd2 <- add_column(scores_rd2, hole = rep(1:18, 70), .before = 'round2')
scores_rd3 <- add_column(scores_rd3, hole = rep(1:18, 70), .before = 'round3')

names(scores_rd1) <- c("player", "round", "hole", "strokes")
names(scores_rd2) <- c("player", "round", "hole", "strokes")
names(scores_rd3) <- c("player", "round", "hole", "strokes")

pars <- c(5, 4, 3, 4, 4, 4, 3, 4, 5, 4, 4, 3, 4, 5, 4, 4, 5, 3)
yds <- c(269, 220, 124, 202, 173, 192, 134, 219, 258, 174, 153, 75, 195, 301, 209, 181, 260, 71)

scores_rd1 <- add_column(scores_rd1, par = rep(pars, 70))
scores_rd2 <- add_column(scores_rd2, par = rep(pars, 70))
scores_rd3 <- add_column(scores_rd3, par = rep(pars, 70))
# scores_rd1 <- add_column(scores_rd1, yds = rep(yds, 71))
# scores_rd2 <- add_column(scores_rd2, yds = rep(yds, 71))
# scores_rd3 <- add_column(scores_rd3, yds = rep(yds, 71))

nationals_scores <- rbind(scores_rd1, scores_rd2, scores_rd3)
nationals_scores <- mutate(nationals_scores, score = strokes - par)

nationals_scores$round <- as.integer(nationals_scores$round)
nationals_scores$par <- as.integer(nationals_scores$par)
nationals_scores$score <- as.integer(nationals_scores$score)


# US Open times join to scores above
# uso_times <- read_csv("usopen/usopen_scores.csv")
# usopen_scores <- left_join(usopen_scores, uso_times, by = c("player", "round", "hole", "strokes", "par", "score"))