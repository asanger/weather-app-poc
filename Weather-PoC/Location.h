//
//  Location.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherCondition.h"

@class Location;

@protocol LocationDelegate <NSObject>
- (void)locationDidUpdate;
@end


@interface Location : NSObject

@property (weak, nonatomic) id delegate;

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;

@property (strong, nonatomic) NSDate *updatedAt;

@end
