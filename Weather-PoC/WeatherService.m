//
//  WeatherService.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "WeatherService.h"

@implementation WeatherService

- (void)fetchLocation
{
    Location *location = [[Location alloc] init];

//  We're generating fake data until we hook up to the API
    location.city = @"Clarkston";
    location.state = @"MI";
    location.zip = @"48348";
    
    if ([self.delegate respondsToSelector:@selector(didFetchLocation:)]) {
        [self.delegate didFetchLocation:location];
    }
}

- (void)fetchCondition:(Location *)location
{
    WeatherCondition *condition = [[WeatherCondition alloc] init];
    
    condition.temperature = @"48";
    condition.weatherDescription = @"Kinda cold";
    condition.relativeHumidity = @"59%";
    
    if ([self.delegate respondsToSelector:@selector(didFetchCondition:)]) {
        [self.delegate didFetchCondition:condition];
    }
}


- (void)fetchForecast:(Location *)location
{
    NSMutableArray *forecastDays = [NSMutableArray array];
    
    NSURL *forecastUrl = [NSURL URLWithString:@"https://api.wunderground.com/api/2d60985a11fb9a6f/forecast10day/q/CA/San_Francisco.json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:forecastUrl];
    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization
                                    JSONObjectWithData:jsonData options:0 error:&error];
    
    NSDictionary *forecastDictionary = [dataDictionary objectForKey:@"forecast"];
    NSDictionary *forecastDayDictionary = [forecastDictionary objectForKey:@"simpleforecast"];
    
    for (NSDictionary *simpleForecastDictionary in [forecastDayDictionary objectForKey:@"forecastday"]) {
        ForecastDay *currentDay = [[ForecastDay alloc] init];
        
//      Assign all of the values from the API response
//      double epoch = [[simpleForecastDictionary valueForKeyPath:@"date.epoch"] doubleValue];
//      currentDay.date = [NSDate dateWithTimeIntervalSince1970:epoch];
        currentDay.highTemp = [[simpleForecastDictionary valueForKeyPath:@"high.fahrenheit"] intValue];
        currentDay.lowTemp = [[simpleForecastDictionary valueForKeyPath:@"low.fahrenheit"] intValue];
        currentDay.weatherDescription = [simpleForecastDictionary valueForKey:@"conditions"];
        currentDay.weatherIconDescription = [simpleForecastDictionary valueForKey:@"icon"];
        currentDay.weekday = [simpleForecastDictionary valueForKeyPath:@"date.weekday_short"];
        
        NSLog(@"%@", currentDay.weatherIconDescription);
        [forecastDays addObject:currentDay];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(didFetchForecast:)]) {
//      Pass an immutable array now that we're done with making changes to it.
        [self.delegate didFetchForecast:[NSArray arrayWithArray:forecastDays]];
    }
}

//  This will take a URL and convert it to HTTPS if needed.
//  Weather Underground keeps returning insecure URLs, and I don't want to turn the
- (NSURL *)secureUrl:(NSURL *)originalUrl {
    NSURLComponents *components = [NSURLComponents componentsWithURL:originalUrl resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    return components.URL;
}

@end
