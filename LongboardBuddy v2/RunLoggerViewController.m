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
@synthesize addButton = _addButton;
@synthesize location = _location;

@synthesize maxSpeed = _maxSpeed;
@synthesize averageSpeed = _averageSpeed;
@synthesize distance = _distance;
@synthesize maxAccel = _maxAccel;
@synthesize maxDecel = _maxDecel;
@synthesize maxGrade = _maxGrade;
@synthesize verticalDrop = _verticalDrop;
@synthesize time = _time;

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
    self.addButton.hidden = YES;
    
    CLController = [[LocationController alloc] init];
    CLController.delegate = self;
    
    maxSpeed = 0.0;
    distance = 0.0;
    oldDistance = 0.0;
    distance = 0.0;
    //startingLocation = [CLController.locationManager location];
    locationLabel.text = @"0.0 mph";
    distanceLabel.text = @"0.0 mi";
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
        startingLocation = [CLController.locationManager location];
        [CLController.locationManager startUpdatingLocation];
        [self updateTimer];
    } else {
        self.addButton.hidden = NO;
        oldDistance = distance;
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

- (IBAction)addRun:(id)sender {
    

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
    distance = oldDistance + [location distanceFromLocation:startingLocation];
    if (currentSpeed > maxSpeed) {
        maxSpeed = currentSpeed;
    }
    self.maxSpeed = [NSString stringWithFormat:@"%f", maxSpeed * 2.24];
    self.distance = [NSString stringWithFormat:@"%f", distance * 0.00062137];
    locationLabel.text = [NSString stringWithFormat:@"%0.2F mph", maxSpeed * 2.24];
    distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", distance * 0.00062137];
}


@end
