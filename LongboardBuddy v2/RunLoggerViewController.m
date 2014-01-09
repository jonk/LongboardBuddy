//
//  RunLoggerViewController.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "RunLoggerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ListOfRunsViewController.h"
#import "TimerWithPause.h"

@interface RunLoggerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *maxSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *curSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgSpeedLabel;
@property (nonatomic, strong) TimerWithPause *timer;
@property (nonatomic) BOOL running;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval stoppedTime;
@property (nonatomic) double maxSpeed;
@property (nonatomic) double avgSpeed;

@end

@implementation RunLoggerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.running = NO;
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
    self.addButton.hidden = YES;
}

- (LocationController *)clController
{
    if (!_clController) {
        _clController = [[LocationController alloc] init];
        _clController.delegate = self;
    }
    return _clController;
}

/** Is executed when the start/pause button is pressed.*/
- (IBAction)startPressed:(UIButton *)sender
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    if (!self.running) {
        self.addButton.hidden = YES;
        self.running = YES;
        NSTimeInterval elapsed = currentTime - self.stoppedTime;
        self.startTime = elapsed;
        [sender setTitle:@"PAUSE" forState:UIControlStateNormal];
        [self.clController.locationManager startUpdatingLocation];
        [self updateTimer];
    } else {
        self.addButton.hidden = NO;
        [self.clController.locationManager stopUpdatingLocation];
        currentTime = [NSDate timeIntervalSinceReferenceDate];
        self.running = NO;
        [sender setTitle:@"START" forState:UIControlStateNormal];
    }
}

/** Performs some simple math to update the timer when it is running using
 *  NS Date. */
- (void)updateTimer
{
    
    if (!self.running) return;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - self.startTime;
    self.stoppedTime = elapsed;
    
    int hours = (int) (elapsed / 3600.0);
    elapsed -= hours * 3600.0;
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    
    self.stopWatchLabel.text = [NSString
                            stringWithFormat:@"%u:%02u:%02u.%u", hours, mins, secs, fraction];
    self.timeString = self.stopWatchLabel.text;
    [self performSelector:@selector(updateTimer) withObject:self afterDelay:0.1];
}

- (void)locationError:(NSError *)error
{
    NSLog(@"We got an Error");
}

- (double)getCurrentSpeedWithLocation:(CLLocation *)location
{
    double speed = [location speed] * 2.24;
    if (speed <= 0) {
        return 0.0;
    }
    return speed;
}

- (void)locationUpdate:(CLLocation *)location
{
    double currentSpeed = [self getCurrentSpeedWithLocation:location];
    if (currentSpeed > self.maxSpeed) {
        self.maxSpeed = currentSpeed;
    }
    self.avgSpeed = (self.avgSpeed + currentSpeed) / 2;
    self.averageSpeedString = [NSString stringWithFormat:@"%f", self.avgSpeed];
    self.maxSpeedString = [NSString stringWithFormat:@"%f", self.maxSpeed];
    self.avgSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", self.avgSpeed];
    self.maxSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", self.maxSpeed];
    self.curSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", currentSpeed];
}


@end
