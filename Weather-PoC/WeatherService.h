//
//  WeatherService.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "ForecastDay.h"

@protocol WeatherServiceDelegate <NSObject>
- (void)didFetchLocation:(Location *)location;
- (void)didFetchCondition:(WeatherCondition *)condition;
- (void)didFetchForecast:(NSArray *)forecastDays;
@end

@interface WeatherService : NSObject {
    NSString *api_key;
}

@property (weak, nonatomic) id <WeatherServiceDelegate> delegate;

- (void)fetchLocation;
- (void)fetchCondition:(Location *)location;
- (void)fetchForecast:(Location *)location;

@end
