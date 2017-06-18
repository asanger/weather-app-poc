//
//  WeatherCondition.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherCondition;

@interface WeatherCondition : NSObject

@property (strong, nonatomic) NSString *temperature;
@property (strong, nonatomic) NSString *weatherDescription;
@property (strong, nonatomic) NSString *relativeHumidity;

- (NSString *)temperature_formatted;

@end
