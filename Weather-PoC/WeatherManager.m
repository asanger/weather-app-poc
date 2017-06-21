//
//  WeatherManager.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/19/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "WeatherManager.h"

@implementation WeatherManager

+ (id)sharedWeatherManager {
    static WeatherManager *sharedWeatherManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWeatherManager = [[self alloc] init];
    });
    return sharedWeatherManager;
}

//  Tells the WeatherManager to fetch fresh data from WeatherService and save it.
//  Sends a notification out when fresh data is finished being loaded.
- (void)refreshData {
    NSLog(@"refreshData");

    WeatherService *weatherService = [[WeatherService alloc] init];
    weatherService.delegate = self;
    [weatherService fetchLocation];
}


- (void)didFetchLocation:(Location *)newLocation {
    NSLog(@"didFetchLocation");
    self.location = newLocation;
    self.locationUpdatedAt = [NSDate date];
    
    WeatherService *weatherService = [[WeatherService alloc] init];
    weatherService.delegate = self;

    [weatherService fetchCondition:self.location];
    [weatherService fetchForecast:self.location];
}


- (void)didFetchCondition:(WeatherCondition *)condition {
    NSLog(@"didFetchCondition");
    _weatherCondition = condition;
    self.weatherCondition = condition;
    self.conditionUpdatedAt = [NSDate date];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeatherConditionUpdated" object:nil];
}

- (void)didFetchForecast:(NSArray *)newForecastDays {
    NSLog(@"didFetchForecast");
    self.forecastDays = newForecastDays;
    self.forecastUpdatedAt = [NSDate date];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ForecastUpdated" object:nil];
}

@end
