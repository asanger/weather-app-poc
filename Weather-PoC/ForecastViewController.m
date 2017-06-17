//
//  ForecastViewController.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/17/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "ForecastViewController.h"

@interface ForecastViewController ()

@end

@implementation ForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RootTabBarController *tabBarController = (RootTabBarController*)self.tabBarController;
    
    WeatherService *weatherService = [[WeatherService alloc] init];
    weatherService.delegate = self;
    [weatherService fetchForecast:tabBarController.currentLocation];
    // Do any additional setup after loading the view.
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _forecastDays.count;
}

// Set the data for each cell using the index of the cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    
    ForecastDay *forecastDay = [self.forecastDays objectAtIndex:indexPath.item];
    
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ForecastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.highTempLabel.text = [NSString stringWithFormat:@"%d", forecastDay.highTemp];
    cell.lowTempLabel.text = [NSString stringWithFormat:@"%d", forecastDay.lowTemp];
    cell.dateLabel.text = forecastDay.weekday;
    
    return cell;
}


#pragma mark - Delegate Methods

// For UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didFetchForecast:(NSArray *)forecastDays {
    self.forecastDays = forecastDays;
    [self.forecastTableView reloadData];
}

@end
