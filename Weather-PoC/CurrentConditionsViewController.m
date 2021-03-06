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
    NSLog(@"CurrentConditionsViewController: viewDidLoad");
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
    NSLog(@"CurrentConditionsViewController: preparePullToRefresh");

    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:refreshControl];
}

- (void)pullToRefresh {
    NSMutableAttributedString *refreshTitle =[[NSMutableAttributedString alloc] initWithString: @"Refreshing..."];
    [refreshTitle setAttributes: @{
                                   NSFontAttributeName:[UIFont fontWithName: @"Avenir Book" size: 17.0],
                                   NSForegroundColorAttributeName:[UIColor whiteColor]
                                   } range: NSMakeRange(0, [refreshTitle length])];

    refreshControl.attributedTitle = refreshTitle;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            WeatherManager *sharedWeatherManager = [WeatherManager sharedWeatherManager];
            [sharedWeatherManager refreshData];
        });
    });
}


#pragma mark - Animation/Display Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"CurrentConditionsViewController: viewWillAppear");

    self.temperatureLabel.alpha = 0.0;
    self.descriptionLabel.alpha = 0.0;
    self.locationLabel.alpha = 0.0;
    self.dateLabel.alpha = 0.0;

//    Set an offset so that they are out of place when the view initially appears.
    self.descriptionLabel.frame = CGRectOffset( self.descriptionLabel.frame, 250, 0);
    self.locationLabel.frame = CGRectOffset( self.locationLabel.frame, -250, 0);
    self.dateLabel.frame = CGRectOffset( self.dateLabel.frame, 0, -250);

//    Animate the reverse of the above offset so that they animate into the correct position.
    [UILabel animateWithDuration:1.0 animations:^{
        self.temperatureLabel.alpha = 1.0;
        self.descriptionLabel.alpha = 1.0;
        self.locationLabel.alpha = 1.0;
        self.dateLabel.alpha = 1.0;
    
        self.descriptionLabel.frame = CGRectOffset( self.descriptionLabel.frame, -250, 0);
        self.locationLabel.frame = CGRectOffset( self.locationLabel.frame, 250, 0);
        self.dateLabel.frame = CGRectOffset( self.dateLabel.frame, 0, 250);
    }];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self startRadarAnimation];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"CurrentConditionsViewController: viewDidAppear");

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    Kill the radar animation while we're not on the current VC.
    [self.radarButton.imageView.layer removeAllAnimations];
}


//  Arranges the scrollview properly on the parent view.
//  TODO: Clean up the mixed layout (code vs storyboard).
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"CurrentConditionsViewController: viewDidLayoutSubviews");

    UIEdgeInsets scrollViewInsets = UIEdgeInsetsZero;
    scrollViewInsets.top = self.scrollView.bounds.size.height/2.0;
    scrollViewInsets.top -= self.containerView.bounds.size.height/2.0;
    scrollViewInsets.bottom = self.scrollView.bounds.size.height/2.0;
    scrollViewInsets.bottom -= self.containerView.bounds.size.height/2.0;
    scrollViewInsets.bottom += 1;
    
    self.scrollView.contentInset = scrollViewInsets;
}


- (void)prepareDisplay {
    NSLog(@"CurrentConditionsViewController: prepareDisplay");

    //  Add a gradient to the background so it looks a bit nicer.
    UIColor *topColor = [UIColor colorWithRed:126.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithRed:197.0/255.0 green:231.0/255.0 blue:255.0/255.0 alpha:1.0];
    CAGradientLayer *bgGradient = [CAGradientLayer layer];
    bgGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    bgGradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgGradient atIndex:0];
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.containerView.backgroundColor = [UIColor clearColor];

//    Create the radar arm, add it to the radar button
    radarArmImageView = [[UIImageView alloc] init];
    [radarArmImageView setImage:[UIImage imageNamed:@"RadarArm"]];
    [self.radarButton addSubview:radarArmImageView];
}


- (void)startRadarAnimation {
    NSLog(@"CurrentConditionsViewController: startRadarAnimation");
    
//    If this isn't set in the main queue, position will likely be off.
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CABasicAnimation *radarArmAnimation;
        radarArmAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        radarArmAnimation.fromValue = [NSNumber numberWithFloat:M_PI];
        radarArmAnimation.byValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
        radarArmAnimation.duration = 10.0f;
        radarArmAnimation.repeatCount = HUGE_VALF;
        
        [radarArmImageView setFrame:self.radarButton.imageView.frame];
        [radarArmImageView.layer addAnimation:radarArmAnimation forKey:@"radarArmAnimation"];
        [self.radarButton bringSubviewToFront:radarArmImageView];
    });
}



- (void)displayNewConditionData:(NSNotification *)notification {
    NSLog(@"CurrentConditionsViewController: displayNewConditionData");

    NSLog(@"displayNewConditionData");
    [self populateViewData];
}

- (void)populateViewData {
    NSLog(@"CurrentConditionsViewController: populateViewData");

//    We need to make sure that this *always* runs on the main thread, otherwise we might get crashes or super very delayed updates.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"PopulateViewData");
        //    If the information has not yet been returned from the API, don't attempt to display the data yet.
        WeatherManager *sharedManager = [WeatherManager sharedWeatherManager];
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
