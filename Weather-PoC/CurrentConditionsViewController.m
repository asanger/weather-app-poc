//
//  CurrentConditionsViewController.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "CurrentConditionsViewController.h"

@interface CurrentConditionsViewController ()

@end

@implementation CurrentConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WeatherService *weatherService = [[WeatherService alloc] init];
    weatherService.delegate = self;
    
    [weatherService fetchLocation];
    
    NSString *dateText = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                    dateStyle:NSDateFormatterLongStyle
                                                        timeStyle: NSDateFormatterNoStyle];
    self.dateLabel.text = dateText;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - Delegate Methods

- (void)didFetchLocation:(Location *)location {
    NSLog(@"didFetchLocation");
    
//    Update the root controller's currentLocation. Seems a bit smelly...
    RootTabBarController *tabBarController = (RootTabBarController*)self.tabBarController;
    tabBarController.currentLocation = location;
    
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", location.city, location.state];
    
    WeatherService *weatherService = [[WeatherService alloc] init];
    weatherService.delegate = self;
    
    [weatherService fetchCondition:location];
}


- (void)didFetchCondition:(WeatherCondition *)condition {
    NSLog(@"didFetchCondition");
    
    self.temperatureLabel.text = condition.temperature;
    self.descriptionLabel.text = condition.weatherDescription;
}

@end
