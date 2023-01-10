# 1/10/23
# Script for playing w/ cleaned up data/figuring out how I want to viz 
# Will put cleaned up version in .qmd eventually, and publish to website

library(tidyverse)

all_places <- read_csv('/Users/caroline.buck/Desktop/Fun_R/recap_2022/all_places_2022.csv')

# a little more data cleaning is needed...oops. ----
all_places %>%
  mutate(date_visit = lubridate::as_date(startTimestamp)) %>% # date got messed up in excel
  # add city for grouping purposes in viz (maybe better way to do this w/ lat/lng?? separating would be messy b/c address not standard format)
  # this could be option, but would also require accuracy verification https://stackoverflow.com/questions/48455079/extract-city-names-from-large-text-with-r
  # omg- now that I'm almost done I also realized I could've split stuff in Excel then manually cleaned up the outliers pretty easily *facepalm*
  # TBD: might aggregate to broader city regions if have too many cities...clusters might get weird/too many?
  mutate(city = case_when(
    str_detect(address,'Seattle') ~ 'Seattle',
    str_detect(address,'Cambridge') ~ 'Cambridge',
    str_detect(address,'Boston') ~ 'Boston',
    str_detect(address,'Madrid') ~ 'Madrid',
    str_detect(address,'San Diego') ~ 'San Diego',
    str_detect(address,'Barcelona') ~ 'Barcelona',
    str_detect(address,'Somerset') ~ 'Somerset',
    str_detect(address,'Escondido') ~ 'Escondido',
    str_detect(address,'Vancouver') ~ 'Vancouver',
    str_detect(address,'Mercer Island') ~ 'Mercer Island',
    str_detect(address,'Bellingham') ~ 'Bellingham',
    str_detect(address,'Cle Elum') ~ 'Cle Elum',
    str_detect(address,'Surrey') ~ 'Surrey',
    str_detect(address,'Somerville') ~ 'Somerville',
    str_detect(address,'Newport') ~ 'Newport',
    str_detect(address,'Middletown') ~ 'Middletown',
    str_detect(address,'Poway') ~ 'Poway',
    str_detect(address,'La Jolla') ~ 'La Jolla',
    str_detect(address,'Watertown') ~ 'Watertown',
    str_detect(address,'Brookline') ~ 'Brookline',
    str_detect(address,'Jamaica Plain') ~ 'Jamaica Plain',
    str_detect(address,'Chestnut Hill') ~ 'Chestnut Hill',
    str_detect(address,'West Roxbury') ~ 'West Roxbury',
    str_detect(address,'Quincy') ~ 'Quincy',
    str_detect(address,'Portland') ~ 'Portland',
    str_detect(address,'Natick') ~ 'Natick',
    str_detect(address,'Auburn') ~ 'Auburn',
    str_detect(address,'Woodland') ~ 'Woodland',
    str_detect(address,'Issaquah') ~ 'Issaquah',
    str_detect(address,'Snoqualmie') ~ 'Snoqualmie',
    str_detect(address,'Preston') ~ 'Preston',
    str_detect(address,'Framingham') ~ 'Framingham',
    str_detect(address,'Upton') ~ 'Upton',
    str_detect(address,'Newton') ~ 'Newton',
    str_detect(address,'Redmond') ~ 'Redmond',
    str_detect(address,'Shoreline') ~ 'Shoreline',
    str_detect(address,'Algona') ~ 'Algona',
    str_detect(address,'Puyallup') ~ 'Puyallup',
    str_detect(address,'Tacoma') ~ 'Tacoma',
    str_detect(address, 'Roy') ~ 'Roy',
    str_detect(address,'Kelso') ~ 'Kelso',
    str_detect(address,'Winlock') ~ 'Winlock',
    str_detect(address,'Rainier') ~ 'Rainier',
    str_detect(address,'St Helens') ~ 'St Helens',
    str_detect(address,'Centralia') ~ 'Centralia',
    str_detect(address,'Adams') ~ 'Adams',
    str_detect(address,'Arlington') ~'Arlington',
    str_detect(address,'Oxon Hill') ~'Oxon Hill',
    str_detect(address,'Forest Heights') ~ 'Oxon Hill',
    str_detect(address,'Roissy') ~ 'Roissy-en-France',
    str_detect(address,'Girona') ~ 'Girona',
    str_detect(address,'Allston') ~ 'Allston',
    str_detect(address,'Las Vegas') ~ 'Las Vegas',
    str_detect(address,'Salem') ~ 'Salem',
    str_detect(address,'Westport') ~ 'Westport',
    str_detect(address,'Allston') ~ 'Allston',
    str_detect(address,'Bellevue') ~ 'Bellevue',
    str_detect(address,'Medford') ~ 'Medford',
    str_detect(address,'National Harbor') ~ 'Oxon Hill',
    str_detect(address,'Lynnwood') ~ 'Lynnwood',
    str_detect(address,'Woodinville') ~ 'Woodinville',
    str_detect(address,'SeaTac') ~ 'SeaTac',
    str_detect(address,'Kirkland') ~ 'Kirkland',
    str_detect(address,'North Bend') ~ 'North Bend',
    str_detect(address,'Edmonds') ~ 'Edmonds',
    str_detect(address,'Mountlake Terrace') ~ 'Mountlake Terrace',
    str_detect(address,'Brighton') ~ 'Brighton',
    str_detect(address,'Concord') ~ 'Concord',
    str_detect(address,'Milford') ~ 'Milford',
    str_detect(address,'Lincoln') ~ 'Lincoln',
    str_detect(address,'Worcester') ~ 'Worcester',
    str_detect(address,'Pittsfield') ~ 'Pittsfield',
    str_detect(address,'Charlemont') ~ 'Charlemont',
    str_detect(address,'New Bedford') ~ 'New Bedford',
    str_detect(address,', Bedford') ~ 'Bedford',
    str_detect(address,'Schiphol') ~ 'Schiphol',
    str_detect(address,'Nevada 89005, USA') ~ 'Boulder City',
    TRUE ~ 'tbd'
  )) %>% 
  # For coloring purposes (too many cities)
  mutate(state = case_when(
    str_detect(address,' MA') ~ 'Massachusetts',
    str_detect(address,'Massachusetts') ~ 'Massachusetts',
    str_detect(address,' CA ') ~ 'California',
    str_detect(address,' WA ') ~ 'Washington',
    str_detect(address,'Washington 9') ~ 'Washington',
    str_detect(address,' OR ') ~ 'Oregon',
    str_detect(address,' RI ') ~ 'Rhode Island',
    str_detect(address,' MD ') ~ 'Maryland',
    str_detect(address,' VA ') ~ 'Virginia',
    str_detect(address,' NV ') ~ 'Nevada',
    str_detect(address,'Nevada') ~ 'Nevada',
    str_detect(address,'Canada') ~ 'Canada',
    TRUE ~ 'Europe'
  )) -> all_places_clean 
  #filter(state == 'International') %>% select(address) %>% distinct() -> tst
  #filter(city == 'tbd') %>% select(address) %>% distinct() 
  #glimpse()


