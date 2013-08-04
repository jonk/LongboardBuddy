//
//  RunLoggerViewController.h
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationController.h"

@interface RunLoggerViewController : UIViewController
<CoreLocationControllerDelegate> {
    
    LocationController *CLController;
    IBOutlet UILabel *locationLabel;
    
    bool running;
    NSTimeInterval startTime;
    NSTimeInterval stoppedTime;
    double maxSpeed;
    
}

- (IBAction)startPressed:(id)sender;
- (IBAction)addSesh:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, strong) LocationController *CLController;
@property (nonatomic, strong) CLLocation *location;

@end
