//
//  ForecastDay.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/17/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastDay : NSObject {
    NSDictionary *weatherIconImageNameDictionary;
}

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *weekday;
@property (nonatomic) int highTemp;
@property (nonatomic) int lowTemp;
@property (strong, nonatomic) NSString *weatherDescription;
@property (strong, nonatomic) NSString *weatherIconImageName;
@property (strong, nonatomic) NSString *weatherIconDescription;

@end
