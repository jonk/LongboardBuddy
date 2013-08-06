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
    IBOutlet UILabel *distanceLabel;
    
    bool running;
    NSTimeInterval startTime;
    NSTimeInterval stoppedTime;
    double maxSpeed;
    double distance;
    double oldDistance;
    CLLocation *startingLocation;
    
}

- (IBAction)startPressed:(id)sender;
- (IBAction)addRun:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, strong) LocationController *CLController;
@property (nonatomic, strong) CLLocation *location;

/* The properties that will be added to a run */
@property (nonatomic, strong) NSString *maxSpeed;
@property (nonatomic, strong) NSString *averageSpeed;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *maxAccel;
@property (nonatomic, strong) NSString *maxDecel;
@property (nonatomic, strong) NSString *maxGrade;
@property (nonatomic, strong) NSString *verticalDrop;
@property (nonatomic, strong) NSString *time;

@end
