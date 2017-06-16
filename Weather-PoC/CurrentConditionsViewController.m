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
    // Do any additional setup after loading the view.
    
    // Set the current location when this controller loads.
    [self setCurrentLocation];
    
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


- (void)setCurrentLocation {
    Location *location = [[Location alloc] init];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.wunderground.com/api/2d60985a11fb9a6f/geolookup/q/autoip.json"]];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",responseDict);
        
        location.city = [responseDict valueForKeyPath:@"location.city"];
        location.state = [responseDict valueForKeyPath:@"location.state"];
        location.zip = [responseDict valueForKeyPath:@"location.zip"];
        
        self.currentLocation = location;
        
    }];
    
    [dataTask resume];
    
}

@end
