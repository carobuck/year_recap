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
# NOTE: use just placeVisit data for now; maybe come back to do something interesting w/ activitySegments (way of transport?)
# FYI unnesting df columns: https://stackoverflow.com/questions/38860380/unnesting-a-list-of-lists-in-a-data-frame-column
test <- as.data.frame(do.call(cbind, april))
test %>%
  mutate(label = map(timelineObjects, names)) %>%
  unnest(c(timelineObjects, label)) %>%
  filter(label == 'placeVisit') %>%
  mutate(id = row_number(), # to keep track of items that go together
         label2 = map(timelineObjects, names)) %>%
  unnest(c(timelineObjects, label2)) %>%
  pivot_wider(names_from = label2,values_from = timelineObjects) %>%
  select(label:locationConfidence,-otherCandidateLocations,-editConfirmationStatus) %>%
  rename(locationConfidence_orig = locationConfidence) %>%
  # unnest location + duration 
  mutate(label3 = map(location, names),
         label4 = map(duration,names)) %>%
  unnest(c(location, label3)) %>%
  pivot_wider(names_from = label3,values_from = location) %>%
  unnest(c(duration,label4)) %>%
  pivot_wider(names_from = label4,values_from = duration) %>%
  # select just cols of interest for initial viz (maybe come back for more later?)
  select(address,name,centerLatE7,centerLngE7,latitudeE7,longitudeE7,startTimestamp,endTimestamp) %>%
  # convert to proper data types
  mutate(address = as.character(address),
         name = as.character(name),
         centerLatE7 = as.integer(centerLatE7),
         centerLngE7 = as.integer(centerLngE7),
         latitudeE7 = as.integer(latitudeE7),
         longitudeE7 = as.integer(longitudeE7),
         startTimestamp = lubridate::as_datetime(as.character(startTimestamp)),
         # for ease
         date_visit = lubridate::as_date(startTimestamp),
         endTimestamp = lubridate::as_datetime(as.character(endTimestamp))) -> test2

## now that the above is working for one, convert to function to read all months
files <- list.files(path='/Users/caroline.buck/Desktop/Fun_R/recap_2022/Takeout/Location History/Semantic Location History/2022',
                    pattern='.json', all.files=TRUE,full.names=TRUE)

all_places_2022 <- data.frame()
for (i in files){
  month_data <- NULL
  month_data <- fromJSON(file=i)
  test <- as.data.frame(do.call(cbind, month_data))
  test %>%
    mutate(label = map(timelineObjects, names)) %>%
    unnest(c(timelineObjects, label)) %>%
    filter(label == 'placeVisit') %>%
    mutate(id = row_number(), # to keep track of items that go together
           label2 = map(timelineObjects, names)) %>%
    unnest(c(timelineObjects, label2)) %>%
    pivot_wider(names_from = label2,values_from = timelineObjects) %>%
    select(label:locationConfidence,-otherCandidateLocations,-editConfirmationStatus) %>%
    rename(locationConfidence_orig = locationConfidence) %>%
    # unnest location + duration 
    mutate(label3 = map(location, names),
           label4 = map(duration,names)) %>%
    unnest(c(location, label3)) %>%
    pivot_wider(names_from = label3,values_from = location) %>%
    unnest(c(duration,label4)) %>%
    pivot_wider(names_from = label4,values_from = duration) %>%
    # select just cols of interest for initial viz (maybe come back for more later?)
    select(address,name,centerLatE7,centerLngE7,latitudeE7,longitudeE7,startTimestamp,endTimestamp) %>%
    # convert to proper data types
    mutate(address = as.character(address),
           name = as.character(name),
           centerLatE7 = as.integer(centerLatE7),
           centerLngE7 = as.integer(centerLngE7),
           latitudeE7 = as.integer(latitudeE7),
           longitudeE7 = as.integer(longitudeE7),
           startTimestamp = lubridate::as_datetime(as.character(startTimestamp)),
           # for ease
           date_visit = lubridate::as_date(startTimestamp),
           endTimestamp = lubridate::as_datetime(as.character(endTimestamp))) -> temp
  
  all_places_2022 <- rbind(all_places_2022,temp)
}

# Save as CSV and manually add some place names
write_csv(all_places_2022,'all_places_2022.csv')
test <- read_csv('/Users/caroline.buck/Desktop/Fun_R/recap_2022/all_places_2022.csv')
