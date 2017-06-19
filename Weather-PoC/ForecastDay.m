//
//  ForecastDay.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/17/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "ForecastDay.h"

@implementation ForecastDay

- (id)init {
    NSMutableDictionary *newImageNameDictionary = [[NSMutableDictionary alloc] init];
    [newImageNameDictionary setObject:@"Sunny" forKey:@"clear"];
    [newImageNameDictionary setObject:@"Sunny" forKey:@"sunny"];
    [newImageNameDictionary setObject:@"Cloudy" forKey:@"cloudy"];
    [newImageNameDictionary setObject:@"PartlyCloudy" forKey:@"partlycloudy"];
    [newImageNameDictionary setObject:@"PartlyCloudy" forKey:@"partlysunny"];
    [newImageNameDictionary setObject:@"PartlyCloudy" forKey:@"mostlycloudy"];
    [newImageNameDictionary setObject:@"PartlyCloudy" forKey:@"mostlysunny"];
    [newImageNameDictionary setObject:@"Rainy" forKey:@"rain"];
    [newImageNameDictionary setObject:@"Rainy" forKey:@"chancerain"];
    [newImageNameDictionary setObject:@"Foggy" forKey:@"fog"];
    [newImageNameDictionary setObject:@"Foggy" forKey:@"hazy"];
    [newImageNameDictionary setObject:@"Stormy" forKey:@"tstorms"];

    weatherIconImageNameDictionary = newImageNameDictionary;
    
    return self;
}

//  Returns the proper image name based on the API response.
//  It's silly to load all of those images over the API - we should just use local assets.
- (NSString *)weatherIconImageName {
    
    if([weatherIconImageNameDictionary objectForKey:_weatherIconDescription]) {
        return ([weatherIconImageNameDictionary objectForKey:_weatherIconDescription]);
    } else {
        //    Just defaulting this to sunny for now, since I only have a handful of icons.
        return @"Sunny";
    }
    
}

@end
