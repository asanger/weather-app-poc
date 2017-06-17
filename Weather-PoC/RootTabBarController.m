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
    // Do any additional setup after loading the view.

    // Set the current location when this controller loads.
    self.currentLocation = [[Location alloc] init];
    NSLog(@"%@", self.currentLocation.city);
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

@end
