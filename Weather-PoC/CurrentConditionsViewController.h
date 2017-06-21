//
//  CurrentConditionsViewController.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "WeatherService.h"
#import "RootTabBarController.h"


@interface CurrentConditionsViewController : UIViewController {
    // TODO: Would prefer to not store this in an instance variable. How can we get it to stop refreshing after `displayNewConditionData` is called?
    UIRefreshControl *refreshControl;
}

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *radarButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
