//
//  CurrentConditionsViewController.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/16/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"


@interface CurrentConditionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (strong, nonatomic) Location *currentLocation;

@end
