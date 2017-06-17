//
//  WeatherService.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "WeatherService.h"

@implementation WeatherService

-(void)fetchLocation
{
    Location *location = [[Location alloc] init];

    //    We're generating fake data until we hook up to the API
    location.city = @"Clarkston";
    location.state = @"MI";
    location.zip = @"48348";
    
    if ([self.delegate respondsToSelector:@selector(didFetchLocation:)]) {
        [self.delegate didFetchLocation:location];
    }
    
}

-(void)fetchCondition:(Location *)location
{
    WeatherCondition *condition = [[WeatherCondition alloc] init];
    
    condition.temperature = @"48";
    condition.weatherDescription = @"Kinda cold";
    condition.relativeHumidity = @"59%";
    
    if ([self.delegate respondsToSelector:@selector(didFetchCondition:)]) {
        [self.delegate didFetchCondition:condition];
    }
    
}


@end
