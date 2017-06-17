//
//  ForecastViewController.h
//  Weather-PoC
//
//  Created by Alec Sanger on 6/17/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastTableViewCell.h"

@interface ForecastViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
//@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;
//@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;

@property (weak, nonatomic) IBOutlet UITableView *forecastTableView;


@end
