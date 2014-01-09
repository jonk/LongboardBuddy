//
//  RunLoggerViewController.h
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationController.h"

@interface RunLoggerViewController : UIViewController <CoreLocationControllerDelegate>

- (IBAction)startPressed:(id)sender;
- (IBAction)addRun:(id)sender;

/* The location controller */
@property (nonatomic, strong) LocationController *clController;

/* The properties that will be added to a run */
@property (nonatomic, strong) NSString *maxSpeedString;
@property (nonatomic, strong) NSString *averageSpeedString;
@property (nonatomic, strong) NSString *timeString;

@end
