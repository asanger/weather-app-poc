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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayNewConditionData:) name:@"WeatherConditionUpdated" object:nil];
    
    [self populateViewData];
    [self prepareDisplay];
    [self preparePullToRefresh];
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

- (void)preparePullToRefresh {
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:refreshControl];
}

- (void)pullToRefresh {
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            WeatherManager *sharedManager = [WeatherManager sharedManager];
            [sharedManager refreshData];
        });
    });
}

#pragma mark - Animation/Display Methods

- (void)viewWillAppear:(BOOL)animated {
    
    self.temperatureLabel.alpha = 0.0;
    self.descriptionLabel.alpha = 0.0;
    self.locationLabel.alpha = 0.0;
    self.dateLabel.alpha = 0.0;

    self.descriptionLabel.frame = CGRectOffset( self.descriptionLabel.frame, 250, 0);
    self.locationLabel.frame = CGRectOffset( self.locationLabel.frame, -250, 0);
    self.dateLabel.frame = CGRectOffset( self.dateLabel.frame, 0, -250);

    
    [UILabel animateWithDuration:1.0 animations:^{
        self.temperatureLabel.alpha = 1.0;
        self.descriptionLabel.alpha = 1.0;
        self.locationLabel.alpha = 1.0;
        self.dateLabel.alpha = 1.0;
    
        self.descriptionLabel.frame = CGRectOffset( self.descriptionLabel.frame, -250, 0);
        self.locationLabel.frame = CGRectOffset( self.locationLabel.frame, 250, 0);
        self.dateLabel.frame = CGRectOffset( self.dateLabel.frame, 0, 250);
    }];
}

- (void)viewDidLayoutSubviews {
    UIEdgeInsets scrollViewInsets = UIEdgeInsetsZero;
    scrollViewInsets.top = self.scrollView.bounds.size.height/2.0;
    scrollViewInsets.top -= self.containerView.bounds.size.height/2.0;
    scrollViewInsets.bottom = self.scrollView.bounds.size.height/2.0;
    scrollViewInsets.bottom -= self.containerView.bounds.size.height/2.0;
    scrollViewInsets.bottom += 1;
    
    self.scrollView.contentInset = scrollViewInsets;
}


- (void)prepareDisplay {
    //  Add a gradient to the background so it looks a bit nicer.
    UIColor *topColor = [UIColor colorWithRed:126.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithRed:197.0/255.0 green:231.0/255.0 blue:255.0/255.0 alpha:1.0];
    CAGradientLayer *bgGradient = [CAGradientLayer layer];
    bgGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    bgGradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgGradient atIndex:0];
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.containerView.backgroundColor = [UIColor clearColor];
}


- (void)displayNewConditionData:(NSNotification *)notification {
    NSLog(@"displayNewConditionData");
    [self populateViewData];
    
}

- (void)populateViewData {
//    We need to make sure that this *always* runs on the main thread, otherwise we might get crashes or super very delayed updates.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"PopulateViewData");
        //    If the information has not yet been returned from the API, don't attempt to display the data yet.
        WeatherManager *sharedManager = [WeatherManager sharedManager];
        if(sharedManager.conditionUpdatedAt) {
            self.temperatureLabel.text = [NSString stringWithFormat:@"%d", sharedManager.weatherCondition.temperature];
            self.descriptionLabel.text = sharedManager.weatherCondition.weatherDescription;
            self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", sharedManager.location.city, sharedManager.location.state];
        } else {
            self.temperatureLabel.text = @"--";
            self.descriptionLabel.text = @"Loading Data...";
        }
        
        NSString *dateText = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                            dateStyle:NSDateFormatterLongStyle
                                                            timeStyle: NSDateFormatterNoStyle];
        self.dateLabel.text = dateText;
        
        //    If the RefreshControl is still refreshing, end it.
        if(refreshControl.refreshing) {
            [refreshControl endRefreshing];
        }
    });
}

@end
