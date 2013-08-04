//
//  RunLoggerViewController.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "RunLoggerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RunLoggerViewController ()

@end

@implementation RunLoggerViewController
@synthesize stopWatchLabel = _stopWatchLabel;
@synthesize CLController = _CLController;
@synthesize startButton = _startButton;
@synthesize location = _location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	running = false;
    startTime = [NSDate timeIntervalSinceReferenceDate];
    
    CLController = [[LocationController alloc] init];
    CLController.delegate = self;
    
    maxSpeed = 0.0;
    locationLabel.text = @"0.0 MPH";
}

/** Is executed when the start/pause button is pressed.*/
- (IBAction)startPressed:(UIButton *)sender {
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    if (!running) {
        running = YES;
        NSTimeInterval elapsed = currentTime - stoppedTime;
        startTime = elapsed;
        [sender setTitle:@"PAUSE" forState:UIControlStateNormal];
        [CLController.locationManager startUpdatingLocation];
        [self updateTimer];
    } else {
        [CLController.locationManager stopUpdatingLocation];
        currentTime = [NSDate timeIntervalSinceReferenceDate];
        running = NO;
        [sender setTitle:@"START" forState:UIControlStateNormal];
    }
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
    [self performSelector:@selector(updateTimer) withObject:self afterDelay:0.1];
}

- (IBAction)addSesh:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationError:(NSError *)error {
    //do nothing
}

- (void)locationUpdate:(CLLocation *)location {
    double currentSpeed = [location speed];
    self.location = location;
    if (currentSpeed > maxSpeed) {
        maxSpeed = currentSpeed;
    }
    locationLabel.text = [NSString stringWithFormat:@"%0.2F MPH", maxSpeed * 2.24];
}

@end
