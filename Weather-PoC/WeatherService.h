//
//  WeatherService.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@protocol WeatherServiceDelegate <NSObject>
- (void)didFetchLocation:(Location *)location;
- (void)didFetchCondition:(WeatherCondition *)condition;
@end

@interface WeatherService : NSObject

@property (weak, nonatomic) id <WeatherServiceDelegate> delegate;

- (void)fetchLocation;
- (void)fetchCondition:(Location *)location;

@end
