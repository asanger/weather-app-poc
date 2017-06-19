//
//  RootTabBarController.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//  Initial load of the most recent weather data.
//  If this data gets loaded after any of the View Controllers, a notification will be sent out to tell them to update their display with the latest data.
    WeatherManager *sharedManager = [WeatherManager sharedManager];
    [sharedManager refreshData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if([segue.identifier isEqual: @"CurrentConditionsViewController"]){
//        CurrentConditionsViewController *destinationViewController = [segue destinationViewController];
//    }
    
//}

@end
