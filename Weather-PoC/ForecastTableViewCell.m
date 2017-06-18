//
//  ForecastTableViewCell.m
//  Weather-PoC
//
//  Created by Alec Sanger on 6/17/17.
//  Copyright © 2017 Alec Sanger. All rights reserved.
//

#import "ForecastTableViewCell.h"

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//  Make sure that the bg is transparent so we can see the bg of the main view.
- (void)layoutSubviews{
    [super layoutSubviews];

    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}

@end
