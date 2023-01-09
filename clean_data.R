# 1/9/23

# Explore data exported from google

library(tidyverse)

# Not sure what this is (something about deleting data??)
tombstones <- read_csv('/Users/caroline.buck/Desktop/Fun_R/recap_2022/Takeout/Location History/Tombstones.csv')

#install.packages("rjson")
library("rjson")


# Load one file and clean up
# note that file= is needed to make this work
april <- fromJSON(file='/Users/caroline.buck/Desktop/Fun_R/recap_2022/Takeout/Location History/Semantic Location History/2022/2022_APRIL.json')

# convert list to df, then unnest, filter, unnest + filter some more
# FYI unnesting df columns: https://stackoverflow.com/questions/38860380/unnesting-a-list-of-lists-in-a-data-frame-column
test <- as.data.frame(do.call(cbind, april))
test %>%
  mutate(label = map(timelineObjects, names)) %>%
  unnest(c(timelineObjects, label)) -> test2 
  unnest(timelineObjects) 

test <- as.data.frame(do.call(rbind, april))

test <- data.frame(april)



library(rlist)
#install.packages("rlist")
april %>%
  list.select(placeVisit) %>%
  str
people %>>%
  list.sort(Age) %>>%
  list.select(Name, Age) %>>%
  str