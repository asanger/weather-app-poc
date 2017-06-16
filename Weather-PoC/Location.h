//
//  Location.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface Location : NSObject


@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;


//-(id)initWithData:(NSJSONSerialization
@end
