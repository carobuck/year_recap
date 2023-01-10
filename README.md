The following is a bunch of rough notes...which will eventually be cleaned up once I finish the viz/write up the post. 

LOTS of data can be exported from Google, if you've got your location data turned on.

So much that it's kinda overwhelming. So I'm taking a creative approach to this project to show where I've gone in 2022. To tell a story that gives a glimpse at the stories I lived/told in 2022.

ideas/notes:

* because google tracks everything (in lots of detail) when I walk around, we'll do some distance things to show moving around. then if big enough distance between, it'll put me in a diff city (i'll take city labels)
* could be interesting to show city in final?
* add some callouts/popups for some special stories/mems/highlights as the animation plays hopping around
* maybe do some random/small/static vizzes w/ other data google gives at the bottom? like the probability of way of transportation? (fun facts + highlight some other data that is avail)
* do any callouts on privacy/data lit for this? why it's cool but also need to be careful/aware of what's being used and consciously accept this??
* should I include just start + end points? or whole waypoint path?? or maybe de-aggregate the paths into just a long list of locations and go from there??? then can make sorta de-agg/more creative viz that doesn't rely on order of visits as precisely (and then I don't have to manually verify if I actually went to a place or just walked by...)

TODO: figure out how to convert this to DF and extract all places
ooh there's actually different lists! there are 'activity segments' and place visits. maybe I just take the place visits. make this easier! then it would rely on google's models to determine if I "visited" or just walked by

publish some fake data that this works with, so other ppl can try it (so I don't have to put my own data live)

Have to choose A LOT of data to ignore...otherwise this gets much more complicated, much faster. Ignoring so far: waypoint paths, child location visits, other candidate locations (I'm assuming that Google's first location guess is accurate, so I don't have to manually verify all the places), confidence scores for locations/places

might have to dedupe some places? if I visited the same place more than once in a day? (else need to use date + time for animation line)

NOTE: I manually filled in some place names (because google wouldn't know what they are if not named in Google maps)

make some callouts about how these place names aren't perfect and google thinks I went some places I don't think I went (like The Import Doctors Foreign Auto Specialists). but maybe I wandered around out front for a while on the phone?? 
OR it flagged the place next door...I was actually in PCC not Import Doctors. LOLOL Imperfect data!

thought - what timezone does google export data in?? I don't think it matters too much for this project, but I'm curious... 

tie in my words for 2022 (telling a good story, that's my motto now) and how it was sorta inspiration for this project. maybe next year the recap will be my fitbit/sleep data (because my 2023 resolution is to actually rest/sleep better)

why did I visit this place 4 times/days in spring 2022?? 8221 Corliss Ave N, Seattle, WA 98103, USA for like 12 ish mins each time??? walks?? no idea
also this one, one street over 8234 Bagley Ave N, Seattle, WA 98103, USA also 4 times. 
both houses on my standard walking route that I'd do everyday...so maybe I was really into the walk ?? no idea. I did walk up and down bagley and corliss a lot. 


also interesting...there are a few places I remember going to, but don't remember labeling...so no idea if they are included or flagged as something else (e.g. that random house party I went to in JP one night)

for difference between centerLatE7 and latitudeE7...I didn't find anything online. but my hypothesis is that because centerLatE7 varies for the same location while latitudeE7 is the same for same location, the centerLatE7 was my more specific location within that place, while latitudeE7 is the more generalized latitude for that place. For ease of viz, I'm going to use latitudeE7 and longitudeE7.
(also note that convert E7 lat/lng coordinates, divide the integer by 1e7. [source here](https://www.chipoglesby.com/2018/03/2018-analyzing-google-location-historyII/))

FYI: longitude values (run vertically, but measure east/west) are considered the x-coordinate, while latitude values (run horizontally, but measure north/south) are the y-coordinate.

d3 resources:

* r package https://rstudio.github.io/r2d3/
* d3 gallery on observable: https://observablehq.com/@d3/gallery
* connected scatterplot: https://observablehq.com/@d3/connected-scatterplot
* zooming https://observablehq.com/@d3/scatterplot-tour and https://observablehq.com/@d3/smooth-zooming 

"in the interest of not letting perfect hold up the good...I present you with:"