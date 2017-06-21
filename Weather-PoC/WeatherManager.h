//
//  WeatherManager.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/19/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "WeatherCondition.h"
#import "ForecastDay.h"
#import "WeatherService.h"

@interface WeatherManager : NSObject <WeatherServiceDelegate>

@property (strong, nonatomic,) Location *location;
@property (strong, nonatomic) WeatherCondition *weatherCondition;
@property (strong, nonatomic) NSArray *forecastDays;

@property (strong, nonatomic) NSDate *locationUpdatedAt;
@property (strong, nonatomic) NSDate *conditionUpdatedAt;
@property (strong, nonatomic) NSDate *forecastUpdatedAt;


+ (id)sharedWeatherManager;

- (void)refreshData;


@end
