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
    
    IBOutlet UILabel *maxSpeedLabel;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UILabel *avgSpeedLabel;
    
    BOOL running;
    NSTimeInterval startTime;
    NSTimeInterval stoppedTime;
    double maxSpeed;
    double distance;
    double avgSpeed;
    double oldDistance;
}

- (IBAction)startPressed:(id)sender;
- (IBAction)addRun:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, strong) LocationController *CLController;
@property (nonatomic, strong) CLLocation *startLocation;

/* The properties that will be added to a run */
@property (nonatomic, strong) NSString *maxSpeedString;
@property (nonatomic, strong) NSString *averageSpeedString;
@property (nonatomic, strong) NSString *distanceString;
@property (nonatomic, strong) NSString *timeString;

@end
