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
    NSLog(@"Forecast Loaded");
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayNewForecastData:) name:@"ForecastUpdated" object:nil];

    
//    Pull the forecast data from the WeatherManager on initial load.
    WeatherManager *sharedManager = [WeatherManager sharedManager];
    self.forecastDays = sharedManager.forecastDays;
    [self.forecastTableView reloadData];

    [self prepareDisplay];

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
    
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ForecastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ForecastDay *forecastDay = [self.forecastDays objectAtIndex:indexPath.item];
    

    cell.highTempLabel.text = [NSString stringWithFormat:@"%d", forecastDay.highTemp];
    cell.lowTempLabel.text = [NSString stringWithFormat:@"%d", forecastDay.lowTemp];
    cell.dateLabel.text = forecastDay.weekday;
    
    UIImage *image = [UIImage imageNamed:forecastDay.weatherIconImageName];
    cell.weatherImage.image = image;
    [cell.weatherImage setImage:image];

    
    return cell;
}

//  Basic display setup for background colors. For something more complicated I would probably subclass the views and handle the visuals there.
- (void)prepareDisplay {
    //  Make sure that the table view is transparent so we can just set the bg of the primary view.
    self.forecastTableView.backgroundColor = [UIColor clearColor];
    self.forecastTableView.tableHeaderView = nil;
    
//  Create a left->right gradient. No need to apply these to the individual cells since those aren't animated.
//  If we do animate them in the future, we may want to move this to the individual cells so that the gradient moves with them.
    UIColor *leftColor = [UIColor colorWithRed:126.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIColor *rightColor = [UIColor colorWithRed:197.0/255.0 green:231.0/255.0 blue:255.0/255.0 alpha:1.0];
    CAGradientLayer *bgGradient = [CAGradientLayer layer];
    bgGradient.colors = [NSArray arrayWithObjects: (id)leftColor.CGColor, (id)rightColor.CGColor, nil];
    bgGradient.frame = self.view.bounds;
    bgGradient.startPoint = CGPointMake(0.0, 0.5);
    bgGradient.endPoint = CGPointMake(1.0, 0.5);
    [self.view.layer insertSublayer:bgGradient atIndex:0];
}


- (void)displayNewForecastData:(NSNotification *)notification {
    NSLog(@"displayNewForecastData");
    
    WeatherManager *sharedManager = [WeatherManager sharedManager];
    self.forecastDays = sharedManager.forecastDays;
    
    //    We need to make sure that this *always* runs on the main thread, otherwise we might get crashes or super very delayed updates.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.forecastTableView reloadData];
    });
}


#pragma mark - Delegate Methods

// For UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