# Prelim vizzes ----
all_places_clean %>%
  count(city) # 74 different cities...might need to aggregate. Or color by state/international
all_places_clean %>%
  #filter(state == 'Massachusetts') %>%
  ggplot() +
  geom_point(aes(x=longitudeE7,y=latitudeE7,color=state)) +
  #geom_point(aes(x=scales::rescale(longitudeE7,to=c(0,1.5)),y=scales::rescale(latitudeE7,to=c(0,.5)),color=state)) +
  theme_minimal()
# this seems good enough for now, may need to jitter some points if can't zoom in enough to see. 
# or maybe rescale both lng/lat? --> eh. looks about the same when rescaling

# D3 vizzes ----
# this might be a little harder than I expected. need to actually write .js/D3 code (can't pass it stuff exactly like ggplot or something)
# https://rstudio.github.io/r2d3/
# for the custom animations and such...it might be easier to do this in pure d3 and not worry about R connection. 
install.packages("devtools")
devtools::install_github("rstudio/r2d3")

library(r2d3)
r2d3(data=c(1.3, 0.6, 0.8, 0.95, 0.40, 0.20), script = "test_example.js")

# or easier way out (to get this out the door faster) would be to just use gganimate, looks like I can do lots of what I want
# https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/
# TODO: come back and practice d3 to convert chart

# ggplot2 animated viz ----
library(gganimate) 
# TODO: install gifski or av for gif or video output from gganimate!
all_places_clean %>%
  filter(state == 'Massachusetts') %>%
  ggplot(aes(x=longitudeE7,y=latitudeE7)) +
  #geom_point(aes(color=state)) +
  theme_minimal() +
  geom_line(color='black') +
  #geom_point(aes(group = seq_along(date_visit),color=state)) +
  transition_time(startTimestamp)

all_places_clean %>%
  group_by(address) %>%
  mutate(num_visits = n()) %>%
  filter(state == 'Massachusetts') %>%
  ggplot(aes(x=longitudeE7,y=latitudeE7)) +
  geom_path(data = all_places_clean %>% filter(state == 'Massachusetts') %>%
              arrange(startTimestamp),
            aes(x=longitudeE7,y=latitudeE7),color='gray') +
  geom_point(aes(fill=state,size=num_visits+5),color='black',shape=21) +
  theme_minimal()

# static, but with plotly
all_places_clean %>%
  group_by(address) %>%
  mutate(num_visits = n()) %>%
  rename(Place=name) %>%
  #filter(state == 'Massachusetts') %>%
  select(-startTimestamp) %>%
  ggplot(aes(x=longitudeE7,y=latitudeE7,label=Place)) +
  geom_path(data = all_places_clean %>% #filter(state == 'Massachusetts') %>%
              rename(Place=name) %>%
              arrange(startTimestamp),
            aes(x=longitudeE7,y=latitudeE7),color='gray') +
  geom_point(aes(fill=state,size=num_visits),color='black',shape=21) +
  theme_minimal() -> p
plotly::ggplotly(p,tooltip = c("label")) %>% plotly::config(scrollZoom=TRUE)

all_places_clean %>%
  group_by(address) %>%
  mutate(num_visits = n()) %>%
  filter(state == 'Massachusetts') %>%
  ggplot(aes(x=longitudeE7,y=latitudeE7)) +
  geom_point(aes(fill=state,size=num_visits+5),color='black',shape=21) +
  theme_minimal() -> p
p + geom_path(data = all_places_clean %>% filter(state == 'Massachusetts') %>%
              arrange(startTimestamp),
            aes(x=longitudeE7,y=latitudeE7,group=startTimestamp),color='gray') +
  transition_time(startTimestamp)
  

