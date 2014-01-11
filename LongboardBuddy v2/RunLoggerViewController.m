//
//  RunLoggerViewController.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "RunLoggerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TimerWithPause.h"

@interface RunLoggerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *maxSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *curSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgSpeedLabel;

@property (nonatomic) double maxSpeed;
@property (nonatomic) double avgSpeed;

@property (nonatomic, strong) TimerWithPause *timer;

@end

@implementation RunLoggerViewController

- (NSMutableArray *)listofRuns
{
    if (!_listofRuns) _listofRuns = [[NSMutableArray alloc] init];
    return _listofRuns;
}

- (LocationController *)clController
{
    if (!_clController) {
        _clController = [[LocationController alloc] init];
        _clController.delegate = self;
    }
    return _clController;
}

- (TimerWithPause *)timer
{
    if (!_timer) _timer = [[TimerWithPause alloc] init];
    return _timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addButton.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.timer initialize];
}

- (IBAction)addRun:(id)sender
{
    Run *run = [[Run alloc] init];
    [run addRunWithMaxSpeed:self.maxSpeedString averageSpeed:self.averageSpeedString time:self.timeString];
    [self.listofRuns addObject:run];
}

- (NSUInteger)numberOfRuns
{
    return [self.listofRuns count];
}

- (Run *)getRunAtIndex:(NSUInteger)index
{
    return self.listofRuns[index];
}

/** Is executed when the start/pause button is pressed.*/
- (IBAction)startPressed:(UIButton *)sender
{
    [self.timer startPressed];
    if ([sender.titleLabel.text isEqualToString:@"START"]) {
        self.addButton.hidden = YES;
        [sender setTitle:@"PAUSE" forState:UIControlStateNormal];
        [self.clController.locationManager startUpdatingLocation];
        [self updateTimer];
    } else {
        self.addButton.hidden = NO;
        [sender setTitle:@"START" forState:UIControlStateNormal];
        [self.clController.locationManager stopUpdatingLocation];
    }
}

- (void)updateTimer
{
    self.stopWatchLabel.text = [self.timer getTime];
    self.timeString = self.stopWatchLabel.text;
    [self performSelector:@selector(updateTimer) withObject:self afterDelay:0.1];
}

- (void)locationError:(NSError *)error
{
    NSLog(@"We got an Error");
}

- (double)getCurrentSpeedWithLocation:(CLLocation *)location
{
    double speed = [self getMPH:[location speed]];
    if (speed <= 0) {
        return 0.0;
    }
    return speed;
}

- (double)getMPH:(double)metersPerSecond
{
    return metersPerSecond * 2.24;
}

- (void)locationUpdate:(CLLocation *)location
{
    double currentSpeed = [self getCurrentSpeedWithLocation:location];
    if (currentSpeed > self.maxSpeed) {
        self.maxSpeed = currentSpeed;
    }
    self.avgSpeed = (self.avgSpeed + currentSpeed) / 2;
    
    self.averageSpeedString = [NSString stringWithFormat:@"%0.2F mph", self.avgSpeed];
    self.maxSpeedString = [NSString stringWithFormat:@"%0.2F mph", self.maxSpeed];
    
    [self updateLocationGUI];
}

- (void)updateLocationGUI
{
    self.avgSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", self.avgSpeed];
    self.maxSpeedLabel.text = [NSString stringWithFormat:@"%0.2F mph", self.maxSpeed];
}


@end
