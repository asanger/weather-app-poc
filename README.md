# Weather App

These notes follow my thought process while working on this app.

## Prioritizing the Features

I'm putting on my "customer" hat right now and thinking about what I would want as a user of the app rather than what would be the easiest to build.

By far the most important features for me as a user would be getting the current location's weather, along with a forecast of some sort. "Current location" implies that they want this to be know where the user is without them needing to specify where they are You can get a user's location without the use of the GPS, but it's not nearly as accurate. I personally like to have the more accurate GPS positioning, but with the ability to disable it if needed (so it doesn't drain my battery).

I'm a huge fan of storms, and I really like to see where I am in relation to a storm rolling in, so the current radar is another feature that I'd like. It's also very visual and has the potential to really "wow" the client without too much effort.

It's frustrating when you're in an app and you can't figure out how to refresh the data, so Pull to Refresh would be the last important feature that I'd like to implement. 

User auth might be nice for integration between a web version and a mobile app, but it would require a service to handle authentication and storing preferences/settings to be used globally. I don't think that the effort involved would be worth doing for a Proof of Concept, especially since it's almost all behind-the-scenes functionality.

Based on the above, here is ordered priority list:
- Current Location Weather
- GPS Location
- Monthly, Weekly, Daily, Hourly Weather Info
- Map (weather/radar)
- Pull to Refresh

Icons & Menu Icons
Methods for Multiple UI Themes
Seasonal Conditions (Golf, Sailing, Skiing)
Wearable App
User can display multiple locations
User Auth
Graph (Precipitation, Humidity, Temp, etc.)


## Choosing the Technology

My initial thought was to just do this in either VueJS or React, but it sounds like the client is looking for an actual app. I think having it on a real device would be more impactful than showing it to them in the browser. It *will* be more difficult to share the app with them, though, whereas with a website I could just send a link.

In the end, I decided to go with a native iOS app. I'll be doing it in Objective-C rather than swift simply because that's what I'm more comfortable with.

