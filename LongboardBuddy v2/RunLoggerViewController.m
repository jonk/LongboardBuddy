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
	running = NO;
    startTime = [NSDate timeIntervalSinceReferenceDate];
    self.addButton.hidden = YES;
    
    CLController = [[LocationController alloc] init];
    CLController.delegate = self;

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

/** Resets the view for whatever reason */
- (void)reset {
    
    running = NO;
    self.addButton.hidden = YES;
    maxSpeed = 0.0;
    distance = 0.0;
    oldDistance = 0.0;
    distance = 0.0;
    avgSpeed = 0.0;
    verticalDrop = 0.0;
    startingHeight = 0.0;
    self.stopWatchLabel.text = @"0:00:00.0";
    self.maxSpeed = @"";
    self.averageSpeed = @"";
    self.distance = @"";
    self.time = @"";
    self.verticalDrop = @"";
    self.maxAccel = @"";
    self.maxDecel = @"";
    self.maxGrade = @"";
    locationLabel.text = @"0.00 mph";
    distanceLabel.text = @"0.00 mi";
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
    self.time = _stopWatchLabel.text;
    [self performSelector:@selector(updateTimer) withObject:self afterDelay:0.1];
}

- (IBAction)addRun:(id)sender {
    
    Run *newRun = [[Run alloc] init];
    
    [newRun addRunWithMaxSpeed:self.maxSpeed averageSpeed:self.averageSpeed distance:self.distance maxAccel:self.maxAccel maxDecel:self.maxDecel maxGrade:self.maxGrade verticalDrop:self.verticalDrop time:self.time];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationError:(NSError *)error {
    //do nothing.
}

- (void)locationUpdate:(CLLocation *)location {
    double currentSpeed = 0.0;
    if ([location speed] >= 0) {
        currentSpeed = [location speed];
    }
    self.location = location;
    distance = oldDistance + [location distanceFromLocation:startingLocation];
    if (currentSpeed > maxSpeed) {
        maxSpeed = currentSpeed;
    }
    avgSpeed = (avgSpeed + currentSpeed) / 2;
    verticalDrop = [location altitude];
    self.averageSpeed = [NSString stringWithFormat:@"%f", avgSpeed * 2.24];
    self.maxSpeed = [NSString stringWithFormat:@"%f", maxSpeed * 2.24];
    self.distance = [NSString stringWithFormat:@"%f", distance * 0.00062137];
    self.verticalDrop = [NSString stringWithFormat:@"%f", verticalDrop * 3.28];
    avgSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", avgSpeed * 2.24];
    locationLabel.text = [NSString stringWithFormat:@"%0.2F mph", maxSpeed * 2.24];
    distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", distance * 0.00062137];
}


@end
