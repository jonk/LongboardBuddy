//
//  RunLoggerViewController.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "RunLoggerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Run.h"
#import "ListOfRunsViewController.h"

@interface RunLoggerViewController ()

@end

@implementation RunLoggerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	running = NO;
    startTime = [NSDate timeIntervalSinceReferenceDate];
    self.addButton.hidden = YES;
    
    _CLController = [[LocationController alloc] init];
    self.CLController.delegate = self;

}

/** Is executed when the start/pause button is pressed.*/
- (IBAction)startPressed:(UIButton *)sender {
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    if (!running) {
        self.addButton.hidden = YES;
        running = YES;
        NSTimeInterval elapsed = currentTime - stoppedTime;
        startTime = elapsed;
        [sender setTitle:@"PAUSE" forState:UIControlStateNormal];
        [self.CLController.locationManager startUpdatingLocation];
        [self updateTimer];
    } else {
        self.addButton.hidden = NO;
        [self.CLController.locationManager stopUpdatingLocation];
        currentTime = [NSDate timeIntervalSinceReferenceDate];
        running = NO;
        [sender setTitle:@"START" forState:UIControlStateNormal];
    }
}

/** Resets the view for whatever reason */
- (void)reset {
    
    running = NO;
    self.addButton.hidden = YES;
    maxSpeed = 0.0;
    avgSpeed = 0.0;
    self.stopWatchLabel.text = @"0:00:00.0";
    self.maxSpeedString = @"";
    self.averageSpeedString = @"";
    self.timeString = @"";
    maxSpeedLabel.text = @"0.00 mph";
    avgSpeedLabel.text = @"0.00 mph";
    
}

/** Performs some simple math to update the timer when it is running using
 *  NS Date. */
- (void)updateTimer {
    
    if (!running) return;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime;
    stoppedTime = elapsed;
    
    int hours = (int) (elapsed / 3600.0);
    elapsed -= hours * 3600.0;
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    
    _stopWatchLabel.text = [NSString
                            stringWithFormat:@"%u:%02u:%02u.%u", hours, mins, secs, fraction];
    self.timeString = _stopWatchLabel.text;
    [self performSelector:@selector(updateTimer) withObject:self afterDelay:0.1];
}

- (IBAction)addRun:(id)sender {
    
}

- (void)locationError:(NSError *)error {
    NSLog(@"We got an Error");
}

- (double)getCurrentSpeedWithLocation:(CLLocation *)location {
    double speed = [location speed] * 2.24;
    if (speed <= 0) {
        return 0.0;
    }
    return speed;
}

- (void)locationUpdate:(CLLocation *)location {
    double currentSpeed = [self getCurrentSpeedWithLocation:location];
    if (currentSpeed > maxSpeed) {
        maxSpeed = currentSpeed;
    }
    avgSpeed = (avgSpeed + currentSpeed) / 2;
    self.averageSpeedString = [NSString stringWithFormat:@"%f", avgSpeed];
    self.maxSpeedString = [NSString stringWithFormat:@"%f", maxSpeed];
    avgSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", avgSpeed];
    maxSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", maxSpeed];
    curSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", currentSpeed];
}


@end
