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