//
//  WeatherService.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "WeatherService.h"

@implementation WeatherService


- (id)init {
//    Load the API key from the bundle so it can be automatically changed based on the build type.
    api_key = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"WEATHER_UNDERGROUND_API_KEY"];

    return self;
}

- (void)fetchLocation
{
    Location *location = [[Location alloc] init];

    NSURL *locationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.wunderground.com/api/%@/geolookup/q/autoip.json",api_key]];
    NSURLRequest *request = [NSURLRequest requestWithURL:locationUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {

                                      if(error) {
                                          NSLog(@"Something has gone terribly wrong! This should really display something to the user...");
                                          return;
                                      }

                                      NSDictionary *dataDictionary = [NSJSONSerialization
                                                                      JSONObjectWithData:data options:0 error:&error];
                                      
                                      location.city = [dataDictionary valueForKeyPath:@"location.city"];
                                      location.state = [dataDictionary valueForKeyPath:@"location.state"];
                                      location.zip = [dataDictionary valueForKeyPath:@"location.zip"];
                                      
                                      if ([self.delegate respondsToSelector:@selector(didFetchLocation:)]) {
                                          [self.delegate didFetchLocation:location];
                                      }
                                  }];
    [task resume];
}

- (void)fetchCondition:(Location *)location
{
    WeatherCondition *condition = [[WeatherCondition alloc] init];
    
    
    NSURL *conditionUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.wunderground.com/api/%@/conditions/q/%@/%@.json", api_key, location.state, location.city]];
    NSURLRequest *request = [NSURLRequest requestWithURL:conditionUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if(error) {
                                          NSLog(@"Something has gone terribly wrong! This should really display something to the user...");
                                          return;
                                      }

                                      NSDictionary *dataDictionary = [NSJSONSerialization
                                                                          JSONObjectWithData:data options:0 error:&error];
                                      
                                      condition.temperature = [[dataDictionary valueForKeyPath:@"current_observation.temp_f"] intValue];
                                      condition.weatherDescription = [dataDictionary valueForKeyPath:@"current_observation.weather"];
                                      condition.relativeHumidity = [dataDictionary valueForKeyPath:@"current_observation.relative_humidity"];
                                      
                                      if ([self.delegate respondsToSelector:@selector(didFetchCondition:)]) {
                                          [self.delegate didFetchCondition:condition];
                                      }
                                      
                                  }];
    [task resume];
}


- (void)fetchForecast:(Location *)location
{
    NSMutableArray *forecastDays = [NSMutableArray array];
    
    NSURL *forecastUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.wunderground.com/api/%@/forecast10day/q/%@/%@.json", api_key, location.state, location.city]];
    NSURLRequest *request = [NSURLRequest requestWithURL:forecastUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {

                                  if(error) {
                                      NSLog(@"Something has gone terribly wrong! This should really display something to the user...");
                                      return;
                                  }

                                    NSDictionary *dataDictionary = [NSJSONSerialization
                                                                  JSONObjectWithData:data options:0 error:&error];
                                      
                                    NSDictionary *forecastDictionary = [dataDictionary objectForKey:@"forecast"];
                                    NSDictionary *forecastDayDictionary = [forecastDictionary objectForKey:@"simpleforecast"];
                                    
                                    for (NSDictionary *simpleForecastDictionary in [forecastDayDictionary objectForKey:@"forecastday"]) {
                                        ForecastDay *currentDay = [[ForecastDay alloc] init];
                                        
                                //      Assign all of the values from the API response
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
                                    
                                  }];
    [task resume];

}

//  This will take a URL and convert it to HTTPS if needed.
//  Weather Underground keeps returning insecure URLs, and I don't want to turn the
- (NSURL *)secureUrl:(NSURL *)originalUrl {
    NSURLComponents *components = [NSURLComponents componentsWithURL:originalUrl resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    return components.URL;
}

@end
