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

@interface WeatherManager : NSObject <WeatherServiceDelegate> {
    Location *location;
    WeatherCondition *weatherCondition;
    NSArray *forecastDays;
}

@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) WeatherCondition *weatherCondition;
@property (nonatomic, retain) NSArray *forecastDays;

+ (id)sharedManager;

- (void)refreshData;


@end
