//
//  WeatherCondition.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "WeatherCondition.h"

@implementation WeatherCondition

// Automatically format the temperature value for display
- (NSString *)temperature_formatted {
    return [NSString stringWithFormat:@"%i",self.temperature];
}

@end
