//
//  RootTabBarController.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "WeatherService.h"
#import "CurrentConditionsViewController.h"
#import "WeatherManager.h"

@interface RootTabBarController : UITabBarController <WeatherServiceDelegate>

@end
